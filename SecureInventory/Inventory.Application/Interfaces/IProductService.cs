
using Inventory.Domain;

namespace Inventory.Application.Interfaces;

public interface IProductService
{
    Task<Product> CreateAsync(
        string name,
        decimal price,
        int stockQuantity);

    Task<List<Product>> GetAllAsync();

    Task<Product?> GetByIdAsync(int id);
}
