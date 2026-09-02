using System;

public class Validate_Email
{
	public static void Run()
	{
        while (true)
        {
            Console.Write("Enter your email: ");
            string? email = Console.ReadLine();
            if (string.IsNullOrWhiteSpace(email))
            {
                Console.WriteLine("Email cannot be empty.");
                continue;
            }
            else if (!email.EndsWith("@gmail.com"))
            {
                Console.WriteLine("Invalid email.");
                continue;
            }
            else
            {
                string emailName = email.Substring(0, email.Length - "@gmail.com".Length);

                if (string.IsNullOrWhiteSpace(emailName))
                {
                    Console.WriteLine("Invalid email.");
                    continue;
                }
                else if (emailName.Length <4)
                {
                    Console.WriteLine("Invalid email.");
                    continue;
                }
                else
                {
                    Console.WriteLine("Email is valid.");
                    break;
                }
            }
        }
    }
}
