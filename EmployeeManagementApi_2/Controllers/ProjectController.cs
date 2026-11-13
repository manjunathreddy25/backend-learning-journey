using EmployeeManagementAPI.Data;
using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EmployeeManagementAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ProjectController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public ProjectController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> CreateProject(ProjectCreateDto dto)
    {
        var project = new Project
        {
            Name = dto.Name
        };

        _context.Projects.Add(project);

        await _context.SaveChangesAsync();

        return Ok(project);
    }

    [HttpGet]
    public async Task<IActionResult> GetProjects()
    {
        var projects = await _context.Projects.ToListAsync();

        return Ok(projects);
    }
}