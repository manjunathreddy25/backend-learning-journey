using System.ComponentModel.DataAnnotations;

namespace JWTAuthenticationAPI.DTOs;

public class RefreshTokenDto
{
    [Required]
    public string RefreshToken { get; set; } = string.Empty;
}