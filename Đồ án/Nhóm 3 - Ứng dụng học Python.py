import tkinter as tk
from tkinter import messagebox
import pyodbc
import webview

# ---- Model ----
class UserModel:
    '''Lớp UserModel chứa các phương thức liên quan đến người dùng 
    trong quá trình đăng nhập, đăng ký liên kết với cơ sở dữ liệu'''
    def __init__(self, conn_str):
        '''Khởi tạo UserModel với chuỗi kết nối cơ sở dữ liệu'''
        self.conn_str = conn_str

    def _connect(self):
        '''Kết nối cơ sở dữ liệu'''
        return pyodbc.connect(self.conn_str)

    def validate_user(self, username, password):
        '''Xác thực người dùng bằng cách kiểm tra tên người dùng và mật khẩu trong cơ sở dữ liệu. 
        Trả về True và thông báo thành công nếu đúng, ngược lại trả về False và thông báo lỗi.'''
        with self._connect() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT password, role FROM Users WHERE username = ?", (username,))
            row = cursor.fetchone()
            if row and password == row[0]:  # So sánh mật khẩu
                return True, "Login successful!"  # Chỉ trả về 2 giá trị (thành công và thông báo)
            return False, "Invalid username or password!"

    def register_user(self, username, email, password, role):
        '''Đăng ký người dùng mới. 
        Kiểm tra xem tên người dùng đã tồn tại chưa, nếu chưa thì thêm người dùng mới vào cơ sở dữ liệu và trả về thông báo thành công.'''
        with self._connect() as conn:
            cursor = conn.cursor()

            # Kiểm tra nếu tên người dùng đã tồn tại trong cơ sở dữ liệu
            cursor.execute("SELECT username FROM Users WHERE username = ?", (username,))
            if cursor.fetchone():
                return False, "Username already exists!"  # Trả về thông báo nếu tên người dùng đã tồn tại

            # Lưu người dùng mới vào cơ sở dữ liệu
            cursor.execute(
                "INSERT INTO Users (username, email, password, role) VALUES (?, ?, ?, ?)",
                (username, email, password, role)
            )
            conn.commit()  # Lưu thay đổi vào cơ sở dữ liệu
            return True, "Registration successful!"  # Trả về thông báo thành công

class LessonModel:
    '''Lớp LessonModel chứa các phương thức liên quan đến bài học'''
    def __init__(self, conn_str):
        '''Khởi tạo LessonModel với chuỗi kết nối cơ sở dữ liệu'''
        self.conn_str = conn_str

    def _connect(self):
        '''Kết nối cơ sở dữ liệu'''
        return pyodbc.connect(self.conn_str)

    def get_all_lessons(self):
        '''Lấy tất cả các bài học từ cơ sở dữ liệu và trả về danh sách các bài học với lesson_id, lesson_name, và description.'''
        with self._connect() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT lesson_id, lesson_name, description FROM Lessons")
            return [{"id": row[0], "name": row[1], "description": row[2]} for row in cursor.fetchall()]
    
    def get_feedback_for_lesson(self, lesson_id):
        '''Lấy tất cả các phản hồi cho một bài học từ cơ sở dữ liệu và trả về danh sách các phản hồi.'''
        with self._connect() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT content FROM Feedback WHERE lesson_id = ?", (lesson_id,))
            return [row[0] for row in cursor.fetchall()]

class MaterialModel:
    '''Lớp MaterialModel chứa các phương thức liên quan đến tài liệu bài học'''
    def __init__(self, conn_str):
        '''Khởi tạo MaterialModel với chuỗi kết nối cơ sở dữ liệu'''
        self.conn_str = conn_str

    def _connect(self):
        '''Kết nối cơ sở dữ liệu'''
        return pyodbc.connect(self.conn_str)

    def get_material_links(self, lesson_id, material_type):
        '''Lấy các liên kết tài liệu (pptx, pdf, video) dựa trên lesson_id và material_type. 
        Nếu material_type không hợp lệ, sẽ hiện ra lỗi ValueError.'''
        query_map = {
            "pptx": "SELECT pptx_link FROM PPTX_Materials WHERE lesson_id = ?",
            "pdf": "SELECT pdf_link FROM PDF_Materials WHERE lesson_id = ?",
            "video": "SELECT video_link FROM Video_Materials WHERE lesson_id = ?"
        }
        if material_type not in query_map:
            raise ValueError("Invalid material type")

        with self._connect() as conn:
            cursor = conn.cursor()
            cursor.execute(query_map[material_type], (lesson_id,))
            return [row[0] for row in cursor.fetchall()]


