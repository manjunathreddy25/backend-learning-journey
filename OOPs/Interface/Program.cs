// Interface
interface ISolo_Leveling
{
    void Gates();
    void Dungens();
    void Beasts();
}
interface IPlayer
{
    string Name { get; set; }
    string Rank { get; set; }
    void Attack();
}
class Hunters : ISolo_Leveling, IPlayer
{
    public string Name { get; set; } = "";
    public string Rank { get; set; } = "";

    public void Gates()
    {
        Console.WriteLine("Red Gate");
    }

    public void Dungens()
    {
        Console.WriteLine("Double-Dungeon");
    }

    public void Beasts()
    {
        Console.WriteLine("High Orks");
    }

    public void Attack()
    {
        Console.WriteLine("Completed");
    }

    public static void Main()
    {
        Hunters hunter = new Hunters();

        hunter.Name = "Sung Jin-Woo";
        hunter.Rank = "S";

        hunter.Gates();
        hunter.Dungens();
        hunter.Beasts();
        hunter.Attack();
    }
}
