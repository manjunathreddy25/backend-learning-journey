
using Microsoft.EntityFrameworkCore;
using RepositoryUnitOfWorkAPI.Models;

namespace RepositoryUnitOfWorkAPI.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(
        DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Product> Products { get; set; }
}