class QuizModel:
    '''Lớp QuizModel chứa các phương thức liên quan đến câu hỏi trắc nghiệm'''
    def __init__(self, conn_str):
        '''Khởi tạo QuizModel với chuỗi kết nối cơ sở dữ liệu'''
        self.conn_str = conn_str

    def _connect(self):
        '''Kết nối cơ sở dữ liệu'''
        return pyodbc.connect(self.conn_str)

    def add_quiz(self, lesson_id, question, correct_answer):
        '''Thêm câu hỏi mới vào bảng Quizzes với lesson_id, question, và correct_answer.
        Lấy quiz_id cuối cùng và tăng lên 1 để tạo quiz_id mới.'''
        with self._connect() as conn:
            cursor = conn.cursor()

            # Lấy quiz_id cuối cùng và tăng lên 1
            cursor.execute("SELECT MAX(quiz_id) FROM Quizzes")
            last_id = cursor.fetchone()[0]
            new_id = (last_id or 0) + 1

            # Thêm câu hỏi mới vào bảng
            cursor.execute(
                "INSERT INTO Quizzes (quiz_id, lesson_id, question, answer) VALUES (?, ?, ?, ?)",
                (new_id, lesson_id, question, correct_answer)
            )
            conn.commit()

    def delete_quiz(self, quiz_id):
        '''Xóa câu hỏi từ bảng Quizzes dựa trên quiz_id.'''
        with self._connect() as conn:
            cursor = conn.cursor()
            cursor.execute("DELETE FROM Quizzes WHERE quiz_id = ?", (quiz_id,))
            conn.commit()

    def update_quiz(self, quiz_id, new_question, new_answer):
        '''Cập nhật câu hỏi và câu trả lời trong bảng Quizzes dựa trên quiz_id.'''
        with self._connect() as conn:
            cursor = conn.cursor()
            cursor.execute(
                "UPDATE Quizzes SET question = ?, answer = ? WHERE quiz_id = ?", 
                (new_question, new_answer, quiz_id)
            )
            conn.commit()
# ---- Views ----
class LoginView(tk.Toplevel):
    '''Lớp LoginView chứa các phương thức liên quan đến giao diện đăng nhập người dùng'''
    def __init__(self, controller):
        '''Khởi tạo cửa sổ đăng nhập với các trường nhập liệu cho tên người dùng và mật khẩu, cùng với các nút để đăng nhập và chuyển đến màn hình đăng ký.'''
        super().__init__()
        self.controller = controller
        self.title("Login")
        self.geometry("400x300")

        tk.Label(self, text="Username").pack()
        self.username_entry = tk.Entry(self)
        self.username_entry.pack()

        tk.Label(self, text="Password").pack()
        self.password_entry = tk.Entry(self, show='*')
        self.password_entry.pack()

        tk.Button(self, text="Login", command=self.login).pack()
        tk.Button(self, text="Register", command=self.controller.show_register).pack()

    def login(self):
        '''Lấy tên người dùng và mật khẩu từ trường nhập liệu và gọi hàm xử lý đăng nhập từ controller.'''
        username = self.username_entry.get()
        password = self.password_entry.get()
        self.controller.handle_login(username, password)

    def show_message(self, message):
        '''Hiển thị thông báo cho người dùng.'''
        messagebox.showinfo("Info", message)


