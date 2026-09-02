using System;

namespace OOPs
{
    class Program
    {
        static void Main(string[] args)
        {
            Encapsulation();
        }

        public static void Encapsulation()
        {
            List<Employee> employees = new List<Employee>();
            while (true)
            {
                Employee emp = new Employee();
                GetEmployeeData(emp);
                employees.Add(emp);
                Console.Write("Do you want to add another employee? (yes/no): ");
                string? choice = Console.ReadLine();

                if (choice?.ToLower() == "no")
                {
                    break;
                }
                else if (choice?.ToLower() == "yes")
                {
                    continue;
                }
                else
                {
                    Console.WriteLine("Please Enter a Valid Choice");
                    continue;
                }
            }
                Console.WriteLine($"Emp-ID:{employees[0].Id}");
                Console.WriteLine($"Name:{employees[0].Name}");
                //Console.WriteLine($"Salary:{employees[0].Salary}");
                //employees[0].ViewSalary();
            while (true)
            {
                Console.WriteLine();
                Console.WriteLine($"Total number of employees: {employees.Count}");
                for (int i = 1; i <= employees.Count; i++)
                {
                    Console.WriteLine($"{i}. {employees[i - 1].Name}");
                }
                while (true)
                {
                    try
                    {
                        Console.Write("Enter employee number to show details:");
                        int.TryParse(Console.ReadLine(), out int option);
                        int index = option - 1;
                        Employee selectedEmployee = employees[index];
                        Console.WriteLine($"Employee ID: {selectedEmployee.Id}");
                        Console.WriteLine($"Employee Name: {selectedEmployee.Name}");
                        selectedEmployee.ViewSalary();
                        break;
                    }
                    catch
                    {
                        Console.WriteLine("Please select valid option");
                        continue;
                    }
                }
                break;
            }
        }

        public static void GetEmployeeData(Employee employee)
        {
            while (true)
            {
                Console.Write("Enter Employee ID: ");
                int.TryParse(Console.ReadLine(), out int id);

                if (id < 100 || id > 999)
                {
                    Console.WriteLine("Please Enter 3 Digits for valid ID");
                    continue;
                }

                employee.Id = id;
                break;
            }
            while (true)
            {
                Console.Write("Enter Employee Name: ");
                employee.Name = Console.ReadLine();
                if (string.IsNullOrEmpty(employee.Name))
                {
                    Console.WriteLine("Name Cannot be empty");
                    continue;
                }
                break;
            }
            while (true)
            {
                Console.Write("Enter Employee Salary: ");
                double.TryParse(Console.ReadLine(), out double salary);
                if (salary < 1000)
                {
                    Console.WriteLine("Please Enter a Valid Salary");
                    continue;
                }
                employee.Salary = salary;
                break;
            }
            
        }
    }
}