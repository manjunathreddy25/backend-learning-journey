
using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeManagementAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly AuthService _authService;
    private readonly JwtService _jwtService;

    public AuthController(
        AuthService authService,
        JwtService jwtService)
    {
        _authService = authService;
        _jwtService = jwtService;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register(
        RegisterRequest request)
    {
        var result = await _authService.RegisterAsync(request);

        if (!result.Success)
            return Conflict(new { message = result.Message });

        return Ok(new { message = result.Message });
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login(LoginRequest request)
    {
        var user = await _authService.ValidateLoginAsync(request);

        if (user is null)
            return Unauthorized(new
            {
                message = "Invalid email or password."
            });

        var token = _jwtService.GenerateToken(user);

        return Ok(new
        {
            message = "Login successful.",
            accessToken = token,
            tokenType = "Bearer",
            expiresInMinutes = 60,
            user = new
            {
                user.Id,
                user.Username,
                user.Email,
                user.Role
            }
        });
    }
}
