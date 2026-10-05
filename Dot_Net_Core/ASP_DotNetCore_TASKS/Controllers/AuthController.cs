using ASP_DotNetCore_TASKS.Models;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Authorization;

namespace ASP_DotNetCore_TASKS.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        // JWT
        private readonly IConfiguration _configuration;

        public AuthController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        // In-Memory
        private static readonly List<User> Users = new()
        {
            new User
            {
                Id = 1,
                Username = "luffy",
                Password = "12345",
                Role = "Captain"
            },

            new User
            {
                Id = 2,
                Username = "zoro",
                Password = "12345",
                Role = "ViceCaptain"
            },

            new User
            {
                Id = 3,
                Username = "nami",
                Password = "12345",
                Role = "Crew"
            }
        };
        [HttpPost("login")]
        public IActionResult Login(LoginRequest request)
        {
            var user = Users.FirstOrDefault(x =>
                x.Username == request.Username &&
                x.Password == request.Password);

            if (user == null)
            {
                return Unauthorized(new
                {
                    message = "Invalid username or password"
                });
            }

            var claims = new[]
            {
        new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
        new Claim(ClaimTypes.Name, user.Username),
        new Claim(ClaimTypes.Role, user.Role)
    };

            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(
                    _configuration["Jwt:Key"]!
                )
            );

            var credentials = new SigningCredentials(
                key,
                SecurityAlgorithms.HmacSha256
            );

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddHours(1),
                signingCredentials: credentials
            );

            var jwt = new JwtSecurityTokenHandler()
                .WriteToken(token);

            return Ok(new
            {
                message = "Login successful",
                token = jwt
            });
        }
        [Authorize]
        [HttpGet("protected")]
        public IActionResult Protected()
        {
            return Ok("You are authenticated!");
        }
        [Authorize(Roles = "Captain")]
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            return Ok("Deleted successfully");
        }
        [Authorize(Roles = "Captain,ViceCaptain")]
        [HttpPut("{id}")]
        public IActionResult Update(int id)
        {
            return Ok("Captain or ViceCaptain can update");
        }
    }
}