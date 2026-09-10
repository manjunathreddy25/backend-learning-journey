using System;
using System.Data;
namespace Methods
{
    class Methods
    {
        public static void Main(string[] args)
        {
            Calculator_using_methods();
           //max_of_3_numbers.max_number();
        }

        public static void Calculator_using_methods()
        {
            Console.WriteLine("welcome to calculator");
            Console.WriteLine();
            Console.WriteLine("Please select the operation:");
            Console.WriteLine("1.Addition");
            Console.WriteLine("2.Subtraction");
            Console.WriteLine("3.Multiplication");
            Console.WriteLine("4.Division");
            Console.WriteLine("5.Any Operation");
            int operation = Convert.ToInt32(Console.ReadLine());

            if (operation == 1)
            {
                try
                {
                    Console.WriteLine("Enter 2 values for Addition");
                    int add = Calculator.Add(Convert.ToInt32(Console.ReadLine()), Convert.ToInt32(Console.ReadLine()));
                    Console.WriteLine($"Addition is {add}");
                }
                catch
                {
                    Console.WriteLine("Invalid calculation!");
                }
            }
            else if (operation == 2)
            {
                try
                {
                    Console.WriteLine("Enter 2 values for Subtraction");
                    int sub = Calculator.Sub(Convert.ToInt32(Console.ReadLine()), Convert.ToInt32(Console.ReadLine()));
                    Console.WriteLine($"Subtraction is {sub}");
                }
                catch
                {
                    Console.WriteLine("Invalid calculation!");
                }
            }
            else if (operation == 3)
            {
                try
                {
                    Console.WriteLine("Enter 2 values for Multiplication");
                    int mul = Calculator.Mul(Convert.ToInt32(Console.ReadLine()), Convert.ToInt32(Console.ReadLine()));
                    Console.WriteLine($"Multiplication is {mul}");
                }
                catch
                {
                    Console.WriteLine("Invalid calculation!");
                }
            }
            else if (operation == 4)
            {
                try
                {
                    Console.WriteLine("Enter 2 values for Division");
                    double value1 = Convert.ToDouble(Console.ReadLine());
                    double value2 = Convert.ToDouble(Console.ReadLine());

                    if (value2 == 0)
                    {
                        Console.WriteLine("Error: Cannot divide by zero.");
                    }
                    else
                    {
                        double div = Calculator.Div(value1, value2);
                        Console.WriteLine($"Division is {div}");
                    }
                }
                catch
                {
                    Console.WriteLine("Invalid calculation!");
                }

            }
            else if (operation == 5)
            {
                Console.WriteLine("Please Enter Your Calculation");

                string cal = Console.ReadLine();

                try
                {
                    object result = new DataTable().Compute(cal, null);

                    Console.WriteLine($"Result: {result}");
                }
                catch
                {
                    Console.WriteLine("Invalid calculation!");
                }
            }
            else
            {
                Console.WriteLine("Enter a valid operation");
            }
        }
    }
}