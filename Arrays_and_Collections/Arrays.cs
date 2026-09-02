using System;

public class Arrays
{
	public static void Run()
	{
		string[] Characters = new string[4]
		{
			"Naruto","Sasuke","Hinata","Sakura"
		};

		Console.WriteLine(Characters[3]);
		Characters[3] = "Himawari";
        Console.WriteLine(Characters[3]);
		Characters[1] = null;
        Console.WriteLine(Characters[1]);

    }
}
