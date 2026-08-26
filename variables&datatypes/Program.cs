using System;
using System.Threading.Channels;

namespace MyApp
{
    class Program
    {
        static void Main(string[] args)
        {
             //VariablesAndDataTypes.Run();
            //TypeConversion.Run();
           //MarksTask.Run();
        }
    }
    class VariablesAndDataTypes
    {
        public static void Run()
        {
            // Integer
            int age = 23;

            // String
            string name = "Manjunath";
            string city = "Hyderabad";

            // Bool
            bool isLoggedIn = true;

            // Double
            double price = 99.99;

            // var
            var myAge = 23;
            var myName = "Manjunath";
            var myPrice = 99.99;


            // const
            const double PI = 3.14159;

            Console.WriteLine($"Age: {age}");
            Console.WriteLine($"Name: {name}");
            Console.WriteLine($"City: {city}");
            Console.WriteLine($"Price: {price}");
            Console.WriteLine($"LoggedIn: {isLoggedIn}");
            Console.WriteLine($"PI: {PI}");


            Console.WriteLine(myAge.GetType());
            Console.WriteLine(myName.GetType());
            Console.WriteLine(myPrice.GetType());

            Console.WriteLine(PI.GetType());
        }
    }
    class TypeConversion
    {
        public static void Run()
        {
            // String → int
            string number = "25";

            int intValue = Convert.ToInt32(number);

            // String → double
            const string price = "99.50";

            double doubleValue = Convert.ToDouble(price);

            Console.WriteLine($"String: {number} and its type is {number.GetType()}");
            Console.WriteLine($"String converted to int: {intValue} and its type is {intValue.GetType()}");
            Console.WriteLine($"Double: {price} and its type is {price.GetType()}");
            Console.WriteLine($"String converted to double: {doubleValue} and its type is {doubleValue.GetType()}");
        }
    }
    class MarksTask
    {
        public static void Run()
        {
            Console.WriteLine("Enter math marks out of 100");
            int m_marks = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Enter English marks out of 100");
            int e_marks = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Enter science marks out of 100");
            int s_marks = Convert.ToInt32(Console.ReadLine());

            int total = m_marks + e_marks + s_marks;

            double average = (double)total / 3;

            Console.WriteLine($"Total marks: {total}");
            Console.WriteLine($"Average marks: {average:F2}");
        }
    }
}