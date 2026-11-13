using EmployeeManagementAPI.Data;
using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EmployeeManagementAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
public class EmployeeProjectController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public EmployeeProjectController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpPost("assign")]
    public async Task<IActionResult> AssignEmployeeToProject(
        AssignEmployeeProjectDto dto)
    {
        var employee = await _context.Employees
            .FindAsync(dto.EmployeeId);

        if (employee == null)
        {
            return NotFound("Employee not found");
        }

        var project = await _context.Projects
            .FindAsync(dto.ProjectId);

        if (project == null)
        {
            return NotFound("Project not found");
        }

        var alreadyAssigned = await _context.EmployeeProjects
            .AnyAsync(ep =>
                ep.EmployeeId == dto.EmployeeId &&
                ep.ProjectId == dto.ProjectId);

        if (alreadyAssigned)
        {
            return BadRequest("Employee is already assigned to this project");
        }

        var assignment = new EmployeeProject
        {
            EmployeeId = dto.EmployeeId,
            ProjectId = dto.ProjectId,
            AssignedDate = DateTime.UtcNow
        };

        _context.EmployeeProjects.Add(assignment);

        await _context.SaveChangesAsync();

        return Ok(new
        {
            assignment.EmployeeId,
            assignment.ProjectId,
            assignment.AssignedDate
        });
    }

    [HttpGet]
    public async Task<IActionResult> GetAllAssignments()
    {
        var assignments = await _context.EmployeeProjects
            .Include(ep => ep.Employee)
            .Include(ep => ep.Project)
            .Select(ep => new
            {
                ep.EmployeeId,
                EmployeeName = ep.Employee.Name,
                ep.ProjectId,
                ProjectName = ep.Project.Name,
                ep.AssignedDate
            })
            .ToListAsync();

        return Ok(assignments);
    }
}