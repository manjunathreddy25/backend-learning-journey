using System;

public class Sorted
{
	public static void Run()
	{
        //Dictionary
        SortedDictionary<int, string> students = new SortedDictionary<int, string>();

        students.Add(103, "Priya");
        students.Add(101, "Manjunath");
        students.Add(102, "Rahul");

        foreach (var student in students)
        {
            Console.WriteLine($"{student.Key} - {student.Value}");
        }

        //Lists
        SortedList<string, int> marks =new SortedList<string, int>();

        marks.Add("Zoro", 80);
        marks.Add("Luffy", 95);
        marks.Add("Nami", 90);

        foreach (var m in marks)
        {
            Console.WriteLine($"{m.Key} - {m.Value}");
        }
        //index available
        Console.WriteLine(marks.Keys[0]);
        Console.WriteLine(marks.Values[0]);

    }
}
