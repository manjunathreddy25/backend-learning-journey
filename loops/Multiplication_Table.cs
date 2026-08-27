class Multiplication_Table
{
    public static void Multiplication()
    {
        Console.WriteLine("Enter a number to get its multiplication table.");
        var value = Convert.ToInt32(Console.ReadLine());
        Console.WriteLine($"The Multiplication Table of {value} is:");
        int i = 1;
        while (i <= 10)
        {
            Console.WriteLine($"{value} * {i} = {value * i}");
            i++;
        }

    }
}
