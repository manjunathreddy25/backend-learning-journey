using ASP_DotNetCore_TASKS.Models;
using BankingFraudDetection.Models;

namespace BankingFraudDetection.Repositories
{
    public interface ICardTransactionRepository
    {
        Task<List<CardTransaction>> GetAllAsync();

        Task<CardTransaction?> GetByIdAsync(int id);

        Task<CardTransaction> AddAsync(CardTransaction transaction);

        Task UpdateAsync(CardTransaction transaction);

        Task DeleteAsync(int id);

        Task<List<CardTransaction>> GetPagedAsync(int page, int pageSize);

        Task<List<CardTransaction>> GetPagedAsync(int page,int pageSize,string? search);

        Task<List<CardTransaction>> GetPagedAsync(
    int page,
    int pageSize,
    string? search,
    string? sortBy,
    string? sortOrder);

        Task<PaginationResult<CardTransaction>> GetPagedAsync(
    int page,
    int pageSize,
    string? search,
    string? sortBy,
    string? sortOrder,
    decimal? minAmount,
    decimal? maxAmount);
    }
}