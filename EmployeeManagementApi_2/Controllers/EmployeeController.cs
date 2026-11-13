using EmployeeManagementAPI.Business.Interfaces;
using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeManagementAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
public class EmployeeController : ControllerBase
{
    private readonly IEmployeeService _employeeService;

    public EmployeeController(IEmployeeService employeeService)
    {
        _employeeService = employeeService;
    }

    // CREATE EMPLOYEE
    [HttpPost]
    public async Task<IActionResult> CreateEmployee(EmployeeCreateDto dto)
    {
        var employee = new Employee
        {
            Name = dto.Name,
            Email = dto.Email,
            Salary = dto.Salary,
            DepartmentId = dto.DepartmentId
        };

        var result = await _employeeService.CreateAsync(employee);

        if (result.Error != null)
            return NotFound(result.Error);

        return Ok(new
        {
            Id = result.EmployeeId,
            employee.Name,
            employee.Email,
            employee.Salary,
            employee.DepartmentId
        });
    }

    // GET ALL EMPLOYEES
    [HttpGet]
    public async Task<IActionResult> GetEmployees()
    {
        var employees = await _employeeService.GetAllAsync();

        var result = employees.Select(e => new
        {
            e.Id,
            e.Name,
            e.Email,
            e.Salary,
            DepartmentName = e.Department.Name
        });

        return Ok(result);
    }

    // GET EMPLOYEE BY ID
    [HttpGet("{id}")]
    public async Task<IActionResult> GetEmployeeById(int id)
    {
        var employee = await _employeeService.GetByIdAsync(id);

        if (employee == null)
            return NotFound("Employee not found");

        return Ok(new
        {
            employee.Id,
            employee.Name,
            employee.Email,
            employee.Salary,
            DepartmentName = employee.Department.Name
        });
    }

    // UPDATE EMPLOYEE
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateEmployee(
        int id,
        EmployeeUpdateDto dto)
    {
        var employee = new Employee
        {
            Id = id,
            Name = dto.Name,
            Email = dto.Email,
            Salary = dto.Salary,
            DepartmentId = dto.DepartmentId
        };

        var result = await _employeeService.UpdateAsync(employee);

        if (!result.Success)
        {
            if (result.Error == "Department not found")
                return NotFound(result.Error);

            if (result.Error == "Employee not found")
                return NotFound(result.Error);

            return BadRequest(result.Error);
        }

        return Ok(employee);
    }

    // DELETE EMPLOYEE
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteEmployee(int id)
    {
        bool deleted = await _employeeService.DeleteAsync(id);

        if (!deleted)
            return NotFound("Employee not found");

        return Ok("Employee deleted successfully");
    }

    // GET EMPLOYEE DETAILS WITH PROJECTS
    [HttpGet("{id}/details")]
    public async Task<IActionResult> GetEmployeeDetails(int id)
    {
        var employee = await _employeeService.GetByIdAsync(id);

        if (employee == null)
            return NotFound("Employee not found");

        var result = new
        {
            employee.Id,
            employee.Name,
            employee.Email,
            employee.Salary,
            Department = employee.Department.Name,

            Projects = employee.EmployeeProjects.Select(ep => new
            {
                ep.Project.Id,
                ep.Project.Name,
                ep.AssignedDate
            })
        };

        return Ok(result);
    }
}