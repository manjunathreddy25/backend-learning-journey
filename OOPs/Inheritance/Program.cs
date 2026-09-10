// Inheritance
using System;

Student student = new Student();

student.Name = "Manjunath";
student.Age = 25;
student.Course = "CSE";

//student.Display_Person();
//student.display_student();
student.Display();


Person p = new Person();
p.Display();
Person p1 = new Student();
p1.Display();
// Student p2 = new Person(); X-NotValid: Using child class refrence we cannot create a parent class Object.

Employee employee = new Employee();

employee.Name = "Naruto";
employee.Age = 25;
employee.Department = "IT";
employee.employee();

Person p2 = new Employee();
p2.Display();
Student emp = new Employee();
emp.Display();
public class Person
{
    public string Name { get; set; } = "";
    public int Age { get; set; }

    public void Display_Person()
    {
        Console.WriteLine("Displaying Person...");
        Console.WriteLine($"Name:{Name}");
        Console.WriteLine($"Age:{Age}");
    }
    public virtual void Display()
    {
        Console.WriteLine("This is Person");
    }
}

public class Student : Person
{
    public string Course { get; set; } = "";

    public void display_student()
    {
        Console.WriteLine("Displaying Student..");
        Console.WriteLine($"Name:{Name}");
        Console.WriteLine($"Age:{Age}");
        Console.WriteLine($"Course:{Course}");
    }
    public override void Display()
    {
        Console.WriteLine("This is Student");
    }
}

class Employee : Student
{
    public string Department { get; set;}
    public void employee()
    {
        Console.WriteLine("Displaying Employee");
        Console.WriteLine($"Name:{Name}");
        Console.WriteLine($"Age:{Age}");
        Console.WriteLine($"Department:{Department}");
    }
    public override void Display()
    {
        Console.WriteLine("This is Employee");

    }
}