class RegisterView(tk.Toplevel):
    '''Lớp RegisterView chứa các phương thức liên quan đến giao diện đăng ký người dùng mới'''
    def __init__(self, controller):
        '''Khởi tạo cửa sổ đăng ký với các trường nhập liệu cho tên người dùng, email, mật khẩu, xác nhận mật khẩu, và quyền hạn, cùng với nút để đăng ký.'''
        super().__init__()
        self.controller = controller
        self.title("Register")
        self.geometry("400x400")

        tk.Label(self, text="Username").pack()
        self.username_entry = tk.Entry(self)
        self.username_entry.pack()

        tk.Label(self, text="Email").pack()
        self.email_entry = tk.Entry(self)
        self.email_entry.pack()

        tk.Label(self, text="Password").pack()
        self.password_entry = tk.Entry(self, show='*')
        self.password_entry.pack()

        tk.Label(self, text="Confirm Password").pack()
        self.confirm_password_entry = tk.Entry(self, show='*')
        self.confirm_password_entry.pack()

        tk.Label(self, text="Role").pack()
        self.role_var = tk.StringVar(value="user")
        self.role_var.set("user")

        tk.Button(self, text="Register", command=self.register).pack()

    def register(self):
        '''Lấy thông tin từ các trường nhập liệu và gọi hàm xử lý đăng ký từ controller.'''
        username = self.username_entry.get().strip()
        email = self.email_entry.get().strip()
        password = self.password_entry.get().strip()
        confirm_password = self.confirm_password_entry.get().strip()
        role = self.role_var.get()

        self.controller.handle_register(username, email, password, confirm_password, role)

    def show_message(self, message):
        '''Hiển thị thông báo cho người dùng.'''
        messagebox.showinfo("Info", message)


