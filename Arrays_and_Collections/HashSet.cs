using System;

public class Hash_Set
{
	public static void Run()
	{
        HashSet<int> numbers = new HashSet<int>();
        numbers.Add(10);
        numbers.Add(20);
        numbers.Add(30);
        numbers.Add(10);
        foreach(int i in numbers)
        {
            Console.WriteLine(i);
        }

        HashSet<int> setA = new HashSet<int> { 10, 20, 30, 40 };
        HashSet<int> setB = new HashSet<int> { 30, 40, 50, 60 };

        setA.UnionWith(setB);
        foreach (int value in setA)
        {
            Console.WriteLine($"Union: {value}");
        }

        setB.IntersectWith(setA);
        foreach (int value in setB)
        {
            Console.WriteLine($"Intersect: {value}");
        }

        setA.ExceptWith(setB);
        foreach (int value in setA)
        {
            Console.WriteLine($"Except: {value}");
        }
    }
}
