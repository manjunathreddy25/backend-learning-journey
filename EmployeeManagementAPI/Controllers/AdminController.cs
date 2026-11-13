
using EmployeeManagementAPI.Data;
using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EmployeeManagementAPI.Controllers;

[ApiController]
[Route("api/admin")]
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly PasswordHasher<User> _passwordHasher;

    public AdminController(ApplicationDbContext context)
    {
        _context = context;
        _passwordHasher = new PasswordHasher<User>();
    }
    private bool IsAdminManager()
    {
        return string.Equals(
            User.Identity?.Name,
            "testemployee",
            StringComparison.OrdinalIgnoreCase);
    }

    [HttpPost("create-admin")]
    public async Task<IActionResult> CreateAdmin(
        CreateAdminRequest request)
    {
        var username = request.Username.Trim();
        var email = request.Email.Trim().ToLowerInvariant();

        var userExists = await _context.Users.AnyAsync(u =>
            u.Email == email ||
            u.Username == username);

        if (userExists)
        {
            return Conflict(new
            {
                message = "Email or username is already registered."
            });
        }

        var user = new User
        {
            Username = username,
            Email = email,
            Role = "Admin"
        };

        user.PasswordHash = _passwordHasher.HashPassword(
            user, request.Password);

        _context.Users.Add(user);
        await _context.SaveChangesAsync();

        return Created("/api/admin/create-admin", new
        {
            message = "Admin account created successfully.",
            user = new
            {
                user.Id,
                user.Username,
                user.Email,
                user.Role
            }
        });
    }

    // Test Employee Features
    //Get
    [HttpGet("admins")]
    public async Task<IActionResult> GetAllAdmins()
    {

        var admins = await _context.Users
            .AsNoTracking()
            .Where(u => u.Role == "Admin")
            .Select(u => new
            {
                u.Id,
                u.Username,
                u.Email,
                u.Role
            })
            .ToListAsync();

        return Ok(new
        {
            totalAdmins = admins.Count,
            admins
        });
    }
    //Put
    [HttpPut("admins/{id:int}")]
    public async Task<IActionResult> UpdateAdmin(
    int id,
    [FromBody] UpdateAdminRequest request)
    {
        if (!IsAdminManager())
            return Forbid();

        var admin = await _context.Users
            .FirstOrDefaultAsync(u =>
                u.Id == id && u.Role == "Admin");

        if (admin == null)
        {
            return NotFound(new
            {
                message = "Admin account not found."
            });
        }

        var username = request.Username.Trim();
        var email = request.Email.Trim();

        var duplicate = await _context.Users.AnyAsync(u =>
            u.Id != id &&
            (u.Username.ToLower() == username.ToLower() ||
             u.Email.ToLower() == email.ToLower()));

        if (duplicate)
        {
            return Conflict(new
            {
                message = "Username or email already exists."
            });
        }

        admin.Username = username;
        admin.Email = email;

        if (!string.IsNullOrWhiteSpace(request.NewPassword))
        {
            var passwordHasher = new PasswordHasher<User>();

            admin.PasswordHash = passwordHasher.HashPassword(
                admin,
                request.NewPassword);
        }

        await _context.SaveChangesAsync();

        return Ok(new
        {
            message = "Admin account updated successfully.",
            admin.Id,
            admin.Username,
            admin.Email,
            admin.Role
        });
    }
    //Delete
    [HttpDelete("admins/{id:int}")]
    public async Task<IActionResult> DeleteAdmin(int id)
    {
        if (!IsAdminManager())
            return Forbid();

        var admin = await _context.Users
            .FirstOrDefaultAsync(u =>
                u.Id == id && u.Role == "Admin");

        if (admin == null)
        {
            return NotFound(new
            {
                message = "Admin account not found."
            });
        }

        if (string.Equals(
            admin.Username,
            "testemployee",
            StringComparison.OrdinalIgnoreCase))
        {
            return BadRequest(new
            {
                message = "The designated Admin manager cannot be deleted."
            });
        }

        var totalAdmins = await _context.Users
            .CountAsync(u => u.Role == "Admin");

        if (totalAdmins <= 1)
        {
            return BadRequest(new
            {
                message = "Cannot delete the last Admin account."
            });
        }

        _context.Users.Remove(admin);
        await _context.SaveChangesAsync();

        return Ok(new
        {
            message = "Admin account deleted successfully."
        });
    }
}
