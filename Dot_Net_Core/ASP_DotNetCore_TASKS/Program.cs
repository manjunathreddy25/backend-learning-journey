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
using Asp.Versioning;
using Asp.Versioning.ApiExplorer;
using System.Reflection;
using System.IO;

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
builder.Services
    .AddApiVersioning(options =>
    {
        options.DefaultApiVersion = new ApiVersion(1, 0);
        options.AssumeDefaultVersionWhenUnspecified = true;
        options.ReportApiVersions = true;
        options.ApiVersionReader = new UrlSegmentApiVersionReader();
    })
    .AddMvc()
    .AddApiExplorer(options =>
    {
        options.GroupNameFormat = "'v'VVV";
        options.SubstituteApiVersionInUrl = true;
    });
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddScoped<ICardTransactionRepository,CardTransactionRepository>();
builder.Services.AddScoped<ICardTransactionService,CardTransactionService>();
builder.Services.AddScoped<IOrderService, OrderService>();
builder.Services.AddSingleton<IOrderCreateService, OrderCreateService>();
builder.Services.AddTransient<IOrderUpdateService, OrderUpdateService>();


builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(options =>
{
    // Swagger documentation for API v1
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "RealEstateAPI",
        Version = "v1",
        Description = "Real estate API version 1"
    });

    // Swagger documentation for API v2
    options.SwaggerDoc("v2", new OpenApiInfo
    {
        Title = "RealEstateAPI",
        Version = "v2",
        Description = "Real estate API version 2"
    });

    // Put versioned endpoints in their matching document.
    // Keep existing unversioned endpoints visible in v1.
    options.DocInclusionPredicate((documentName, apiDescription) =>
    {
        if (string.IsNullOrEmpty(apiDescription.GroupName))
        {
            return documentName == "v1";
        }

        return apiDescription.GroupName == documentName;
    });

    // Preserve JWT Bearer authentication in Swagger
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

    // swagger configuration
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";

    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);

    options.IncludeXmlComments(xmlPath);
});

var app = builder.Build();

app.UseMiddleware<RequestTimeMiddleware>();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();

    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint(
            "/swagger/v1/swagger.json",
            "RealEstateAPI v1");

        options.SwaggerEndpoint(
            "/swagger/v2/swagger.json",
            "RealEstateAPI v2");
    });
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
