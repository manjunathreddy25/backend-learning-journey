using System;

public class Queues
{

    public static void Run()
	{
        Queue<string> customers = new Queue<string>();

        //adding element
        customers.Enqueue("Manjunath");
        customers.Enqueue("Rahul");
        customers.Enqueue("Priya");
        customers.Enqueue("Arun");

        foreach (string customer in customers)
        {
            Console.WriteLine(customer);
        }
        //removing element
        string c = customers.Dequeue();
        Console.WriteLine(c);


        string first = customers.Peek();
        Console.WriteLine(first);

        //removes everything
       //customers.Clear();
    }
}
