using System;

public class Calculate_Age
{
	public static void Run()
	{
        while (true)
        {
            Console.Write("Enter your date of birth (yyyy-MM-dd): ");
            string? input = Console.ReadLine();

            if (!DateTime.TryParse(input, out DateTime dob))
            {
                Console.WriteLine("Invalid date. Please enter a valid date.");
                continue;
            }
            else if (dob > DateTime.Today)
            {
                Console.WriteLine("Date of birth cannot be in the future.");
                continue;
            }
            else
            {
                DateTime today = DateTime.Today;

                int age = today.Year - dob.Year;

                if (dob.Date > today.AddYears(-age))
                {
                    age--;
                }

                Console.WriteLine($"Your age is: {age}");
                break;
            }
        }
    }
}
