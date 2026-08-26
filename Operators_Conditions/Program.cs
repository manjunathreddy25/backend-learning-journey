namespace Operators_Conditions
{
    class Program
    {
        static void Main(string[] args)
        {
            //Even_or_Odd.Run();
            Pass_or_Fail.Run();
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
        }
    }
}
