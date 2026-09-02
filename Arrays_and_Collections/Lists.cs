using System;

public class Lists
{
	public static void Run()
	{
        List<string> employees = new List<string>();
        //CRUD Operations
        //create
        employees.Add("Manjunath");
        employees.Add("Naruto");
        employees.Add("Sasuke");
        employees.Add("Sakura");
        employees.Add("Hinata");
        employees.Add("Himawari");
        employees.Add("Boruto");
        employees.Add("Sarada");
        employees.Add("Kakashi");
        employees.Add("Jiraya");
        //read
        Console.WriteLine(employees[0]);
        foreach (var employee in employees)
        {
            Console.WriteLine(employee);
        };
        //update
        employees[2] = "Madara";
        Console.WriteLine(employees[2]);
        //delete
        employees.Remove("Ravi");
        employees.RemoveAt(0);

        Console.WriteLine(employees.Contains("Ravi"));
        Console.WriteLine(employees.Count);
    }
}
