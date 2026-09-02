using System;

namespace Strings_DateTime
{
    class Strings_DateTime
    {
        public static void Main(String[] args)
        {
            // Strings

            // Access character
            string firstName = "Manjunath";
            Console.WriteLine($" Index based letter: {firstName[0]}");

            // Length
            string name = "Naruto";
            Console.WriteLine($"Length of name: {name.Length}");

            // Uppercase
            string upperName = "Naruto";
            Console.WriteLine($"Converted to Uppercase: {upperName.ToUpper()}");

            // Lowercase
            Console.WriteLine($"Converted to Uppercase: {upperName.ToLower()}");

            // Contains
            string email = "manjunath@gmail.com";
            Console.WriteLine($" Does it Contains '@': {email.Contains("@")}");

            // StartsWith and EndsWith
            string emailAddress = "manjunath@gmail.com";
            Console.WriteLine($"Starting with : {emailAddress.StartsWith("man")}");
            Console.WriteLine($"Ending with : {emailAddress.EndsWith(".com")}");

            // Remove spaces
            string spacedName = "   Naruto   ";
            Console.WriteLine($"Removed Spaces: {spacedName.Trim()}");

            // Replace
            string originalName = "Naruto Uzumaki";
            string result = originalName.Replace("Naruto", "Sasuke");
            Console.WriteLine($"original name:{originalName} Replaced name:{result}");

            // Get parts of a string
            string characterName = "Naruto";
            Console.WriteLine($"Substring is: {characterName.Substring(0, 3)}");


            // DateTime

            // Current date and time
            DateTime now = DateTime.Now;
            Console.WriteLine($"Current Date and Time{now}");

            Console.WriteLine();

            // Current date
            Console.WriteLine($"Current date:{DateTime.Today}");

            // Creating specific date
            DateTime dob = new DateTime(2001, 11, 05);

            Console.WriteLine();
            Console.WriteLine($"Specific Date:{dob}");
            Console.WriteLine($"Year:{ dob.Year});
            Console.WriteLine($"Month:{dob.Month}");
            Console.WriteLine($"Day:{dob.Day}");


            // Adding/subtracting dates
            DateTime today = DateTime.Today;

            DateTime futureDate = today.AddDays(10);
            Console.WriteLine($"Future Date: {futureDate}");

            Console.WriteLine($"Adding Months:{today.AddMonths(2)}");
            Console.WriteLine($"Adding Years:{today.AddYears(1)}");

            Console.WriteLine($"Subtracting Days:{today.AddDays(-10)}");
            Console.WriteLine($"Subtracting Months:{today.AddMonths(-2)}");
            Console.WriteLine($"Subtracting Years:{today.AddYears(-1)}");


            // Tasks
            //Validate_Email.Run();
            //Calculate_Age.Run();
        }
    }
}