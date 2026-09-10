//Polymorphism
//Compile time-  Method Overloading
using System;
namespace Polymorphism;
class Method_Overloading
{
    public static void Main(String[] args)
    {
        Calculator c = new Calculator();

        Console.WriteLine(c.Add(10, 20));
        Console.WriteLine(c.Add(10, 20, 30));
        Console.WriteLine(c.Add(14.55, 25.34));
        Console.WriteLine(c.Add("Naruto"));


        Animal a = new Animal();
        Animal a1 = new Dog();
        Animal a2 = new Cat();

        a.MakeSound();
        a1.MakeSound();
        a2.MakeSound();
    }
}
class Calculator
{
    public int Add(int a, int b)
    {
        return a + b;
    }

    public int Add(int a, int b, int c)
    {
        return a + b + c;
    }
    public double Add(double a, double b)
    {
        return a + b;
    }
    public string Add(string a)
    {
        return a;
    }
}
//Runtime Polymorphism - Method Overriding.
class Animal
{
    public virtual void MakeSound()
    {
        Console.WriteLine("Animal sound");
    }
}

class Dog : Animal
{
    public override void MakeSound()
    {
        Console.WriteLine("Woof");
    }
}

class Cat : Animal
{
    public override void MakeSound()
    {
        Console.WriteLine("Meow");
    }
}