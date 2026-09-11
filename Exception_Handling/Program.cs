//Exception handling.
using System;
namespace Exception_Handling;
class Program
{
    public static void Main(string[] args)
    {
        //Program.Error();
        //Program.try_catch_finally();
        //Program.exception_errors();
        //Divide_By_Zero.Run();
        try
        {
            Custom_Exception.AgeValidator();
        }
        catch (InvalidAgeException e)
        {
            Console.WriteLine(e.Message);
        }
    }
    public static void Error()
    {
        int a = 10;
        int b = 0;
        int result = a/b;
    }
    public static void try_catch_finally()
    {
        int a = 10;
        int b = 0;
        try
        {
            int result = a / b;
        }
        /*catch (DivideByZeroException ex)
        {
            Console.WriteLine(ex.Message);
        }*/
        catch (DivideByZeroException)
        {
            Console.WriteLine("Cannot Divide by Zero");
        }
        finally
        {
            Console.WriteLine("Final Block Executed!");
        }
    }
    public static void exception_errors()
    {
        Console.WriteLine("===DivideByZeroException===");
        try
        {
            int a = 10;
            int b = 0;

            int result = a / b;
        }
        catch(DivideByZeroException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===NullReferenceException===");
        try
        {
            string? nam = null;

            Console.WriteLine(nam.Length);
        }
        catch(NullReferenceException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===IndexOutOfRangeException===");
        try
        {
            int[] numbers = { 10, 20, 30 };

            Console.WriteLine(numbers[5]);
        }
        catch(IndexOutOfRangeException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===ArgumentException===");
        try
        {
            
            void SetAge(int age)
            {
                if (age < 0)
                    throw new ArgumentException();
            }
            SetAge(-21);
        }
        catch(ArgumentException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===ArgumentNullException===");
        try
        {
            void Display(string name)
            {
                if (name == null)
                    throw new ArgumentNullException();
            }
            Display(null);
        }
        catch(ArgumentNullException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===ArgumentOutOfRangeException===");
        try
        {
            void SetA(int age)
            {
                if (age < 0 || age > 120)
                    throw new ArgumentOutOfRangeException();
            }
            SetA(155);
        }
        catch(ArgumentOutOfRangeException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===FormatException===");
        try
        {
            int age = Convert.ToInt32("hello");
        }
        catch(FormatException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===InvalidOperationException===");
        try
        {
            List<int> number = new List<int>();

            int first = number.First();
        }
        catch(InvalidOperationException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===KeyNotFoundException===");
        try
        {
            Dictionary<int, string> students = new();

            students.Add(1, "Ravi");

            Console.WriteLine(students[10]);
        }
        catch(KeyNotFoundException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===OverflowException===");
        try
        {
            checked
            {
                int x = int.MaxValue;
                x++;
            }
        }
        catch(OverflowException e)
        {
            Console.WriteLine(e.Message);
        }
        Console.WriteLine("===StackOverflowException===");
        try
        {
            void Test()
            {
                Test();
            }
        }
        catch(StackOverflowException e)
        {
            Console.WriteLine(e.Message);
        }
    }

}
