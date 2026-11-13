using EmployeeManagementAPI.Models;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Emit;

namespace EmployeeManagementAPI.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Employee> Employees => Set<Employee>();

    public DbSet<Department> Departments => Set<Department>();

    public DbSet<Project> Projects => Set<Project>();

    public DbSet<EmployeeProject> EmployeeProjects => Set<EmployeeProject>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Department>()
            .HasMany(d => d.Employees)
            .WithOne(e => e.Department)
            .HasForeignKey(e => e.DepartmentId);

        modelBuilder.Entity<EmployeeProject>()
            .HasKey(ep => new { ep.EmployeeId, ep.ProjectId });

        modelBuilder.Entity<EmployeeProject>()
            .HasOne(ep => ep.Employee)
            .WithMany(e => e.EmployeeProjects)
            .HasForeignKey(ep => ep.EmployeeId);

        modelBuilder.Entity<EmployeeProject>()
            .HasOne(ep => ep.Project)
            .WithMany(p => p.EmployeeProjects)
            .HasForeignKey(ep => ep.ProjectId);
    }
}