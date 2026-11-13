
using RepositoryUnitOfWorkAPI.Data;
using RepositoryUnitOfWorkAPI.Interfaces;
using RepositoryUnitOfWorkAPI.Models;
using RepositoryUnitOfWorkAPI.Repositories;

namespace RepositoryUnitOfWorkAPI.UnitOfWork;

public class UnitOfWork : IUnitOfWork
{
    private readonly ApplicationDbContext _context;

    public IGenericRepository<Product> Products { get; }

    public UnitOfWork(ApplicationDbContext context)
    {
        _context = context;

        Products = new GenericRepository<Product>(_context);
    }

    public async Task<int> CompleteAsync()
    {
        return await _context.SaveChangesAsync();
    }

    public void Dispose()
    {
        _context.Dispose();
    }
}
