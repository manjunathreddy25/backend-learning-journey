using EmployeeManagementAPI.Data;
using Microsoft.EntityFrameworkCore;
using EmployeeManagementAPI.Repository;
using EmployeeManagementAPI.Repository.Interfaces;
using EmployeeManagementAPI.Business;
using EmployeeManagementAPI.Business.Interfaces;


var builder = WebApplication.CreateBuilder(args);

// Repository Registration
builder.Services.AddScoped<IEmployeeRepository, EmployeeRepository>();

// Service Registration
builder.Services.AddScoped<IEmployeeService, EmployeeService>();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// DB Context
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        ServerVersion.AutoDetect(
            builder.Configuration.GetConnectionString("DefaultConnection")
        )
    )
);
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
