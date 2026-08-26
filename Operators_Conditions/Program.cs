namespace Operators_Conditions
{
    class Program
    {
        static void Main(string[] args)
        {
            //Even_or_Odd.Run();
            //Pass_or_Fail.Run();
            //Grade_system_using_switch.Run();
        }
    }
    class Even_or_Odd
    {
        public static void Run()
        {
            Console.WriteLine("Enter a Number:");
            int value = Convert.ToInt32(Console.ReadLine());

            if (value % 2 == 0)
            {
                Console.WriteLine("Even");
            }
            else
            {
                Console.WriteLine("Odd");
            }
            Console.ReadKey();
        }
    }
    class Pass_or_Fail
    {
        public static void Run()
        {
            Console.Write("Enter your marks out of 100: ");
            int marks = Convert.ToInt32(Console.ReadLine());

            if (marks >= 40)
            {
                Console.WriteLine("Pass");
            }
            else
            {
                Console.WriteLine("Fail");
            }
            Console.ReadKey();
        }
    }
    class Grade_system_using_switch
    {
        public static void Run()
        {
            while (true)
            {
                Console.WriteLine("Enter marks out of 100 to know your Grade.");
                var marks = Convert.ToInt32(Console.ReadLine());
                if (marks < 0 || marks > 100)
                {
                    Console.WriteLine("Invalid marks please enter marks b/w 0 to 100!");
                }
                else
                {
                    int grade = marks / 10;

                    switch (grade)
                    {
                        case 10:
                        case 9:
                            Console.WriteLine("Your Grade is A");
                            break;

                        case 8:
                            Console.WriteLine("Your Grade is B");
                            break;

                        case 7:
                            Console.WriteLine("Your Grade is C");
                            break;

                        case 6:
                        case 5:
                        case 4:
                            Console.WriteLine("Your Grade is D");
                            break;

                        case 3:
                        case 2:
                        case 1:
                        case 0:
                            Console.WriteLine("Your Grade is F");
                            break;
                    }
                }
                Console.WriteLine();
                Console.WriteLine("1. Continue");
                Console.WriteLine("2. Exit");

                string choice = Console.ReadLine();

                if (choice == "2")
                {
                    break;
                }

                Console.WriteLine("Continuing...");
            }
        }
    }
}
