using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using JWTAuthenticationAPI.DTOs;

namespace JWTAuthenticationAPI.Services;

public class JwtTokenService
{
    private readonly IConfiguration _configuration;
    private readonly UserManager<IdentityUser> _userManager;

    public JwtTokenService(
        IConfiguration configuration,
        UserManager<IdentityUser> userManager)
    {
        _configuration = configuration;
        _userManager = userManager;
    }

    public async Task<(string Token, DateTime ExpiresAt)>
        GenerateAccessTokenAsync(IdentityUser user)
    {

        var jwtSettings = _configuration.GetSection("Jwt");

        var secretKey = jwtSettings["SecretKey"]!;
        var fingerprint = Convert.ToHexString(
    SHA256.HashData(Encoding.UTF8.GetBytes(secretKey)));

        Console.WriteLine($"GENERATION KEY FINGERPRINT: {fingerprint}");



        var key = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(secretKey));

        var credentials = new SigningCredentials(
            key,
            SecurityAlgorithms.HmacSha256);

        var roles = await _userManager.GetRolesAsync(user);

        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.NameIdentifier, user.Id),
            new Claim(ClaimTypes.Email, user.Email!)
        };

        foreach (var role in roles)
        {
            claims.Add(new Claim(ClaimTypes.Role, role));
        }

        var expiresAt = DateTime.UtcNow.AddMinutes(15);

        var token = new JwtSecurityToken(
            issuer: jwtSettings["Issuer"],
            audience: jwtSettings["Audience"],
            claims: claims,
            expires: expiresAt,
            signingCredentials: credentials
        );

        var accessToken = new JwtSecurityTokenHandler()
            .WriteToken(token);

        return (accessToken, expiresAt);
    }

    public string GenerateRefreshToken()
    {
        var randomBytes = RandomNumberGenerator.GetBytes(64);

        return Convert.ToBase64String(randomBytes);
    }

    public string HashRefreshToken(string refreshToken)
    {
        var bytes = SHA256.HashData(
            Encoding.UTF8.GetBytes(refreshToken));

        return Convert.ToBase64String(bytes);
    }
}