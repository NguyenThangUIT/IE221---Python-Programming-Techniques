from abc import ABC, abstractmethod
class Employee(ABC):
    def __init__(self, id, name, base_salary, coefficient):
        self.__id = id
        self.name = name
        self.__base_salary = base_salary
        self.__coefficient = coefficient
    @abstractmethod
    def __str__(self):
        pass
    @abstractmethod
    def calculate_salary(self):
        pass
class Specialist(Employee):
    def __init__(self, id, name, base_salary, coefficient, overtime, salary):
        super().__init__(id, name, base_salary, coefficient)
        self.__overtime = overtime
        self.__salary = salary
    def calculate_salary(self):
        self.__salary = self._Employee__base_salary + (self._Employee__base_salary * self._Employee__coefficient) + (self.__overtime * 180000)
        return self.__salary
    def __str__(self):
        return f"ID: {self._Employee__id}, Name: {self.name}, Base Salary: {self._Employee__base_salary}, Coefficient: {self._Employee__coefficient}, Overtime: {self.__overtime}, Salary: {self.__salary}"
class Researcher(Employee):
    def __init__(self, id, name, base_salary, coefficient, project, salary):
        super().__init__(id, name, base_salary, coefficient)
        self.__project = project
        self.__salary = salary
    def calculate_salary(self):
        self.__salary = self._Employee__base_salary + (self._Employee__base_salary * (self._Employee__coefficient - 0.2)) + (self.__project * 5500000)
        return self.__salary
    def __str__(self):
        return f"ID: {self._Employee__id}, Name: {self.name}, Base Salary: {self._Employee__base_salary}, Coefficient: {self._Employee__coefficient}, Project: {self.__project}, Salary: {self.__salary}"
class Manager(Employee):
    def __init__(self, id, name, base_salary, coefficient, experience, salary):
        super().__init__(id, name, base_salary, coefficient)
        self.__experience = experience
        self.__salary = salary
    def calculate_salary(self):
        self.__salary = self._Employee__base_salary * 0.7 + self._Employee__base_salary * self._Employee__coefficient + self.__experience * self._Employee__base_salary
        return self.__salary
    def __str__(self):
        return f"ID: {self._Employee__id}, Name: {self.name}, Base Salary: {self._Employee__base_salary}, Coefficient: {self._Employee__coefficient}, Experience: {self.__experience}, Salary: {self.__salary}"
class Tech_Center:
    def __init__(self, id, name, employees_list):
        self.__id = id
        self.name = name
        self.__employees_list = employees_list
    def get_employees_list(self):
        return self.__employees_list
    def employee_init(self):
        '''7. Khởi tạo danh sách nhân viên'''
        self.__employees_list = [
            Specialist(123, "Nguyen A", 4_500_000, 0.5, 50, 0),
            Researcher(124, "Nguyen B", 5_600_000, 1.2, 10, 0),
            Manager(125, "Nguyen C", 7_800_000, 1.5, 1.3, 0),
            Researcher(126, "Nguyen D", 8_100_000, 0.8, 12, 0),
            Manager(127, "Nguyen E", 9_500_000, 1.0, 1.6, 0),
            Specialist(128, "Nguyen F", 6_500_000, 0.8, 30, 0)]
    def calculate_salary(self):
        '''2. Tính lương cho tất cả nhân viên'''
        list(map(lambda employee: employee.calculate_salary(), self.__employees_list))
    def display(self):
        '''1. Xuất thông tin tất cả nhân viên'''
        map_object = map(lambda nv: print(nv), self.__employees_list)
        list(map_object)
    def find_employee_by_id(self, id):
        '''3. Tìm nhân viên theo ID'''
        employee = next(map(lambda emp: emp if emp._Employee__id == id else None, self.__employees_list), None)
        return employee
    def calculate_all_employee_salary(self):
        '''4. Tính tổng số tiền lương phải trả cho tất cả nhân viên'''
        return sum(employee.calculate_salary() for employee in self.__employees_list)
    def find_employee_has_max_salary(self):
        '''5. Tìm nhân viên có lương cao nhất'''
        sorted_employees = sorted(self.__employees_list, key=lambda emp: emp.calculate_salary(), reverse=True)
        return sorted_employees[0]
    def update_employee_base_salary(self, id, new_base_salary):
        '''6. Cập nhật lương cơ bản theo mã nhân viên'''
        employee = self.find_employee_by_id(id)
        if employee:
            employee._Employee__base_salary = new_base_salary
            employee.calculate_salary()
            return employee
        return False
class Model:
    def __init__(self):
        self.tech_center = Tech_Center(1, "Tech Center", [])
    def get_employee_list(self):
        return self.tech_center.get_employees_list()
    def calculate_salary(self):
        self.tech_center.employee_init()
        self.tech_center.calculate_salary()
class View:
    @classmethod
    def display_employee_list(cls, employee_list):
        for employee in employee_list:
            print(employee)
class Controler:
    def __init__(self, model, view):
        self.model = model
        self.view = view
    def calculate_salary(self):
        self.model.calculate_salary()
    def display_employee_list(self):
        self.view.display_employee_list(self.model.get_employee_list())
    def sort_employee_by_salary(self):
        employee_sort = self.model.get_employee_list()
        sorted_employees = sorted(employee_sort, key=lambda emp: emp.calculate_salary())
        self.view.display_employee_list(sorted_employees)
if __name__ == '__main__':
    tech_center = Tech_Center(1, "UIT Tech Center", [])
    print('Test 7. Khởi tạo nhanh 6 nhân viên có dữ liệu sau (không dùng hàm input).')
    tech_center.employee_init()
    print('Test 2. Thực hiện việc tính lương cho từng nhân viên.')
    tech_center.calculate_salary()
    print('Test 1. Xuất thông tin tất cả nhân viên.')
    tech_center.display()
    print('Test 3. Tìm kiếm nhân viên theo mã nhân viên.')
    id = int(input('Nhập mã nhân viên cần tìm: '))
    employee = tech_center.find_employee_by_id(id)
    print(f'Nhân viên có mã nhân viên {id}: {employee}')
    print('Test 4. Tính tổng số tiền phải trả cho tất cả nhân viên.')
    total_salary = tech_center.calculate_all_employee_salary()
    print(f"Tổng lương của tất cả nhân viên: {total_salary}")
    print('Test 5. Tìm nhân viên có tổng lương cao nhất.')
    max_salary_employee = tech_center.find_employee_has_max_salary()
    print(f"Nhân viên có lương cao nhất: {max_salary_employee}")
    print('Test 6. Cập nhật lương cơ bản theo mã nhân viên.')
    updated_employee = tech_center.update_employee_base_salary(123, 5_000_000)
    print(f"Đã cập nhật lương cơ bản cho nhân viên: {updated_employee}")
    print('Test 8. Áp dụng MVC cho bài toán.')
    view = View()
    model = Model()
    controler = Controler(model, view)
    controler.calculate_salary()
    controler.display_employee_list()
    controler.sort_employee_by_salary()