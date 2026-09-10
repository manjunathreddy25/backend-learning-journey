using System;
using System.ComponentModel;

namespace OOPs
{
    public class Employee
    {
        //properties
        private int id;
        public int Id
        {
            get
            {
                return id;
            }
            set
            {
                if (value >= 100 && value <=999)
                {
                    id = value;
                }
            }
        }

        private string name;
        public string Name
        {
            get
            {
                return name;
            }
            set
            {
                if (!string.IsNullOrWhiteSpace(value) && value.All(c => char.IsLetter(c) || c == ' '))
                {
                    name = value;
                }
            }
        }
        private double salary;
        public double Salary
        {
            private get
            {
                return salary;
            }
            set
            {
                if(value >= 1000)
                {
                    salary = value;
                }
            }
        }
        public void ViewSalary()
        {
            while (true)
            {
                Console.Write("Enter password to view salary: ");
                string? password = Console.ReadLine();

                if (password == "5464")
                {
                    Console.WriteLine($"Salary: {Salary}");
                    break;
                }
                else
                {
                    Console.WriteLine("Incorrect password.");
                    continue;
                }
            }
        }
    }


}
