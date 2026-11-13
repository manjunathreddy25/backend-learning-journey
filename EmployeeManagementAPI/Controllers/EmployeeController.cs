
using EmployeeManagementAPI.Data;
using EmployeeManagementAPI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using EmployeeManagementAPI.DTOs;

namespace EmployeeManagementAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class EmployeeController : ControllerBase
{

    private readonly ApplicationDbContext _context;
    private readonly ILogger<EmployeeController> _logger;

    public EmployeeController(
        ApplicationDbContext context,
        ILogger<EmployeeController> logger)
    {
        _context = context;
        _logger = logger;
    }


    // GET: api/Employee   
[HttpGet]
public async Task<IActionResult> GetAllEmployees(
    [FromQuery] int pageNumber = 1,
    [FromQuery] int pageSize = 5,
    [FromQuery] string? search = null,
    [FromQuery] string? department = null,
    [FromQuery] string sortBy = "id",
    [FromQuery] string sortOrder = "asc")
{
    if (pageNumber < 1 || pageSize < 1 || pageSize > 100)
    {
        return BadRequest(new
        {
            message = "Page number must be positive and page size must be between 1 and 100."
        });
    }

    var query = _context.Employees.AsNoTracking();

    if (!string.IsNullOrWhiteSpace(search))
    {
        var term = search.Trim();

        query = query.Where(e =>
            e.FullName.Contains(term) ||
            e.Email.Contains(term));
    }

    if (!string.IsNullOrWhiteSpace(department))
    {
        var dept = department.Trim();

        query = query.Where(e => e.Department == dept);
    }

    var descending = sortOrder.Equals(
        "desc", StringComparison.OrdinalIgnoreCase);

    query = sortBy.ToLowerInvariant() switch
    {
        "fullname" => descending
            ? query.OrderByDescending(e => e.FullName)
            : query.OrderBy(e => e.FullName),

        "salary" => descending
            ? query.OrderByDescending(e => e.Salary)
            : query.OrderBy(e => e.Salary),

        "department" => descending
            ? query.OrderByDescending(e => e.Department)
            : query.OrderBy(e => e.Department),

        "dateofjoining" => descending
            ? query.OrderByDescending(e => e.DateOfJoining)
            : query.OrderBy(e => e.DateOfJoining),

        "id" => descending
            ? query.OrderByDescending(e => e.Id)
            : query.OrderBy(e => e.Id),

        _ => query.OrderBy(e => e.Id)
    };

    var totalRecords = await query.CountAsync();

    var employees = await query
        .Skip((pageNumber - 1) * pageSize)
        .Take(pageSize)
        .ToListAsync();

    return Ok(new
    {
        pageNumber,
        pageSize,
        totalRecords,
        totalPages = (int)Math.Ceiling(
            totalRecords / (double)pageSize),
        search,
        department,
        sortBy,
        sortOrder,
        employees
    });
}

    // GET: api/Employee/5
    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetEmployeeById(int id)
    {
        var employee = await _context.Employees
            .AsNoTracking()
            .FirstOrDefaultAsync(e => e.Id == id);

        if (employee is null)
        {
            return NotFound(new
            {
                message = "Employee not found."
            });
        }

        return Ok(employee);
    }

    // POST: api/Employee

    [HttpPost]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> CreateEmployee(
        CreateEmployeeRequest request)
    {
        var email = request.Email.Trim().ToLowerInvariant();

        var emailExists = await _context.Employees
            .AnyAsync(e => e.Email.ToLower() == email);

        if (emailExists)
        {
            return Conflict(new
            {
                message = "An employee with this email already exists."
            });
        }

        var employee = new Employee
        {
            FullName = request.FullName.Trim(),
            Email = email,
            Department = request.Department.Trim(),
            Salary = request.Salary,
            DateOfJoining = request.DateOfJoining
        };

        _context.Employees.Add(employee);
        await _context.SaveChangesAsync();

        _logger.LogInformation(
            "Employee created successfully. EmployeeId: {EmployeeId}",
            employee.Id);

        return CreatedAtAction(
            nameof(GetEmployeeById),
            new { id = employee.Id },
            employee);
    }


    // PUT: api/Employee/5

    [HttpPut("{id:int}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> UpdateEmployee(
        int id,
        UpdateEmployeeRequest request)
    {
        var employee = await _context.Employees.FindAsync(id);

        if (employee is null)
        {
            return NotFound(new
            {
                message = "Employee not found."
            });
        }

        var email = request.Email.Trim().ToLowerInvariant();

        var emailExists = await _context.Employees.AnyAsync(e =>
            e.Id != id && e.Email.ToLower() == email);

        if (emailExists)
        {
            return Conflict(new
            {
                message = "Another employee already uses this email."
            });
        }

        employee.FullName = request.FullName.Trim();
        employee.Email = email;
        employee.Department = request.Department.Trim();
        employee.Salary = request.Salary;
        employee.DateOfJoining = request.DateOfJoining;

        await _context.SaveChangesAsync();

        return Ok(employee);
    }


    // DELETE: api/Employee/5
    [HttpDelete("{id:int}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> DeleteEmployee(int id)
    {
        var employee = await _context.Employees.FindAsync(id);

        if (employee is null)
        {
            return NotFound(new
            {
                message = "Employee not found."
            });
        }

        _context.Employees.Remove(employee);
        await _context.SaveChangesAsync();

        _logger.LogInformation(
    "Employee deleted successfully. EmployeeId: {EmployeeId}",
    employee.Id);

        return Ok(new
        {
            message = "Employee deleted successfully."
        });
    }
}
