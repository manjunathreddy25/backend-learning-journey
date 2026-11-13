
using System.ComponentModel.DataAnnotations;

namespace EmployeeManagementAPI.Models;

public class User
{
    [Key]
    public int Id { get; set; }

    [Required]
    [MaxLength(100)]
    public string Username { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [MaxLength(150)]
    public string Email { get; set; } = string.Empty;

    // Stores a password hash, never the plain-text password.
    [Required]
    public string PasswordHash { get; set; } = string.Empty;

    // Example roles: Admin or Employee.
    [Required]
    [MaxLength(30)]
    public string Role { get; set; } = "Employee";
}
