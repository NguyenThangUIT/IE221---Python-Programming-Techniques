from abc import ABC, abstractmethod
class Student(ABC):
    def __init__(self, id, name, address, credits, grade):
        self.__id = id
        self.name = name
        self.__address = address
        self.__credits = credits
        self.__grade = grade
    @abstractmethod
    def __str__(self):
        pass
    @abstractmethod
    def graduation(self):
        pass
class Second_Degree_Student(Student):
    def __init__(self, id, name, address, credits, grade, graduation_score):
        super().__init__(id, name, address, credits, grade)
        self.__graduation_score = graduation_score
    def graduation(self):
        if self._Student__credits >= 84 and self._Student__grade >= 5 and self.__graduation_score >= 5:
            return True
        return False
    def __str__(self):
        return f"ID: {self._Student__id}, Name: {self.name}, Address: {self._Student__address}, Credits: {self._Student__credits}, Grade: {self._Student__grade}, Graduation Score: {self.__graduation_score}"
class University_Student(Student):
    def __init__(self, id, name, address, credits, grade, thesis_title, thesis_score):
        super().__init__(id, name, address, credits, grade)
        self.__thesis_title = thesis_title
        self.__thesis_score = thesis_score
    def graduation(self):
        if self._Student__credits >= 120 and self._Student__grade >= 5 and self.__thesis_score >= 5:
            return True
        return False
    def __str__(self):
        return f"ID: {self._Student__id}, Name: {self.name}, Address: {self._Student__address}, Credits: {self._Student__credits}, Grade: {self._Student__grade}, Thesis Title: {self.__thesis_title}, Thesis Score: {self.__thesis_score}"
class University:
    def get_students_list(self):
        return self.__students_list
    def __init__(self, id, name, students_list):
        self.__id = id
        self.name = name
        self.__students_list = students_list
    def student_init(self):
        '''1. Tạo danh sách sinh viên'''
        self.__students_list = [
                Second_Degree_Student(201, "Nguyễn Văn A", "Thủ Đức", 90, 6.5, 7.0),
                Second_Degree_Student(202, "Trần Thị B", "Dĩ An", 85, 7.0, 6.0),
                Second_Degree_Student(203, "Lê Văn C", "Thủ Đức", 88, 6.8, 7.5),
                Second_Degree_Student(204, "Phạm Thị D", "Dĩ An", 92, 7.2, 6.8),
                Second_Degree_Student(205, "Hoàng Văn E", "Thủ Đức", 87, 6.9, 4.0),
                University_Student(301, "Nguyễn Thị F", "Dĩ An", 130, 8.0, "Luận văn 1", 7.5),
                University_Student(302, "Trần Văn G", "Thủ Đức", 125, 7.5, "Luận văn 2", 6.8),
                University_Student(303, "Lê Thị H", "Dĩ An", 128, 7.8, "Luận văn 3", 7.0),
                University_Student(304, "Phạm Văn I", "Thủ Đức", 132, 8.2, "Luận văn 4", 4.0),
                University_Student(305, "Hoàng Thị K", "Dĩ An", 127, 7.6, "Luận văn 5", 6.9) ]
    def display(self):
        '''2. Xuất danh sách sinh viên'''
        map_object = map(lambda sv: print(sv), self.__students_list)
        list(map_object)
    def graduation_evaluation(self):
        '''6. Xét tốt nghiệp'''
        list(map(lambda student: student.graduation(), self.__students_list))
    def display_graduated_students(self):
        '''3. Xuất danh sách các sinh viên đủ điều kiện tốt nghiệp'''
        graduated_students = list(filter(lambda student: student.graduation(), self.__students_list))
        map_object = map(lambda sv: print(sv), graduated_students)
        list(map_object)
    def display_not_graduated_students(self):
        '''4. Xuất danh sách các sinh viên không đủ điều kiện tốt nghiệp'''
        not_graduated_students = list(filter(lambda student: not student.graduation(), self.__students_list))
        map_object = map(lambda sv: print(sv), not_graduated_students)
        list(map_object)
    def find_student_has_max_grade(self):
        '''5. Tìm sinh viên có điểm trung bình cao nhất'''
        sorted_students = sorted(self.__students_list, key=lambda student: student._Student__grade, reverse=True)
        return sorted_students[0]
class Model:
    def __init__(self):
        self.university = University(1, "UIT", [])
    def get_student_list(self):
        return self.university.get_students_list()
    def graduation_evaluation(self):
        self.university.student_init()
        self.university.graduation_evaluation()
class View:
    @classmethod
    def display(self, students_list):
        map_object = map(lambda student: print(student), students_list)
        list(map_object)
    def display_graduated_students(self, graduated_students):
        map_object = map(lambda student: print(student), graduated_students)
        list(map_object)
class Controler:
    def __init__(self, model, view):
        self.model = model
        self.view = view
    def graduation_evaluation(self):
        self.model.graduation_evaluation()
    def display(self):
        self.view.display(self.model.get_student_list())
    def display_graduated_students(self):
        self.view.display_graduated_students(self.model.get_student_list())
    def sorted_student_by_grade(self):
        student_sorted = sorted(self.model.get_student_list(), key=lambda student: student._Student__grade, reverse=True)
        self.view.display(student_sorted)
if __name__ == '__main__':
    university = University(1, "UIT", [])
    print('Test 1. Tạo danh sách sinh viên')
    university.student_init()
    print('Test 2. Xuất danh sách sinh viên')
    university.display()
    print('Test 6. Xét tốt nghiệp')
    university.graduation_evaluation()
    print('Test 3. Xuất danh sách sinh viên đủ điều kiện tốt nghiệp')
    print("Danh sách sinh viên đủ điều kiện tốt nghiệp:")
    university.display_graduated_students()
    print('Test 4. Xuất danh sách sinh viên không đủ điều kiện tốt nghiệp')
    print("Danh sách sinh viên không đủ điều kiện tốt nghiệp:")
    university.display_not_graduated_students()
    print('Test 5. Tìm sinh viên có điểm trung bình cao nhất')
    student_has_max_grade = university.find_student_has_max_grade()
    print(f"Sinh viên có điểm trung bình cao nhất: {student_has_max_grade}")
    print('Test 7. Áp dụng MVC cho bài toán')
    view = View()
    model = Model()
    controler = Controler(model, view)
    controler.graduation_evaluation()
    controler.display()
    controler.display_graduated_students()
    controler.sorted_student_by_grade()