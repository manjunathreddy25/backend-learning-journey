
using EmployeeManagementAPI.Data;
using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace EmployeeManagementAPI.Services;

public class AuthService
{
    private readonly ApplicationDbContext _context;
    private readonly PasswordHasher<User> _passwordHasher;

    public AuthService(ApplicationDbContext context)
    {
        _context = context;
        _passwordHasher = new PasswordHasher<User>();
    }

    public async Task<(bool Success, string Message)> RegisterAsync(
        RegisterRequest request)
    {
        var email = request.Email.Trim().ToLowerInvariant();
        var username = request.Username.Trim();

        if (await _context.Users.AnyAsync(u =>
                u.Email.ToLower() == email ||
                u.Username == username))
        {
            return (false, "Email or username is already registered.");
        }

        var user = new User
        {
            Username = username,
            Email = email,
            Role = "Employee"
        };

        user.PasswordHash = _passwordHasher.HashPassword(
            user, request.Password);

        _context.Users.Add(user);
        await _context.SaveChangesAsync();

        return (true, "Registration successful.");
    }

    public async Task<User?> ValidateLoginAsync(LoginRequest request)
    {
        var email = request.Email.Trim().ToLowerInvariant();

        var user = await _context.Users
            .SingleOrDefaultAsync(u => u.Email == email);

        if (user is null)
            return null;

        var result = _passwordHasher.VerifyHashedPassword(
            user, user.PasswordHash, request.Password);

        return result == PasswordVerificationResult.Failed
            ? null
            : user;
    }
}
