using System;

interface IPayment
{
    void Pay(double amount);
    void AddMoney(double amount);
}

class UPI : IPayment
{
    private double balance = 100000;

    public void Pay(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid amount.");
        }
        else if (amount <= balance)
        {
            balance -= amount;

            Console.WriteLine($"₹{amount} paid successfully using UPI.");
            Console.WriteLine($"Current UPI balance: ₹{balance}");
        }
        else
        {
            Console.WriteLine("Insufficient UPI balance.");
            Console.WriteLine($"Current UPI balance: ₹{balance}");
        }
    }

    public void AddMoney(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid amount.");
            return;
        }

        balance += amount;

        Console.WriteLine($"₹{amount} added successfully to UPI.");
        Console.WriteLine($"Current UPI balance: ₹{balance}");
    }
}

class CreditCard : IPayment
{
    private double balance = 75000;

    public void Pay(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid amount.");
        }
        else if (amount <= balance)
        {
            balance -= amount;

            Console.WriteLine($"₹{amount} paid successfully using Credit Card.");
            Console.WriteLine($"Current Credit Card balance: ₹{balance}");
        }
        else
        {
            Console.WriteLine("Insufficient Credit Card balance.");
            Console.WriteLine($"Current Credit Card balance: ₹{balance}");
        }
    }

    public void AddMoney(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid amount.");
            return;
        }

        balance += amount;

        Console.WriteLine($"₹{amount} added successfully to Credit Card.");
        Console.WriteLine($"Current Credit Card balance: ₹{balance}");
    }
}

class Wallet : IPayment
{
    private double balance = 25000;

    public void Pay(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid amount.");
        }
        else if (amount <= balance)
        {
            balance -= amount;

            Console.WriteLine($"₹{amount} paid successfully using Wallet.");
            Console.WriteLine($"Current Wallet balance: ₹{balance}");
        }
        else
        {
            Console.WriteLine("Insufficient Wallet balance.");
            Console.WriteLine($"Current Wallet balance: ₹{balance}");
        }
    }

    public void AddMoney(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid amount.");
            return;
        }

        balance += amount;

        Console.WriteLine($"₹{amount} added successfully to Wallet.");
        Console.WriteLine($"Current Wallet balance: ₹{balance}");
    }
}

class Program
{
    static void Main()
    {
        // Create payment objects
        IPayment upi = new UPI();
        IPayment creditCard = new CreditCard();
        IPayment wallet = new Wallet();

        while (true)
        {
            Console.WriteLine();
            Console.WriteLine("========== PAYMENT SYSTEM ==========");
            Console.WriteLine("1. Pay");
            Console.WriteLine("2. Add Money");
            Console.WriteLine("3. Exit");
            Console.Write("Select an option: ");

            if (!int.TryParse(Console.ReadLine(), out int mainOption))
            {
                Console.WriteLine("Please enter a valid number.");
                continue;
            }

            if (mainOption == 3)
            {
                Console.WriteLine("Thank you for using the Payment System!");
                break;
            }

            if (mainOption != 1 && mainOption != 2)
            {
                Console.WriteLine("Please select 1, 2, or 3.");
                continue;
            }

            Console.WriteLine();
            Console.WriteLine("Select Payment Method:");
            Console.WriteLine("1. UPI");
            Console.WriteLine("2. Credit Card");
            Console.WriteLine("3. Wallet");
            Console.Write("Select payment method: ");

            if (!int.TryParse(Console.ReadLine(), out int paymentOption))
            {
                Console.WriteLine("Please enter a valid number.");
                continue;
            }

            IPayment payment;

            switch (paymentOption)
            {
                case 1:
                    payment = upi;
                    break;

                case 2:
                    payment = creditCard;
                    break;

                case 3:
                    payment = wallet;
                    break;

                default:
                    Console.WriteLine("Invalid payment method.");
                    continue;
            }

            Console.Write("Enter amount: ");

            if (!double.TryParse(Console.ReadLine(), out double amount))
            {
                Console.WriteLine("Please enter a valid amount.");
                continue;
            }

            if (mainOption == 1)
            {
                payment.Pay(amount);
            }
            else
            {
                payment.AddMoney(amount);
            }
        }
    }
}