class MainApp(tk.Toplevel):
    '''Lớp MainApp chứa các phương thức liên quan đến giao diện chính của ứng dụng 
    và các chức năng khác nhau dựa trên quyền hạn của người dùng (admin hoặc user)'''
    def __init__(self, controller, username, user_role):
        '''Khởi tạo cửa sổ chính của ứng dụng với thanh menu và các chức năng khác nhau dựa trên quyền hạn của người dùng (admin hoặc user).'''
        super().__init__()
        self.controller = controller
        self.username = username
        self.user_role = user_role
        self.title("Main Application")
        self.geometry("800x600")

        menubar = tk.Menu(self)

        home_menu = tk.Menu(menubar, tearoff=0)
        home_menu.add_command(label="Trang chủ", command=lambda: self.show_home())
        menubar.add_cascade(label="Trang chủ", menu=home_menu)

        if self.user_role == "admin":
            admin_menu = tk.Menu(menubar, tearoff=0)
            admin_menu.add_command(label="Quản lý bài học", command=self.show_manage_lessons)
            admin_menu.add_command(label="Quản lý câu hỏi", command=self.show_manage_quizzes)
            menubar.add_cascade(label="Quản lý", menu=admin_menu)

        user_menu = tk.Menu(menubar, tearoff=0)
        user_menu.add_command(label="Slide", command=self.show_slide)
        user_menu.add_command(label="Sách tham khảo", command=self.show_book)
        user_menu.add_command(label="Video bài giảng", command=self.show_video)
        user_menu.add_command(label="Bài tập", command=self.show_exercise)
        menubar.add_cascade(label="Chức năng", menu=user_menu)

        self.config(menu=menubar)
        self.content_frame = tk.Frame(self)
        self.content_frame.pack(fill=tk.BOTH, expand=True)

        self.show_home()

    def show_manage_lessons(self):
        '''Hiển thị giao diện quản lý bài học cho admin.'''
        self.clear_content()
        frame = tk.Frame(self.content_frame)
        frame.pack(fill=tk.BOTH, expand=True)
        tk.Label(frame, text="Quản lý bài học").pack(pady=10)
        tk.Button(frame, text="Cập nhật Slide", command=lambda: self.open_link("https://uithcm-my.sharepoint.com/:f:/g/personal/22521329_ms_uit_edu_vn/EkAAsysOaJNHvO72bh8-GEEB5oRZHx3VVm6Fw0vyokoRZw?e=KqFa87")).pack(pady=5)
        tk.Button(frame, text="Cập nhật Sách Tham Khảo", command=lambda: self.open_link("https://uithcm-my.sharepoint.com/:f:/g/personal/22521329_ms_uit_edu_vn/EpH6ZeQxQ45EpApyKMKz-IABpELygpMwdUgmRZajlX1Q0Q?e=B4uZLp")).pack(pady=5)

    def open_link(self, link):
        '''Mở liên kết trong cửa sổ webview.'''
        webview.create_window("Link", link)
        webview.start()

    def show_manage_quizzes(self):
        '''Hiển thị giao diện quản lý câu hỏi cho admin.'''
        self.clear_content()

        tk.Label(self.content_frame, text="Quản Lý Câu Hỏi").pack(pady=10)

        # Dropdown chọn Lesson ID
        tk.Label(self.content_frame, text="Chọn Lesson ID").pack()
        lesson_id_var = tk.StringVar(value="1")
        lesson_id_dropdown = tk.OptionMenu(self.content_frame, lesson_id_var, *range(1, 9), command=lambda _: display_quizzes())
        lesson_id_dropdown.pack()

        # Form thêm câu hỏi
        tk.Label(self.content_frame, text="Câu Hỏi").pack()
        question_entry = tk.Entry(self.content_frame)
        question_entry.pack()

        tk.Label(self.content_frame, text="Đáp Án Đúng").pack()
        correct_answer_entry = tk.Entry(self.content_frame)
        correct_answer_entry.pack()

        def add_quiz():
            '''Thêm câu hỏi mới vào cơ sở dữ liệu và hiển thị lại danh sách câu hỏi.'''
            lesson_id = lesson_id_var.get()
            question = question_entry.get()
            correct_answer = correct_answer_entry.get()
            if lesson_id and question and correct_answer:
                self.controller.add_quiz(lesson_id, question, correct_answer)
                messagebox.showinfo("Success", "Thêm câu hỏi thành công!")
                display_quizzes()
            else:
                messagebox.showerror("Error", "Vui lòng nhập đầy đủ thông tin.")

        tk.Button(self.content_frame, text="Thêm Câu Hỏi", command=add_quiz).pack(pady=5)

        # Hiển thị danh sách câu hỏi
        canvas = tk.Canvas(self.content_frame)
        scrollbar = tk.Scrollbar(self.content_frame, orient="vertical", command=canvas.yview)
        quiz_frame = tk.Frame(canvas)

        quiz_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )

        canvas.create_window((0, 0), window=quiz_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        def display_quizzes():
            '''Hiển thị danh sách câu hỏi cho Lesson ID được chọn.'''
            for widget in quiz_frame.winfo_children():
                widget.destroy()
            quizzes = self.controller.get_quizzes_for_lesson(lesson_id_var.get())
            for quiz in quizzes:
                single_quiz_frame = tk.Frame(quiz_frame)
                single_quiz_frame.pack(fill=tk.X, pady=2)

                quiz_id, question, answer = quiz
                tk.Label(single_quiz_frame, text=f"ID: {quiz_id}, Câu hỏi: {question}, Đáp án: {answer}").pack(side=tk.LEFT)

                def delete_quiz(quiz_id=quiz_id):
                    '''Xóa câu hỏi từ cơ sở dữ liệu và hiển thị lại danh sách câu hỏi.'''
                    self.controller.delete_quiz(quiz_id)
                    messagebox.showinfo("Success", "Xóa câu hỏi thành công!")
                    display_quizzes()

                def edit_quiz(quiz_id=quiz_id, old_question=question, old_answer=answer):
                    '''Hiển thị popup chỉnh sửa câu hỏi và cập nhật câu hỏi trong cơ sở dữ liệu.'''
                    # Tạo popup chỉnh sửa
                    edit_window = tk.Toplevel(self)
                    edit_window.title("Chỉnh Sửa Câu Hỏi")

                    tk.Label(edit_window, text="Câu Hỏi Mới").pack()
                    new_question_entry = tk.Entry(edit_window)
                    new_question_entry.insert(0, old_question)
                    new_question_entry.pack()

                    tk.Label(edit_window, text="Đáp Án Mới").pack()
                    new_answer_entry = tk.Entry(edit_window)
                    new_answer_entry.insert(0, old_answer)
                    new_answer_entry.pack()

                    def save_edit():
                        '''Cập nhật câu hỏi trong cơ sở dữ liệu và đóng popup chỉnh sửa.'''
                        new_question = new_question_entry.get()
                        new_answer = new_answer_entry.get()
                        self.controller.update_quiz(quiz_id, new_question, new_answer)
                        messagebox.showinfo("Success", "Cập nhật câu hỏi thành công!")
                        edit_window.destroy()
                        display_quizzes()

                    tk.Button(edit_window, text="Lưu", command=save_edit).pack(pady=5)

                tk.Button(single_quiz_frame, text="Xóa", command=delete_quiz).pack(side=tk.RIGHT)
                tk.Button(single_quiz_frame, text="Sửa", command=edit_quiz).pack(side=tk.RIGHT)

        display_quizzes()

    def show_home(self):
        '''Hiển thị trang chủ với chào mừng người dùng và thông tin về quyền hạn của họ, cùng với danh sách bài học và phản hồi.'''
        self.clear_content()

        canvas = tk.Canvas(self.content_frame)
        scrollbar = tk.Scrollbar(self.content_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = tk.Frame(canvas)

        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )

        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        tk.Label(scrollable_frame, text=f"Chào {self.username}, bạn đang đăng nhập với vai trò {self.user_role}.").pack(pady=10)

        if self.user_role == "admin":
            tk.Label(scrollable_frame, text="Bạn là Admin, có quyền quản lý hệ thống.").pack(pady=10)
        else:
            tk.Label(scrollable_frame, text="Bạn là User, chỉ có thể làm bài tập và xem bài học.").pack(pady=10)

        lessons = self.controller.get_lessons_with_feedback()
        for lesson in lessons:
            tk.Label(scrollable_frame, text=f"{lesson['id']} - {lesson['name']}").pack(pady=5, anchor="w")
            tk.Label(scrollable_frame, text=lesson['description']).pack(pady=5, anchor="w")
            tk.Label(scrollable_frame, text="Feedback:").pack(pady=5, anchor="w")
            for feedback in lesson['feedback']:
                tk.Label(scrollable_frame, text=f"- {feedback}").pack(pady=2, anchor="w")

    def show_slide(self):
        '''Hiển thị trang Slide với các liên kết tài liệu pptx.'''
        self.clear_content()

        lessons = self.controller.get_lessons()
        for lesson in lessons:
            lesson_id = lesson["id"]
            lesson_name = lesson["name"]
            pptx_links = self.controller.get_material_links(lesson_id, "pptx")
            for link in pptx_links:
                tk.Button(self.content_frame, text=f"{lesson_id} - {lesson_name}",
                          command=lambda l=link: self.open_pptx_link(l)).pack(pady=5)

    def open_pptx_link(self, link):
        '''Mở liên kết pptx trong cửa sổ webview.'''
        webview.create_window("Slide", link)
        webview.start()

    def show_book(self):
        '''Hiển thị trang Sách tham khảo với các liên kết tài liệu pdf.'''
        self.clear_content()

        lessons = self.controller.get_lessons()
        for lesson in lessons:
            lesson_id = lesson["id"]
            lesson_name = lesson["name"]
            tk.Button(self.content_frame, text=f"{lesson_id} - {lesson_name}",
                      command=lambda id=lesson_id: self.show_pdf_links(id)).pack(pady=5)

    def show_pdf_links(self, lesson_id):
        '''Hiển thị các liên kết pdf cho mỗi bài học.'''
        self.clear_content()

        pdf_links = self.controller.get_material_links(lesson_id, "pdf")
        for i, link in enumerate(pdf_links):
            tk.Button(self.content_frame, text=f"Book {i + 1}",
                      command=lambda l=link: self.open_pdf_link(l)).pack(pady=2)

    def open_pdf_link(self, link):
        '''Mở liên kết pdf trong cửa sổ webview.'''
        webview.create_window("Book", link)
        webview.start()

    def show_video(self):
        '''Hiển thị trang Video bài giảng với các liên kết video.'''
        self.clear_content()

        lessons = self.controller.get_lessons()
        for lesson in lessons:
            lesson_id = lesson["id"]
            lesson_name = lesson["name"]
            tk.Button(self.content_frame, text=f"{lesson_id} - {lesson_name}",
                      command=lambda id=lesson_id: self.show_video_links(id)).pack(pady=5)

    def show_video_links(self, lesson_id):
        '''Hiển thị các liên kết video cho mỗi bài học.'''
        self.clear_content()

        video_links = self.controller.get_material_links(lesson_id, "video")
        for i, link in enumerate(video_links):
            tk.Button(self.content_frame, text=f"Video {i + 1}",
                      command=lambda l=link: self.open_video_link(l)).pack(pady=2)

    def open_video_link(self, link):
        '''Mở liên kết video trong cửa sổ webview.'''
        webview.create_window("Video", link)
        webview.start()
    
    def show_exercise(self):
        '''Hiển thị trang Bài tập với các bài tập cho từng bài học.'''
        self.clear_content()
        tk.Label(self.content_frame, text="Trang Bài tập").pack(pady=10)
        self.show_quizzes()

    def show_quizzes(self):
        '''Hiển thị danh sách bài học và bài tập cho người dùng.'''
        self.clear_content()

        tk.Label(self.content_frame, text="Danh sách Bài học").pack(pady=10)

        lessons = self.controller.get_lessons()
        for lesson in lessons:
            lesson_button = tk.Button(
                self.content_frame,
                text=lesson["name"],
                cursor="hand2",
                command=lambda lesson_id=lesson["id"]: self.show_lesson_quizzes(lesson_id)
            )
            lesson_button.pack(pady=5)

    def show_lesson_quizzes(self, lesson_id):
        '''Hiển thị bài tập cho một bài học cụ thể.'''
        self.clear_content()

        tk.Label(self.content_frame, text=f"Bài tập cho bài học {lesson_id}").pack(pady=10)

        quizzes = self.controller.get_quizzes_for_lesson(lesson_id)
        self.quiz_data = quizzes
        self.current_question_index = 0

        def display_question():
            '''Hiển thị câu hỏi và các lựa chọn trả lời cho người dùng.'''
            self.clear_content()

            if self.current_question_index < len(self.quiz_data):
                quiz_id, full_question, correct_answer = self.quiz_data[self.current_question_index]

                question_parts = full_question.split("\n")
                question_text = question_parts[0]
                answer_choices = question_parts[1:]

                tk.Label(self.content_frame, text=f"Câu {quiz_id}: {question_text}").pack(pady=10)

                button_frame = tk.Frame(self.content_frame)
                button_frame.pack(pady=10)

                def check_answer(selected_choice):
                    '''Kiểm tra câu trả lời của người dùng và hiển thị kết quả.'''
                    if selected_choice == correct_answer[0]:
                        result_text = "Đúng!"
                    else:
                        result_text = "Sai!"
                    tk.Label(self.content_frame, text=result_text).pack(pady=10)

                    next_button = tk.Button(self.content_frame, text="Câu tiếp theo", command=next_question)
                    next_button.pack(pady=10)

                for choice in answer_choices:
                    tk.Button(
                        button_frame,
                        text=choice,
                        command=lambda c=choice[0]: check_answer(c)
                    ).pack(side=tk.LEFT, padx=5)
            else:
                tk.Label(self.content_frame, text="Bạn đã hoàn thành bài tập!").pack(pady=20)

        def next_question():
            '''Chuyển đến câu hỏi tiếp theo nếu có, ngược lại hiển thị thông báo hoàn thành bài tập.'''
            self.current_question_index += 1
            display_question()

        display_question()

    def clear_content(self):
        '''Xóa nội dung hiện tại của cửa sổ chính.'''
        for widget in self.content_frame.winfo_children():
            widget.destroy()

# ---- Controller ----
class AppController:
    '''Lớp AppController chứa các phương thức liên quan đến điều khiển ứng dụng
    và các mô hình (UserModel, LessonModel, MaterialModel, QuizModel) liên kết với cơ sở dữ liệu 
    và các giao diện (LoginView, RegisterView, MainApp) của ứng dụng.'''
    def __init__(self, conn_str):
        '''Khởi tạo đối tượng với chuỗi kết nối cơ sở dữ liệu và các mô hình (UserModel, LessonModel, MaterialModel, QuizModel).
        Khởi tạo các thuộc tính cho các cửa sổ giao diện và vai trò người dùng.'''
        self.conn_str = conn_str
        self.user_model = UserModel(conn_str)
        self.lesson_model = LessonModel(conn_str)
        self.material_model = MaterialModel(conn_str)
        self.quiz_model = QuizModel(conn_str)

        self.root = tk.Tk()
        self.root.withdraw()
        self.login_view = None
        self.register_view = None
        self.main_app = None
        self.user_role = None

    def show_login(self):
        '''Hiển thị cửa sổ đăng nhập. Nếu cửa sổ đăng ký đang mở, nó sẽ bị đóng.'''
        if self.register_view:
            self.register_view.destroy()
        self.login_view = LoginView(self)

    def show_register(self):
        '''Hiển thị cửa sổ đăng ký. Nếu cửa sổ đăng nhập đang mở, nó sẽ bị đóng.'''
        if self.login_view:
            self.login_view.destroy()
        self.register_view = RegisterView(self)

    def handle_login(self, username, password):
        ''': Xử lý đăng nhập bằng cách xác thực người dùng qua UserModel. 
        Nếu thành công, lấy vai trò người dùng và hiển thị thông báo thành công, sau đó chuyển đến màn hình chính. 
        Nếu thất bại, hiển thị thông báo lỗi.'''
        success, message = self.user_model.validate_user(username, password)
        if success:
            self.user_role = self.get_user_role(username)  # Lấy vai trò của người dùng từ cơ sở dữ liệu
            self.login_view.show_message(message)
            self.login_view.destroy()
            self.show_main_app(username)
        else:
            self.login_view.show_message(message)
    
    def get_user_role(self, username):
        '''Lấy vai trò của người dùng từ cơ sở dữ liệu dựa trên tên người dùng.'''
        # Lấy vai trò người dùng từ cơ sở dữ liệu
        with pyodbc.connect(self.conn_str) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT role FROM Users WHERE username = ?", (username,))
            row = cursor.fetchone()
            if row:
                return row[0]  # Trả về vai trò (user/admin)
            return None

    def handle_register(self, username, email, password, confirm_password, role):
        ''' Xử lý đăng ký người dùng mới. 
        Kiểm tra mật khẩu xác nhận, nếu khớp thì gọi UserModel để đăng ký người dùng mới và hiển thị thông báo tương ứng.'''
        if password != confirm_password:
            self.register_view.show_message("Passwords do not match!")
            return
        success, message = self.user_model.register_user(username, email, password, role)
        self.register_view.show_message(message)
        if success:
            self.register_view.destroy()
            self.show_login()

    def show_main_app(self, username):
        '''Hiển thị cửa sổ chính của ứng dụng với tên người dùng và quyền hạn.'''
        self.main_app = MainApp(self, username, self.user_role)

    def get_lessons(self):
        '''Lấy danh sách các bài học từ LessonModel.'''
        return self.lesson_model.get_all_lessons()
    
    def get_lessons_with_feedback(self):
        '''Lấy danh sách bài học cùng với feedback tương ứng.'''
        lessons = self.lesson_model.get_all_lessons()
        for lesson in lessons:
            lesson['feedback'] = self.lesson_model.get_feedback_for_lesson(lesson['id'])
        return lessons

    def get_material_links(self, lesson_id, material_type):
        '''Lấy các liên kết tài liệu từ MaterialModel dựa trên lesson_id và material_type.'''
        return self.material_model.get_material_links(lesson_id, material_type)

    def get_quizzes_for_lesson(self, lesson_id):
        '''Lấy danh sách câu hỏi cho mỗi bài học từ QuizModel.'''
        with pyodbc.connect(self.conn_str) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT quiz_id, question, answer FROM Quizzes WHERE lesson_id = ?", (lesson_id,))
            return cursor.fetchall()
    
    def add_quiz(self, lesson_id, question, correct_answer):
        '''Thêm câu hỏi mới vào cơ sở dữ liệu từ QuizModel.''' 
        if not lesson_id.isdigit() or not (1 <= int(lesson_id) <= 8):
            messagebox.showerror("Error", "Lesson ID phải từ 1 đến 8.")
            return
        self.quiz_model.add_quiz(lesson_id, question, correct_answer)

    def delete_quiz(self, quiz_id):
        '''Xóa câu hỏi từ cơ sở dữ liệu từ QuizModel.'''
        self.quiz_model.delete_quiz(quiz_id)

    def update_quiz(self, quiz_id, new_question, new_answer):
        '''Cập nhật câu hỏi trong cơ sở dữ liệu từ QuizModel.'''
        self.quiz_model.update_quiz(quiz_id, new_question, new_answer)

    def run(self):
        '''Chạy ứng dụng bắt đầu bằng việc hiển thị cửa sổ đăng nhập.'''
        self.show_login()
        self.root.mainloop()
        
# ---- Main Application ----
if __name__ == "__main__":
    conn_str = "DRIVER={SQL Server};SERVER=LUNARINE;DATABASE=LearningApp;UID=;PWD=" #chỉnh sửa lại thông tin kết nối
    app = AppController(conn_str)
    app.run()