using System;

namespace HelloWorld
{
    class Program
    {
        static void Main()
        {
            Console.Write("Enter your name: ");
            string? name = Console.ReadLine();

            Console.Write("Enter your age: ");
            int age = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine(
                $"Hello, I am {name}! I'm {age} years old and current time is {DateTime.Now}"
            );

            Console.ReadKey();
        }
    }
}