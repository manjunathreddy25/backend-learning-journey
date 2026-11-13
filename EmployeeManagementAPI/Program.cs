using EmployeeManagementAPI.Data;
using Microsoft.EntityFrameworkCore;
using EmployeeManagementAPI.Services;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using EmployeeManagementAPI.Models;


var builder = WebApplication.CreateBuilder(args);
// Register DB Connection
var connectionString =
    builder.Configuration.GetConnectionString("EmployeeManagementAPIConnection")
    ?? throw new InvalidOperationException(
        "EmployeeManagementAPIConnection was not found.");

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseMySql(
        connectionString,
        ServerVersion.AutoDetect(connectionString)));
// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<JwtService>();
var jwtKey = builder.Configuration["Jwt:Key"]
    ?? throw new InvalidOperationException(
        "JWT signing key is missing.");

var jwtIssuer = builder.Configuration["Jwt:Issuer"]
    ?? throw new InvalidOperationException(
        "JWT issuer is missing.");

var jwtAudience = builder.Configuration["Jwt:Audience"]
    ?? throw new InvalidOperationException(
        "JWT audience is missing.");

builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters =
            new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidIssuer = jwtIssuer,

                ValidateAudience = true,
                ValidAudience = jwtAudience,

                ValidateLifetime = true,

                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(
                    Encoding.UTF8.GetBytes(jwtKey)),

                ClockSkew = TimeSpan.FromSeconds(30)
            };
    });

builder.Services.AddAuthorization();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "Employee Management API",
        Version = "v1"
    });

    options.AddSecurityDefinition("Bearer",
        new Microsoft.OpenApi.Models.OpenApiSecurityScheme
        {
            Name = "Authorization",
            Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
            Scheme = "bearer",
            BearerFormat = "JWT",
            In = Microsoft.OpenApi.Models.ParameterLocation.Header,
            Description = "Enter your JWT token here."
        });

    options.AddSecurityRequirement(
    new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
        {
            new Microsoft.OpenApi.Models.OpenApiSecurityScheme
            {
                Reference = new Microsoft.OpenApi.Models.OpenApiReference
                {
                    Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new List<string>()
        }
    });
});

var app = builder.Build();
// Global exception handling
app.UseExceptionHandler(errorApp =>
{
    errorApp.Run(async context =>
    {
        context.Response.StatusCode =
            StatusCodes.Status500InternalServerError;

        context.Response.ContentType = "application/json";

        await context.Response.WriteAsJsonAsync(new ApiResponse
        {
            Success = false,
            StatusCode = 500,
            Message = "An unexpected server error occurred.",
            Data = null,
            Errors = null
        });
    });
});

app.Use(async (context, next) =>
{
    await next();

    if (context.Response.HasStarted)
        return;

    var statusCode = context.Response.StatusCode;

    if (statusCode == StatusCodes.Status401Unauthorized ||
        statusCode == StatusCodes.Status403Forbidden)
    {
        context.Response.ContentType = "application/json";

        var response = new ApiResponse
        {
            Success = false,
            StatusCode = statusCode,
            Message = statusCode == StatusCodes.Status401Unauthorized
                ? "Authentication is required or your token is invalid."
                : "You do not have permission to access this resource.",
            Data = null,
            Errors = null
        };

        await context.Response.WriteAsJsonAsync(response);
    }
});
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
