using ASP_DotNetCore_TASKS.Models;
using Microsoft.EntityFrameworkCore;

namespace ASP_DotNetCore_TASKS.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public DbSet<Order> Orders { get; set; }
    }
}