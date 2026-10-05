using ASP_DotNetCore_TASKS.Models;
using BankingFraudDetection.Models;
using BankingFraudDetection.Repositories;

namespace BankingFraudDetection.Services
{
    public class CardTransactionService : ICardTransactionService
    {
        private readonly ICardTransactionRepository _repository;

        public CardTransactionService(ICardTransactionRepository repository)
        {
            _repository = repository;
        }

        public async Task<List<CardTransaction>> GetAllAsync()
        {
            return await _repository.GetAllAsync();
        }

        public async Task<CardTransaction?> GetByIdAsync(int id)
        {
            return await _repository.GetByIdAsync(id);
        }

        public async Task<CardTransaction> CreateAsync(CardTransaction transaction)
        {
            // Business logic can be added here later.

            return await _repository.AddAsync(transaction);
        }

        public async Task UpdateAsync(CardTransaction transaction)
        {
            // Business logic can be added here later.

            await _repository.UpdateAsync(transaction);
        }

        public async Task DeleteAsync(int id)
        {
            await _repository.DeleteAsync(id);
        }

        public async Task<List<CardTransaction>> GetPagedAsync(int page,int pageSize)
        {
            return await _repository.GetPagedAsync(page, pageSize);
        }

        public async Task<List<CardTransaction>> GetPagedAsync(
    int page,
    int pageSize,
    string? search)
        {
            return await _repository.GetPagedAsync(
                page,
                pageSize,
                search);
        }

        public async Task<List<CardTransaction>> GetPagedAsync(
    int page,
    int pageSize,
    string? search,
    string? sortBy,
    string? sortOrder)
        {
            return await _repository.GetPagedAsync(
                page,
                pageSize,
                search,
                sortBy,
                sortOrder);
        }

        public async Task<PaginationResult<CardTransaction>> GetPagedAsync(
    int page,
    int pageSize,
    string? search,
    string? sortBy,
    string? sortOrder,
    decimal? minAmount,
    decimal? maxAmount)
        {
            return await _repository.GetPagedAsync(
                page,
                pageSize,
                search,
                sortBy,
                sortOrder,
                minAmount,
                maxAmount);
        }
    }
}