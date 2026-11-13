using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JWTAuthenticationAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
[Authorize]
public class TestController : ControllerBase
{
    // Any authenticated user can access this endpoint
    [HttpGet("profile")]
    public IActionResult GetProfile()
    {
        return Ok(new
        {
            message = "You are authenticated!",
            userId = User.FindFirst(
                System.Security.Claims.ClaimTypes.NameIdentifier)?.Value,
            email = User.FindFirst(
                System.Security.Claims.ClaimTypes.Email)?.Value
        });
    }

    // Only Admin role can access this endpoint
    [HttpGet("admin")]
    [Authorize(Roles = "Admin")]
    public IActionResult AdminOnly()
    {
        return Ok(new
        {
            message = "Welcome Admin! You have access to this endpoint."
        });
    }

    // Only User role can access this endpoint
    [HttpGet("user")]
    [Authorize(Roles = "User")]
    public IActionResult UserOnly()
    {
        return Ok(new
        {
            message = "Welcome User! You have access to this endpoint."
        });
    }
}