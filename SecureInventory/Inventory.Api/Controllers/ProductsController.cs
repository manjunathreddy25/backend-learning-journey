
using Inventory.Application.DTOs;
using Inventory.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Inventory.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly IProductService _productService;

    public ProductsController(IProductService productService)
    {
        _productService = productService;
    }

    [HttpPost]
    public async Task<IActionResult> Create(CreateProductDto dto)
    {
        var product = await _productService.CreateAsync(
            dto.Name,
            dto.Price,
            dto.StockQuantity);

        return CreatedAtAction(
            nameof(GetById),
            new { id = product.Id },
            new
            {
                product.Id,
                product.Name,
                product.Price,
                product.StockQuantity
            });
    }

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var products = await _productService.GetAllAsync();

        var result = products.Select(p => new
        {
            p.Id,
            p.Name,
            p.Price,
            p.StockQuantity
        });

        return Ok(result);
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var product = await _productService.GetByIdAsync(id);

        if (product is null)
        {
            return NotFound(new
            {
                Message = $"Product with ID {id} was not found."
            });
        }

        return Ok(new
        {
            product.Id,
            product.Name,
            product.Price,
            product.StockQuantity
        });
    }
}
