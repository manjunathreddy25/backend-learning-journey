using ASP_DotNetCore_TASKS.Models;
using Microsoft.EntityFrameworkCore;

namespace ASP_DotNetCore_TASKS.Data
{
    public class MigrationDbContext : DbContext
    {
        public MigrationDbContext(DbContextOptions<MigrationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Order> MigrationOrders { get; set; }
    }
}