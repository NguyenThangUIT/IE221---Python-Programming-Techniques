from abc import ABC, abstractmethod
class abcEmployee(ABC):
    @abstractmethod
    def __init__(self, id, name, base_salary, month_salary):
        pass
    @abstractmethod
    def calculate_salary(self):
        pass
    @abstractmethod
    def get_id(self):
        pass
    @abstractmethod
    def get_base_salary(self):
        pass
    @abstractmethod
    def get_month_salary(self):
        pass
class Employee(abcEmployee):
    def __init__(self, id, name, base_salary, month_salary):
        self.__id = id
        self.name = name
        self.__base_salary = base_salary
        self.__month_salary = month_salary
    def calculate_salary(self):
        pass
    def __str__(self):
        pass
    def get_id(self):
        return self.__id
    def get_base_salary(self):
        return self.__base_salary
    def get_month_salary(self):
        return self.__month_salary
class Office_Staff(Employee):
    def __init__(self, id, name, base_salary, month_salary, workdays):
        super().__init__(id, name, base_salary, month_salary)
        self.__workdays = workdays
    def calculate_salary(self):
        self.__month_salary = self.get_base_salary() + self.__workdays * 180000
        if self.__month_salary > 8000000:
            self.__month_salary *= 1.05
        return self.__month_salary
    def __str__(self):
        return f"ID: {self.get_id()}, Name: {self.name}, Base Salary: {self.get_base_salary()}, Workdays: {self.__workdays}, Month Salary: {self.__month_salary}"
    def get_workdays(self):
        return self.__workdays
class Sales_Staff(Employee):
    def __init__(self, id, name, base_salary, month_salary, sales):
        super().__init__(id, name, base_salary, month_salary)
        self.__sales = sales
    def calculate_salary(self):
        self.__month_salary = self.get_base_salary() + self.__sales * 120000
        if self.__month_salary > 8000000:
            self.__month_salary *= 1.05
        elif self.__month_salary < 5000000:
            self.__month_salary *= 1.30
        return self.__month_salary
    def __str__(self):
        return f"ID: {self.get_id()}, Name: {self.name}, Base Salary: {self.get_base_salary()}, Sales: {self.__sales}, Month Salary: {self.__month_salary}"
    def get_sales(self):
        return self.__sales
class Company:
    def __init__(self, id, name, employees_list):
        self.__id = id
        self.name = name
        self.__employees_list = employees_list
    def get_employees_list(self):
        return self.__employees_list
    def employee_init(self):
        '''Khởi tạo danh sách nhân viên'''
        self.__employees_list = [
            Office_Staff(123, "Nguyen A", 4_500_000, 0, 25),
            Sales_Staff(124, "Nguyen B", 5_600_000, 0, 20),
            Office_Staff(125, "Nguyen C", 7_800_000, 0, 30),
            Sales_Staff(126, "Nguyen D", 8_100_000, 0, 15),
            Office_Staff(127, "Nguyen E", 9_500_000, 0, 28),
            Sales_Staff(128, "Nguyen F", 6_500_000, 0, 10),
            Office_Staff(129, "Nguyen G", 4_500_000, 0, 25),
            Sales_Staff(130, "Nguyen H", 5_600_000, 0, 20),]
    def calculate_salary(self):
        '''2. Tính và cập nhật tiền lương cho tất cả nhân viên'''
        list(map(lambda employee: employee.calculate_salary(), self.__employees_list))
    def display(self):
        '''1. Xuất danh sách nhân viên'''
        map_object = map(lambda employee: print(employee), self.__employees_list)
        list(map_object)
    def find_employee(self, id):
        '''3. Tìm nhân viên theo mã nhân viên'''
        employee = next(map(lambda emp: emp if emp.get_id() == id else None, self.__employees_list), None)
        return employee
    def find_employee_has_min_salary(self):
        '''4. Tìm nhân viên có lương thấp nhất'''
        sorted_employees_list = sorted(self.__employees_list, key=lambda employee: employee.calculate_salary(), reverse=True)
        return sorted_employees_list[0]
    def find_sales_staff_has_max_salary(self):
        '''5. Tìm nhân viên bán hàng có lương cao nhất'''
        sales_staff_list = list(filter(lambda employee: isinstance(employee, Sales_Staff), self.__employees_list))
        sorted_sales_staff_list = sorted(sales_staff_list, key=lambda employee: employee.calculate_salary())
        return sorted_sales_staff_list[0]
    def find_top_10_employee_has_max_salary(self):
        '''6. Tìm 10 nhân viên có lương cao nhất'''
        sorted_employees_list = sorted(self.__employees_list, key=lambda employee: employee.calculate_salary())
        return sorted_employees_list[:10]
class Model:
    def __init__(self):
        self.company = Company(1, "Company", [])
    def get_employee_list(self):
        return self.company.get_employees_list()
    def calculate_salary(self):
        self.company.employee_init()
        self.company.calculate_salary()
class View:
    @classmethod
    def display(self, employees_list):
        for employee in employees_list:
            print(employee)
class Controller:
    def __init__(self, model, view):
        self.model = model
        self.view = view
    def get_employee_list(self):
        return self.model.get_employee_list()
    def calculate_salary(self):
        self.model.calculate_salary()
    def display(self):
        employees_list = self.get_employee_list()
        self.view.display(employees_list)
    def find_employee(self, id):
        return self.model.company.find_employee(id)
    def find_employee_has_min_salary(self):
        return self.model.company.find_employee_has_min_salary()
    def find_sales_staff_has_max_salary(self):
        return self.model.company.find_sales_staff_has_max_salary()
    def find_top_10_employee_has_max_salary(self):
        return self.model.company.find_top_10_employee_has_max_salary()
if __name__ == '__main__':
    company = Company(1, "Company", [])
    company.employee_init()
    print('Test 2. Tính và cập nhật tiền lương cho tất cả nhân viên')
    company.calculate_salary()
    print('Test 1. Xuất danh sách nhân viên')
    company.display()
    print('Test 3. Tìm nhân viên theo mã nhân viên')
    employee = company.find_employee(125)
    print(employee)
    print('Test 4. Tìm nhân viên có lương thấp nhất')
    min_salary_employee = company.find_employee_has_min_salary()
    print(min_salary_employee)
    print('Test 5. Tìm nhân viên bán hàng có lương cao nhất')
    max_salary_sales_staff = company.find_sales_staff_has_max_salary()
    print(max_salary_sales_staff)
    print('Test 6. Tìm 10 nhân viên có lương cao nhất')
    top_10_employee = company.find_top_10_employee_has_max_salary()
    for employee in top_10_employee:
        print(employee)
    print('Test 7. Áp dụng MVC cho bài toán')
    model = Model()
    view = View()
    controller = Controller(model, view)
    controller.calculate_salary()
    controller.display()
    employee = controller.find_employee(127)
    print(employee)
    min_salary_employee = controller.find_employee_has_min_salary()
    print(min_salary_employee)
    max_salary_sales_staff = controller.find_sales_staff_has_max_salary()
    print(max_salary_sales_staff)
    top_10_employee = controller.find_top_10_employee_has_max_salary()
    for employee in top_10_employee:
        print(employee)