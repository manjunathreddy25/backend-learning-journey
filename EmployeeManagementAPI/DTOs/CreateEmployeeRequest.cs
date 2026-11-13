
using System.ComponentModel.DataAnnotations;

namespace EmployeeManagementAPI.DTOs;

public class CreateEmployeeRequest
{
    [Required]
    [StringLength(100, MinimumLength = 2)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(150)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [StringLength(100)]
    public string Department { get; set; } = string.Empty;

    [Range(0.01, 9999999999.99)]
    public decimal Salary { get; set; }

    public DateTime DateOfJoining { get; set; } = DateTime.UtcNow;
}
