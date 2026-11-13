
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using HtmlAgilityPack;

class Program
{
    static async Task Main()
    {
        string url = "https://docs.google.com/document/d/e/2PACX-1vSvM5gDlNvt7npYHhp_XfsJvuntUhq184By5xO_pA4b_gCWeXb6dM6ZxwN8rE6S4ghUsCj2VKR21oEP/pub";

        await PrintSecretMessage(url);

        Console.ReadLine();
    }

    static async Task PrintSecretMessage(string url)
    {
        using HttpClient client = new HttpClient();

        string html = await client.GetStringAsync(url);

        HtmlDocument document = new HtmlDocument();
        document.LoadHtml(html);

        var rows = document.DocumentNode.SelectNodes("//table//tr");

        if (rows == null)
        {
            Console.WriteLine("No table found.");
            return;
        }

        List<(int X, char Character, int Y)> points = new();

        int maxX = 0;
        int maxY = 0;

        foreach (var row in rows)
        {
            var cells = row.SelectNodes("./td|./th");

            if (cells == null || cells.Count < 3)
                continue;

            if (!int.TryParse(cells[0].InnerText.Trim(), out int x))
                continue;

            string characterText =
                HtmlEntity.DeEntitize(cells[1].InnerText).Trim();

            if (characterText.Length == 0)
                continue;

            if (!int.TryParse(cells[2].InnerText.Trim(), out int y))
                continue;

            char character = characterText[0];

            points.Add((x, character, y));

            maxX = Math.Max(maxX, x);
            maxY = Math.Max(maxY, y);
        }

        if (points.Count == 0)
        {
            Console.WriteLine("No coordinate data found.");
            return;
        }

        char[,] grid = new char[maxY + 1, maxX + 1];

        for (int y = 0; y <= maxY; y++)
        {
            for (int x = 0; x <= maxX; x++)
            {
                grid[y, x] = ' ';
            }
        }

        foreach (var point in points)
        {
            grid[point.Y, point.X] = point.Character;
        }

        for (int y = 0; y <= maxY; y++)
        {
            for (int x = 0; x <= maxX; x++)
            {
                Console.Write(grid[y, x]);
            }

            Console.WriteLine();
        }
    }
}
//using System;

//namespace HelloWorld
//{
//    class Program
//    {
//        static void Main()
//        {
//            Console.Write("Enter your name: ");
//            string? name = Console.ReadLine();

//            Console.Write("Enter your age: ");
//            int age = Convert.ToInt32(Console.ReadLine());

//            Console.WriteLine(
//                $"Hello, I am {name}! I'm {age} years old and current time is {DateTime.Now}"
//            );

//            Console.ReadKey();
//        }

//    }
//}