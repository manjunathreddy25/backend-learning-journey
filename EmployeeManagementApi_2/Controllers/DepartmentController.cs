using EmployeeManagementAPI.Data;
using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EmployeeManagementAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
public class DepartmentController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public DepartmentController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> CreateDepartment(
        DepartmentCreateDto dto)
    {
        var department = new Department
        {
            Name = dto.Name
        };

        _context.Departments.Add(department);

        await _context.SaveChangesAsync();

        return Ok(department);
    }

    [HttpGet]
    public async Task<IActionResult> GetDepartments()
    {
        var departments = await _context.Departments.ToListAsync();

        return Ok(departments);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetDepartmentById(int id)
    {
        var department = await _context.Departments.FindAsync(id);

        if (department == null)
        {
            return NotFound("Department not found");
        }

        return Ok(department);
    }
}