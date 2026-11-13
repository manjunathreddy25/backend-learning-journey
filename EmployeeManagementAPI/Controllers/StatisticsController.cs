
using EmployeeManagementAPI.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EmployeeManagementAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "Admin")]
public class StatisticsController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public StatisticsController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet("employees")]
    public async Task<IActionResult> GetEmployeeStatistics()
    {
        var employees = _context.Employees.AsNoTracking();

        var totalEmployees = await employees.CountAsync();

        var totalSalary = await employees
            .Select(e => (decimal?)e.Salary)
            .SumAsync() ?? 0m;

        var averageSalary = await employees
            .Select(e => (decimal?)e.Salary)
            .AverageAsync() ?? 0m;

        var highestSalary = await employees
            .Select(e => (decimal?)e.Salary)
            .MaxAsync() ?? 0m;

        var lowestSalary = await employees
            .Select(e => (decimal?)e.Salary)
            .MinAsync() ?? 0m;

        var departmentStatistics = await employees
            .GroupBy(e => e.Department)
            .Select(group => new
            {
                Department = group.Key,
                EmployeeCount = group.Count(),
                AverageSalary = group.Average(e => e.Salary)
            })
            .OrderByDescending(x => x.EmployeeCount)
            .ToListAsync();

        return Ok(new
        {
            totalEmployees,
            totalMonthlySalaryExpenditure = totalSalary,
            averageSalary,
            highestSalary,
            lowestSalary,
            departmentStatistics
        });
    }
}
