using ASP_DotNetCore_TASKS.Data;
using ASP_DotNetCore_TASKS.Models;
using BankingFraudDetection.Models;
using Microsoft.EntityFrameworkCore;

namespace BankingFraudDetection.Repositories
{
    public class CardTransactionRepository : ICardTransactionRepository
    {
        private readonly Banking_Fraud_DetectionDBContext _context;

        public CardTransactionRepository(Banking_Fraud_DetectionDBContext context)
        {
            _context = context;
        }

        public async Task<List<CardTransaction>> GetAllAsync()
        {
            return await _context.CardTransactions.ToListAsync();
        }

        public async Task<CardTransaction?> GetByIdAsync(int id)
        {
            return await _context.CardTransactions
                .FirstOrDefaultAsync(x => x.CardTransactionId == id);
        }

        public async Task<CardTransaction> AddAsync(CardTransaction transaction)
        {
            _context.CardTransactions.Add(transaction);

            await _context.SaveChangesAsync();

            return transaction;
        }

        public async Task UpdateAsync(CardTransaction transaction)
        {
            _context.CardTransactions.Update(transaction);

            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var transaction = await _context.CardTransactions
                .FirstOrDefaultAsync(x => x.CardTransactionId == id);

            if (transaction != null)
            {
                _context.CardTransactions.Remove(transaction);

                await _context.SaveChangesAsync();
            }
        }

        public async Task<List<CardTransaction>> GetPagedAsync(int page,int pageSize)
        {
            return await _context.CardTransactions
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
        }
        public async Task<List<CardTransaction>> GetPagedAsync(int page,int pageSize,string? search)
        {
            var query = _context.CardTransactions.AsQueryable();

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(x =>
                    x.MerchantName.Contains(search));
            }

            return await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
        }

        public async Task<List<CardTransaction>> GetPagedAsync(
    int page,
    int pageSize,
    string? search,
    string? sortBy,
    string? sortOrder)
        {
            var query = _context.CardTransactions.AsQueryable();

            // Search
            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(x =>
                    x.MerchantName.Contains(search));
            }

            // Sorting
            if (sortBy == "amount")
            {
                if (sortOrder == "desc")
                {
                    query = query.OrderByDescending(x => x.Amount);
                }
                else
                {
                    query = query.OrderBy(x => x.Amount);
                }
            }

            // Pagination
            return await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
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
            var query = _context.CardTransactions.AsQueryable();

            // Search
            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(x =>
                    x.MerchantName.Contains(search));
            }

            // Filtering
            if (minAmount.HasValue)
            {
                query = query.Where(x =>
                    x.Amount >= minAmount.Value);
            }

            if (maxAmount.HasValue)
            {
                query = query.Where(x =>
                    x.Amount <= maxAmount.Value);
            }

            // Sorting
            if (sortBy == "amount")
            {
                if (sortOrder == "desc")
                {
                    query = query.OrderByDescending(x => x.Amount);
                }
                else
                {
                    query = query.OrderBy(x => x.Amount);
                }
            }
            else if (sortBy == "merchantName")
            {
                if (sortOrder == "desc")
                {
                    query = query.OrderByDescending(x => x.MerchantName);
                }
                else
                {
                    query = query.OrderBy(x => x.MerchantName);
                }
            }

            // Count BEFORE pagination
            var totalRecords = await query.CountAsync();

            // Pagination
            var transactions = await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            var totalPages =
                (int)Math.Ceiling(
                    (double)totalRecords / pageSize);

            return new PaginationResult<CardTransaction>
            {
                Data = transactions,
                Page = page,
                PageSize = pageSize,
                TotalRecords = totalRecords,
                TotalPages = totalPages
            };
        }
    }
}