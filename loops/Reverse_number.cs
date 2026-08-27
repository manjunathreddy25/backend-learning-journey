class Reverse_number
{
    public static void Reverse()
    {
        Console.WriteLine("Enter a number greater than 1 digit.");
        string number = Console.ReadLine();

        if (number.Length <= 1 /* || Convert.ToInt32(number) < 0 */)
        {
            Console.WriteLine("Invalid");
        }
        else
        {
            bool isNegative = number[0] == '-';
            if (isNegative)
            {
                number = number.Substring(1);
            }
            string reverse = "";

            int i = number.Length - 1;

            do
            {
                reverse += number[i];
                i--;
            }
            while (i >= 0);
            if (isNegative)
            {
                reverse = "-" + reverse;
            }
            Console.WriteLine($"Reversed number: {reverse}");

            //int reversedNumber = Convert.ToInt32(reverse);
            //Console.WriteLine($"Reversed number: {reversedNumber}")
        }
    }
}
