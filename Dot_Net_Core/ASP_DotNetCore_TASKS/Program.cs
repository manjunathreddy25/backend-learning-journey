using ASP_DotNetCore_TASKS.Middleware;
using ASP_DotNetCore_TASKS.Services;
using ASP_DotNetCore_TASKS.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add MYSQL Connection
var orderConnection =
    builder.Configuration.GetConnectionString("OrderConnection");

var migrationConnection =
    builder.Configuration.GetConnectionString("Migration_DBConnection");


builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(
        orderConnection,
        ServerVersion.AutoDetect(orderConnection)
    ));


builder.Services.AddDbContext<MigrationDbContext>(options =>
    options.UseMySql(
        migrationConnection,
        ServerVersion.AutoDetect(migrationConnection)
    ));
// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddScoped<IOrderService, OrderService>();
builder.Services.AddSingleton<IOrderCreateService, OrderCreateService>();
builder.Services.AddTransient<IOrderUpdateService, OrderUpdateService>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseMiddleware<RequestTimeMiddleware>();

app.UseAuthorization();

app.MapControllers();

app.Run();
