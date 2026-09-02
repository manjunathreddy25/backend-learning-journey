using System;

public class Stacks
{
	public static void Run()
	{
        Stack<string> students = new Stack<string>();

        students.Push("Luffy");
        students.Push("Zoro");
        students.Push("Naami");
        students.Push("Sanji");
        students.Push("Usopp");
        students.Push("Chopper");

        foreach (var student in students)
        {
            Console.WriteLine(student);
        }

        //removing element
        string s = students.Pop();
        Console.WriteLine($"Removed: {s}");

        string top = students.Peek();
        Console.WriteLine($"Topp element: {top}");
    }
}
