using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exception_Handling
{
    class Custom_Exception
    {
        public static void AgeValidator()
        {
            Console.WriteLine("Enter Age to Validate.");
            int.TryParse(Console.ReadLine(), out var age);

            if (age < 18)
            {
                throw new InvalidAgeException("Age must be 18 or above.");
            }
            Console.WriteLine("Age is valid.");
        }
    }
    class InvalidAgeException : Exception
    {
        public InvalidAgeException(string message) : base(message)
        {
        }
    }
}
