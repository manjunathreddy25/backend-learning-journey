
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeManagementAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TestController : ControllerBase
{
    [HttpGet("public")]
    [AllowAnonymous]
    public IActionResult Public()
    {
        return Ok(new
        {
            message = "This endpoint is public."
        });
    }

    [HttpGet("protected")]
    [Authorize]
    public IActionResult Protected()
    {
        return Ok(new
        {
            message = "JWT authentication successful!",
            username = User.Identity?.Name,
            role = User.FindFirst(
                System.Security.Claims.ClaimTypes.Role)?.Value
        });
    }

    [HttpGet("admin")]
    [Authorize(Roles = "Admin")]
    public IActionResult AdminOnly()
    {
        return Ok(new
        {
            message = "Welcome, Admin!"
        });
    }
}
