using System;
using System.Collections.Generic;

public class Storing_Employees
{
    public static void Employees()
    {
        List<int?> ids = new List<int?>();
        List<string?> names = new List<string?>();
        Dictionary<int, string> employees = new Dictionary<int, string>();

        int option;

        while (true)
        {
            Console.WriteLine();
            Console.WriteLine("Please Select an Option");
            Console.WriteLine("1. Enter Employees Data");
            Console.WriteLine("2. Get Pre Written Employees Data");
            Console.WriteLine("3. Enter Employee ID and Employee Name");

            try
            {
                option = Convert.ToInt32(Console.ReadLine());

                if (option >= 1 && option <= 3)
                {
                    break;
                }

                Console.WriteLine("Please select 1, 2, or 3.");
            }
            catch
            {
                Console.WriteLine("Please select a valid number.");
            }
        }

        switch (option)
        {
            // CASE 1
            case 1:
                Console.WriteLine("Enter a total of 10 employees data.");
                while (ids.Count < 10)
                {
                    Console.WriteLine();
                    Console.Write("Enter an ID: ");
                    string? idInput = Console.ReadLine();

                    Console.Write("Enter a Name: ");
                    string? nameInput = Console.ReadLine();

                    int? id = null;

                    if (!string.IsNullOrWhiteSpace(idInput))
                    {
                        id = Convert.ToInt32(idInput);
                    }

                    ids.Add(id);
                    names.Add(nameInput);
                    Console.WriteLine($" Count of employees is: {ids.Count}");
                }

                Console.WriteLine();
                Console.WriteLine("Employee Data:");

                for (int i = 0; i < ids.Count; i++)
                {
                    Console.WriteLine(
                        $"Employee ID: {ids[i]} and Name: {names[i]}"
                    );
                }

                break;


            // CASE 2
            case 2:

                ids.Add(1);
                ids.Add(2);
                ids.Add(3);
                ids.Add(4);
                ids.Add(5);
                ids.Add(6);
                ids.Add(7);
                ids.Add(8);
                ids.Add(9);
                ids.Add(10);

                names.Add("Naruto");
                names.Add("Sasuke");
                names.Add("Sakura");
                names.Add("Hinata");
                names.Add("Manjunath");
                names.Add("Himawari");
                names.Add("Boruto");
                names.Add("Sarada");
                names.Add("Kakashi");
                names.Add("Jiraya");

                Console.WriteLine();
                Console.WriteLine("Employees Data:");

                for (int i = 0; i < ids.Count; i++)
                {
                    Console.WriteLine(
                        $"Employee ID: {ids[i]} and Name: {names[i]}"
                    );
                }

                break;


            // CASE 3
            case 3:
                Console.WriteLine("Enter a total of 10 employees data.");
                while (employees.Count < 10)
                { 
                    Console.WriteLine();
                    Console.Write("Enter an ID: ");
                    string? idInput = Console.ReadLine();

                    if (string.IsNullOrWhiteSpace(idInput))
                    {
                        Console.WriteLine("ID cannot be empty.");
                        continue;
                    }

                    int id;

                    try
                    {
                        id = Convert.ToInt32(idInput);
                    }
                    catch
                    {
                        Console.WriteLine("Please enter a valid number.");
                        continue;
                    }

                    if (employees.ContainsKey(id))
                    {
                        Console.WriteLine("This ID already exists.");
                        continue;
                    }


                    Console.Write("Enter a Name: ");
                    string? nameInput = Console.ReadLine();

                    if (string.IsNullOrWhiteSpace(nameInput))
                    {
                        Console.WriteLine("Name cannot be empty.");
                        continue;
                    }

                    if (employees.ContainsValue(nameInput))
                    {
                        Console.WriteLine("This Name already exists.");
                        continue;
                    }

                    employees.Add(id, nameInput);

                    Console.WriteLine($"Count of employees is: {employees.Count}");
                }

                Console.WriteLine();
                Console.WriteLine("Employees Data:");

                foreach (var employee in employees)
                {
                    Console.WriteLine($"Employee ID: {employee.Key} and Name: {employee.Value}");
                }

                break;
        }
    }
}