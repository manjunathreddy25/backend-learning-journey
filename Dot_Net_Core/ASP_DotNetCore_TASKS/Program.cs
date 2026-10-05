using ASP_DotNetCore_TASKS.Data;
using ASP_DotNetCore_TASKS.Middleware;
using ASP_DotNetCore_TASKS.Services;
using BankingFraudDetection.Repositories;
using BankingFraudDetection.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.OpenApi.Models;


var builder = WebApplication.CreateBuilder(args);

// Add MYSQL Connection
var orderConnection =
    builder.Configuration.GetConnectionString("OrderConnection");

var bankingConnection =
    builder.Configuration.GetConnectionString("BankingConnection");

var migrationConnection =
    builder.Configuration.GetConnectionString("Migration_DBConnection");


builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(
        orderConnection,
        ServerVersion.AutoDetect(orderConnection)
    ));

builder.Services.AddDbContext<Banking_Fraud_DetectionDBContext>(options =>
    options.UseMySql(
        bankingConnection,
        ServerVersion.AutoDetect(bankingConnection)
    ));

builder.Services.AddDbContext<MigrationDbContext>(options =>
    options.UseMySql(
        migrationConnection,
        ServerVersion.AutoDetect(migrationConnection)
    ));
// JWT configuration here...
var jwtKey = builder.Configuration["Jwt:Key"];

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,

            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],

            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(jwtKey!)
            )
        };
    });
builder.Services.AddAuthorization();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddScoped<ICardTransactionRepository,CardTransactionRepository>();
builder.Services.AddScoped<ICardTransactionService,CardTransactionService>();
builder.Services.AddScoped<IOrderService, OrderService>();
builder.Services.AddSingleton<IOrderCreateService, OrderCreateService>();
builder.Services.AddTransient<IOrderUpdateService, OrderUpdateService>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Enter your JWT token"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

var app = builder.Build();

app.UseMiddleware<RequestTimeMiddleware>();

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
