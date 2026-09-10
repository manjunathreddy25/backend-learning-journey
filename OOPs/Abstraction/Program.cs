// Abstraction
abstract class Characters
{
    public abstract void Ninja();

    public void Jutsu()
    {
        Console.WriteLine("Type of Jutsu You Acquire");
    }
    public static void Main()
    {
        Nin_Jutsu NJ = new Nin_Jutsu();
        NJ.Jutsu();
        NJ.Ninja();
        NJ.Place();

        Gen_Jutsu GJ = new Gen_Jutsu();
        GJ.Jutsu();
        GJ.Ninja();
        GJ.Place();

        Nin_Jutsu MOR = new Gen_Jutsu();
        MOR.Jutsu();
        MOR.Ninja();
        MOR.Place();
    }
    
}
class Nin_Jutsu : Characters
{
    // MUST implement the abstract method
    public override void Ninja()
    {
        Console.WriteLine("Leaf-Ninja");
    }
    public virtual void Place()
    {
        Console.WriteLine("Hidden-Leaf-Village");
    }
}

class Gen_Jutsu : Nin_Jutsu
{
    // MUST implement the abstract method
    public override void Ninja()
    {
        Console.WriteLine("Sand-Ninja");
    }

    public override void Place()
    {
        Console.WriteLine("Hidden-Sand-Village");
    }
}