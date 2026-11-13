
using Microsoft.AspNetCore.Mvc;
using RepositoryUnitOfWorkAPI.Interfaces;
using RepositoryUnitOfWorkAPI.Models;

namespace RepositoryUnitOfWorkAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ProductsController : ControllerBase
{
    private readonly IUnitOfWork _unitOfWork;

    public ProductsController(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    // GET: api/Products
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var products = await _unitOfWork.Products.GetAllAsync();

        return Ok(products);
    }

    // GET: api/Products/1
    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var product = await _unitOfWork.Products.GetByIdAsync(id);

        if (product == null)
            return NotFound("Product not found");

        return Ok(product);
    }

    // POST: api/Products
    [HttpPost]
    public async Task<IActionResult> Create(Product product)
    {
        await _unitOfWork.Products.AddAsync(product);

        await _unitOfWork.CompleteAsync();

        return Ok(product);
    }

    // PUT: api/Products/1
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, Product product)
    {
        var existingProduct =
            await _unitOfWork.Products.GetByIdAsync(id);

        if (existingProduct == null)
            return NotFound("Product not found");

        existingProduct.Name = product.Name;
        existingProduct.Description = product.Description;
        existingProduct.Price = product.Price;
        existingProduct.Stock = product.Stock;

        _unitOfWork.Products.Update(existingProduct);

        await _unitOfWork.CompleteAsync();

        return Ok(existingProduct);
    }

    // DELETE: api/Products/1
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var product = await _unitOfWork.Products.GetByIdAsync(id);

        if (product == null)
            return NotFound("Product not found");

        _unitOfWork.Products.Delete(product);

        await _unitOfWork.CompleteAsync();

        return Ok("Product deleted successfully");
    }
}
