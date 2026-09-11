using System;

namespace Exception_Handling;

class Divide_By_Zero
{
    public static void Run()
    {
        while (true)
        {
            Console.Write("Enter first number: ");
            int.TryParse(Console.ReadLine(), out int num1);

            Console.Write("Enter second number: ");
            int.TryParse(Console.ReadLine(), out int num2);

            try
            {
                int result = num1 / num2;
                Console.WriteLine($"Result: {result}");
                break;
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine("Cannot divide by zero.");
                continue;
            }
        }
    }
}