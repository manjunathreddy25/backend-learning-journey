using BankingFraudDetection.Models;
using BankingFraudDetection.Services;
using Microsoft.AspNetCore.Mvc;

namespace BankingFraudDetection.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CardTransactionController : ControllerBase
    {
        private readonly ICardTransactionService _service;

        public CardTransactionController(ICardTransactionService service)
        {
            _service = service;
        }

        // GET: api/CardTransaction
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var transactions = await _service.GetAllAsync();

            return Ok(transactions);
        }

        // GET: api/CardTransaction/1
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var transaction = await _service.GetByIdAsync(id);

            if (transaction == null)
            {
                return NotFound();
            }

            return Ok(transaction);
        }

        // POST: api/CardTransaction
        [HttpPost]
        public async Task<IActionResult> Create(CardTransaction transaction)
        {
            var createdTransaction =
                await _service.CreateAsync(transaction);

            return Ok(createdTransaction);
        }

        // PUT: api/CardTransaction/1
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(
            int id,
            CardTransaction transaction)
        {
            if (id != transaction.CardTransactionId)
            {
                return BadRequest("ID does not match.");
            }

            var existingTransaction =
                await _service.GetByIdAsync(id);

            if (existingTransaction == null)
            {
                return NotFound();
            }

            await _service.UpdateAsync(transaction);

            return Ok(transaction);
        }

        // DELETE: api/CardTransaction/1
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var existingTransaction =
                await _service.GetByIdAsync(id);

            if (existingTransaction == null)
            {
                return NotFound();
            }

            await _service.DeleteAsync(id);

            return NoContent();
        }
        // Pagination and Filtering
        [HttpGet("paged")]
        public async Task<IActionResult> GetPaged(int page = 1,int pageSize = 10)
        {
            var transactions =
                await _service.GetPagedAsync(page, pageSize);

            return Ok(transactions);
        }

        [HttpGet("strictpaged")]
        public async Task<IActionResult> GetPaged(
    int page = 1,
    int pageSize = 10,
    string? search = null)
        {
            if (page < 1)
            {
                return BadRequest("Page must be greater than 0.");
            }

            if (pageSize < 1 || pageSize > 100)
            {
                return BadRequest(
                    "Page size must be between 1 and 100.");
            }

            var transactions =
                await _service.GetPagedAsync(
                    page,
                    pageSize,
                    search);

            return Ok(transactions);
        }

        [HttpGet("strict/ordered/paged")]
        public async Task<IActionResult> GetPaged(
    int page = 1,
    int pageSize = 10,
    string? search = null,
    string? sortBy = null,
    string? sortOrder = null)
        {
            if (page < 1)
            {
                return BadRequest("Page must be greater than 0.");
            }

            if (pageSize < 1 || pageSize > 100)
            {
                return BadRequest(
                    "Page size must be between 1 and 100.");
            }
            if(search == null)
            {
                return BadRequest(
                    "Search should not be null.");
            }
            if(sortBy != "amount")
            {
                return BadRequest(
                "sortby can be applied to 'amount' column only!");
            }
            if (sortOrder != "desc" && sortOrder != null)
            {
                return BadRequest(
                "sortorder can be desc or null");
            }
            var transactions =
                await _service.GetPagedAsync(
                    page,
                    pageSize,
                    search,
                    sortBy,
                    sortOrder);

            return Ok(transactions);
        }


        [HttpGet("paged/metadata")]
        public async Task<IActionResult> GetPaged(
    int page = 1,
    int pageSize = 10,
    string? search = null,
    string? sortBy = null,
    string? sortOrder = null,
    decimal? minAmount = null,
    decimal? maxAmount = null)
        {
            if (page < 1)
            {
                return BadRequest(
                    "Page must be greater than 0.");
            }

            if (pageSize < 1 || pageSize > 100)
            {
                return BadRequest(
                    "Page size must be between 1 and 100.");
            }

            if (minAmount.HasValue &&
                maxAmount.HasValue &&
                minAmount > maxAmount)
            {
                return BadRequest(
                    "Minimum amount cannot be greater than maximum amount.");
            }

            var result = await _service.GetPagedAsync(
                page,
                pageSize,
                search,
                sortBy,
                sortOrder,
                minAmount,
                maxAmount);

            return Ok(result);
        }
    }
}