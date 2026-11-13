
using System.ComponentModel.DataAnnotations;

namespace EmployeeManagementAPI.DTOs;

public class UpdateAdminRequest
{
    [Required]
    [StringLength(50, MinimumLength = 3)]
    public string Username { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(150)]
    public string Email { get; set; } = string.Empty;

    // Optional: provide a new password only when resetting it.
    [MinLength(8)]
    public string? NewPassword { get; set; }
}
