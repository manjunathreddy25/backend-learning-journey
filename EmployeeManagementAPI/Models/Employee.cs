
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EmployeeManagementAPI.Models;

public class Employee
{
    public int Id { get; set; }

    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(150)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [StringLength(100)]
    public string Department { get; set; } = string.Empty;

    [StringLength(100)]
    public string? Designation { get; set; }

    [Column(TypeName = "decimal(10,2)")]
    public decimal Salary { get; set; }

    public DateTime DateOfJoining { get; set; }
}
