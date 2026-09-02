using System;

public class Linked_List	
{
	public static void Run()
	{
        LinkedList<int> numbers = new LinkedList<int>();

        numbers.AddLast(10);
        numbers.AddLast(20);
        numbers.AddLast(30);


        numbers.AddFirst(5);


        Console.WriteLine(numbers.First.Value);
        Console.WriteLine(numbers.Last.Value);

        LinkedListNode<int> node = numbers.Find(20);
        numbers.AddAfter(node, 25);
        numbers.AddBefore(node, 15);
        foreach(int i in numbers)
        {
            Console.WriteLine(i);
        }

        //remove
        numbers.Remove(20);
        numbers.RemoveFirst();
        numbers.RemoveLast();

        //count
        Console.WriteLine(numbers.Count);


    }
}
