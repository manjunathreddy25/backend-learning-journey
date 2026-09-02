using System;
namespace ATM_Withdrawal
{
    class ATM_Withdrawal
    {
        public static void Main(String[] args)
        {
            double balance = 10000;

            while (true)
            {
                Console.WriteLine("Welcome To ATM");
                Console.WriteLine("1. Check balance");
                Console.WriteLine("2. Withdraw");
                Console.WriteLine("3. Exit");
                Console.WriteLine();
                bool isValid = int.TryParse(Console.ReadLine(), out int option);
                Console.WriteLine();

                switch (option)
                {
                    case 1:
                        Console.WriteLine($"Current balance is: {balance}");
                        return;

                    case 2:
                        Console.Write("Enter withdrawal amount: ");
                        double amount = Convert.ToDouble(Console.ReadLine());

                        if (amount <= 0)
                        {
                            Console.WriteLine("Invalid amount.");
                            Console.WriteLine();
                            continue;
                        }
                        else if (amount > balance)
                        {
                            Console.WriteLine("Insufficient balance.");
                            Console.WriteLine();
                            continue;
                        }
                        else
                        {
                            balance = balance - amount;

                            Console.WriteLine("Withdrawal successful.");
                            Console.WriteLine($"Remaining balance: {balance}");
                            return;
                        }

                    case 3:
                        Console.WriteLine("Thank you for using the ATM.");
                        return;

                    default:
                        Console.WriteLine("Invalid option.");
                        Console.WriteLine();
                        break;
                }
            }

        }
    }
}