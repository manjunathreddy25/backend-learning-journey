
using Inventory.Domain;

namespace Inventory.Application.Interfaces;

public interface IProductRepository
{
    Task<Product?> GetByIdAsync(int id);

    Task<List<Product>> GetAllAsync();

    Task AddAsync(Product product);

    Task SaveChangesAsync();
}
