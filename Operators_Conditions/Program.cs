namespace Operators_Conditions
{
    class Program
    {
        static void Main(string[] args)
        {
            Even_or_Odd.Run();
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
}
