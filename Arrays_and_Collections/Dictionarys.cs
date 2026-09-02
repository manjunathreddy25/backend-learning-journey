using System;

public class Dictionarys
{
	public static void Run()
	{
        Dictionary<int, string> employees = new Dictionary<int, string>();

        //create
        employees.Add(101, "Naruto");
        employees.Add(102, "Sasuke");
        employees.Add(103, "Sakura");
        //read
        Console.WriteLine(employees[101]);
        //update
        employees[103] = "Madara";
        //delete
        employees.Remove(102);


        employees.ContainsKey(101);
        employees.ContainsValue("Sakura");

        foreach (var employee in employees)
        {
            Console.WriteLine($"ID: {employee.Key}, Name: {employee.Value}");
        }

        Console.WriteLine("Enter ID and Name");
        employees.Add(Convert.ToInt32(Console.ReadLine()), Console.ReadLine());
        foreach (var e in employees)
        {
            Console.WriteLine($"{e.Key} {e.Value}");
        }
    }
}
