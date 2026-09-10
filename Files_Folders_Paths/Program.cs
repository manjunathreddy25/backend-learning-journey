using System;
using System.IO;
namespace Files_Folders_Paths
{
    class Main_Space
    {
        public static async Task Main(String[] args)
        {
            //Create the folder and file
            string folder = "Employees";

            Directory.CreateDirectory(folder);

            string filePath = Path.Combine(folder, "employees.txt");


            //Write employees asynchronously
            string[] emps =
                [
                "Manjunath",
                "Naruto",
                "Sasuke"
                ];
            await File.WriteAllLinesAsync(filePath, emps);


            //Read employees asynchronously
            string[] emps_list = await File.ReadAllLinesAsync(filePath);
            foreach (string e in emps_list)
            {
                Console.WriteLine(e);
            }

            //Append another employee
            string[] new_emps =
[
    "Sneha",
    "Hinata",
    "Sakura"
];

            await File.AppendAllLinesAsync(filePath, new_emps);

            string[] employees =
                await File.ReadAllLinesAsync(filePath);

            foreach (string employee in employees)
            {
                Console.WriteLine(employee);
            }


            //Get file information
            FileInfo file = new FileInfo(filePath);
            Console.WriteLine($"Name: {file.Name}");
            Console.WriteLine($"Size: {file.Length} bytes");
            Console.WriteLine($"Full Path: {file.FullName}");
            Console.WriteLine($"Created: {file.CreationTime}");
            Console.WriteLine($"Modified: {file.LastWriteTime}");


            //Create a backup
            string backupPath = Path.Combine(folder, "employees_backup.txt");
            File.Copy(filePath, backupPath, true);


            //Search for .txt files
            DirectoryInfo directory =new DirectoryInfo(folder);
            FileInfo[] files = directory.GetFiles("*.txt",SearchOption.AllDirectories);

            foreach (FileInfo fileInfo in files)
            {
                Console.WriteLine(
                    $"{fileInfo.Name} - {fileInfo.Length} bytes"
                );
            }



            //Exception handling
            try
            {
                string[] employees =
                    await File.ReadAllLinesAsync(filePath);

                foreach (string employee in employees)
                {
                    Console.WriteLine(employee);
                }
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine("Employee file was not found.");
            }
            catch (UnauthorizedAccessException)
            {
                Console.WriteLine("You don't have permission to access the file.");
            }
            catch (IOException)
            {
                Console.WriteLine("A file operation failed.");
            }
            //
            /*
            string folder = "Employees";
            string fileName = "employees.txt";

            Directory.CreateDirectory(folder);

            string filePath = Path.Combine(folder, fileName);

            File.WriteAllText(filePath, "Manjunath");

            Console.WriteLine(filePath);
            Console.WriteLine("Employee saved!");

            string employee = File.ReadAllText(filePath);

            Console.WriteLine($"\nEmployee: {employee}");

            string[] newEmployees =
[
    "Naruto",
    "Luffy",
    "Inosuke"
];
            File.WriteAllLines(filePath, newEmployees);

            string[] employees = File.ReadAllLines(filePath);

            foreach (string emp in employees)
            {
                Console.WriteLine(emp);
            }


            File.AppendAllText(filePath, "Zoro\n");
            string[] newEmployees1 =
[
    "Zoro",
    "Sanji",
    "Tanjiro"
];

            File.AppendAllLines(filePath, newEmployees1);


            string[] employees1 = File.ReadAllLines(filePath);
            foreach (string emp in employees1)
            {
                Console.WriteLine(emp);
            }


            Console.WriteLine("________________________________________");
            using StreamReader reader = new StreamReader(filePath);

            string? line;

            while ((line = reader.ReadLine()) != null)
            {
                Console.WriteLine(line);
            }


            Console.WriteLine("=============================================");

            FileInfo file = new FileInfo(Path.Combine("Employees", "employees.txt"));

            Console.WriteLine($"Name: {file.Name}");
            Console.WriteLine($"Size: {file.Length}");
            Console.WriteLine($"Created: {file.CreationTime}");
            Console.WriteLine($"Modified: {file.LastWriteTime}");
            Console.WriteLine($"Accessed: {file.LastAccessTime}");

            Console.WriteLine(
                $"Attributes: {file.Attributes}"
            );*/
        }
    }
}