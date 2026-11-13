using System.ComponentModel.DataAnnotations;

namespace Inventory.Application.DTOs;

public class CreateProductDto
{
    [Required]
    [StringLength(100)]
    public string Name { get; set; } = string.Empty;

    [Range(0.01, 999999999)]
    public decimal Price { get; set; }

    [Range(0, int.MaxValue)]
    public int StockQuantity { get; set; }
}