
namespace Inventory.Domain;

public class Product
{
    public int Id { get; set; }

    public string Name { get; private set; } = string.Empty;

    public decimal Price { get; private set; }

    public int StockQuantity { get; private set; }

    public Product(string name, decimal price, int stockQuantity)
    {
        if (string.IsNullOrWhiteSpace(name))
            throw new ArgumentException("Product name is required.");

        if (price <= 0)
            throw new ArgumentException("Price must be greater than zero.");

        if (stockQuantity < 0)
            throw new ArgumentException("Stock cannot be negative.");

        Name = name;
        Price = price;
        StockQuantity = stockQuantity;
    }

    public void UpdatePrice(decimal price)
    {
        if (price <= 0)
            throw new ArgumentException("Price must be greater than zero.");

        Price = price;
    }

    public void ReduceStock(int quantity)
    {
        if (quantity <= 0)
            throw new ArgumentException("Quantity must be greater than zero.");

        if (quantity > StockQuantity)
            throw new InvalidOperationException("Insufficient stock.");

        StockQuantity -= quantity;
    }

    public void AddStock(int quantity)
    {
        if (quantity <= 0)
            throw new ArgumentException("Quantity must be greater than zero.");

        StockQuantity += quantity;
    }
}
