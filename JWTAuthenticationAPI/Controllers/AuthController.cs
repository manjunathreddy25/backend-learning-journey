using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using JWTAuthenticationAPI.DTOs;
using JWTAuthenticationAPI.Services;
using JWTAuthenticationAPI.Models;
using JWTAuthenticationAPI.Data;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace JWTAuthenticationAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AuthController : ControllerBase
{
    private readonly UserManager<IdentityUser> _userManager;
    private readonly JwtTokenService _jwtTokenService;
    private readonly ApplicationDbContext _context;

    public AuthController(
        UserManager<IdentityUser> userManager,
        JwtTokenService jwtTokenService,
        ApplicationDbContext context)
    {
        _userManager = userManager;
        _jwtTokenService = jwtTokenService;
        _context = context;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register(RegisterDto model)
    {
        // Check whether the email already exists
        var existingUser = await _userManager.FindByEmailAsync(model.Email);

        if (existingUser != null)
        {
            return BadRequest(new
            {
                message = "Email is already registered"
            });
        }

        // Create a new Identity user
        var user = new IdentityUser
        {
            UserName = model.Email,
            Email = model.Email
        };

        // Identity hashes the password and saves the user
        var result = await _userManager.CreateAsync(user, model.Password);

        if (!result.Succeeded)
        {
            return BadRequest(result.Errors);
        }

        // Assign the default User role
        var roleResult = await _userManager.AddToRoleAsync(user, "User");

        if (!roleResult.Succeeded)
        {
            await _userManager.DeleteAsync(user);

            return StatusCode(500, new
            {
                message = "Could not assign the User role"
            });
        }

        return Ok(new
        {
            message = "User registered successfully",
            userId = user.Id,
            email = user.Email
        });
    }
    [HttpPost("login")]
    public async Task<IActionResult> Login(LoginDto model)
    {
        // Find user by email
        var user = await _userManager.FindByEmailAsync(model.Email);

        if (user == null)
        {
            return Unauthorized(new { message = "Invalid email or password" });
        }

        // Verify password
        var isPasswordValid = await _userManager.CheckPasswordAsync(
            user, model.Password);

        if (!isPasswordValid)
        {
            return Unauthorized(new { message = "Invalid email or password" });
        }

        // Generate access token
        var (accessToken, expiresAt) =
            await _jwtTokenService.GenerateAccessTokenAsync(user);

        // Generate refresh token
        var refreshToken = _jwtTokenService.GenerateRefreshToken();

        // Store only the hashed refresh token
        var refreshTokenEntity = new RefreshToken
        {
            TokenHash = _jwtTokenService.HashRefreshToken(refreshToken),
            UserId = user.Id,
            ExpiresAt = DateTime.UtcNow.AddDays(7)
        };

        _context.RefreshTokens.Add(refreshTokenEntity);

        await _context.SaveChangesAsync();

        return Ok(new AuthResponseDto
        {
            AccessToken = accessToken,
            RefreshToken = refreshToken,
            AccessTokenExpiry = expiresAt
        });
    }
    [HttpPost("refresh")]
    public async Task<IActionResult> Refresh(RefreshTokenDto model)
    {
        // Hash the incoming refresh token
        var tokenHash = _jwtTokenService.HashRefreshToken(
            model.RefreshToken);

        // Find the matching token in the database
        var storedToken = await _context.RefreshTokens
            .Include(rt => rt.User)
            .FirstOrDefaultAsync(rt => rt.TokenHash == tokenHash);

        if (storedToken == null || !storedToken.IsActive)
        {
            return Unauthorized(new
            {
                message = "Invalid or expired refresh token"
            });
        }

        var user = storedToken.User;

        if (user == null)
        {
            return Unauthorized(new
            {
                message = "User not found"
            });
        }

        // Revoke the old refresh token
        storedToken.RevokedAt = DateTime.UtcNow;

        // Generate a new access token
        var (accessToken, expiresAt) =
            await _jwtTokenService.GenerateAccessTokenAsync(user);

        // Generate a replacement refresh token
        var newRefreshToken = _jwtTokenService.GenerateRefreshToken();

        var newRefreshTokenEntity = new RefreshToken
        {
            TokenHash = _jwtTokenService.HashRefreshToken(newRefreshToken),
            UserId = user.Id,
            ExpiresAt = DateTime.UtcNow.AddDays(7)
        };

        _context.RefreshTokens.Add(newRefreshTokenEntity);

        await _context.SaveChangesAsync();

        return Ok(new AuthResponseDto
        {
            AccessToken = accessToken,
            RefreshToken = newRefreshToken,
            AccessTokenExpiry = expiresAt
        });
    }
}