
using RepositoryUnitOfWorkAPI.Models;

namespace RepositoryUnitOfWorkAPI.Interfaces;

public interface IUnitOfWork : IDisposable
{
    IGenericRepository<Product> Products { get; }

    Task<int> CompleteAsync();
}
