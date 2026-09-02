using System;

public class max_of_3_numbers
{
    public static void max_number()
    {
        Console.Write("Enter first number: ");
        int a = Convert.ToInt32(Console.ReadLine());

        Console.Write("Enter second number: ");
        int b = Convert.ToInt32(Console.ReadLine());

        Console.Write("Enter third number: ");
        int c = Convert.ToInt32(Console.ReadLine());

        int result = FindMax(a, b, c);

        Console.WriteLine($"Maximum number is: {result}");
    }
    public static int FindMax(int a, int b)
    {
        if (a > b)
            return a;
        else
            return b;
    }
    public static int FindMax(int a, int b, int c)
    {
        int max = FindMax(a, b);

        return FindMax(max, c);
    }
}


//ifelse methods

/*if (a >= b && a >= c)
    max = a;
else if (b >= a && b >= c)
    max = b;
else
    max = c;*/



// loop + array

/* 
int[] numbers = { a, b, c };
int max = numbers[0];
for (int i = 1; i < numbers.Length; i++)
{
    if (numbers[i] > max)
    {
        max = numbers[i];
    }
}
Console.WriteLine($"Maximum: {max}"); 
*/



// Builtin methods

/*
int max = Math.Max(a, Math.Max(b, c));
Console.WriteLine($"Maximum: {max}");
*/


