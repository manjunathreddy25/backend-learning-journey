
using Inventory.Application.Interfaces;
using Inventory.Domain;

namespace Inventory.Application.Services;

public class ProductService : IProductService
{
    private readonly IProductRepository _repository;

    public ProductService(IProductRepository repository)
    {
        _repository = repository;
    }

    public async Task<Product> CreateAsync(
        string name,
        decimal price,
        int stockQuantity)
    {
        var product = new Product(name, price, stockQuantity);

        await _repository.AddAsync(product);
        await _repository.SaveChangesAsync();

        return product;
    }

    public async Task<List<Product>> GetAllAsync()
    {
        return await _repository.GetAllAsync();
    }

    public async Task<Product?> GetByIdAsync(int id)
    {
        return await _repository.GetByIdAsync(id);
    }
}
