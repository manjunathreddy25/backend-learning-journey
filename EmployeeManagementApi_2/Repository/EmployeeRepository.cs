using EmployeeManagementAPI.Data;
using EmployeeManagementAPI.Models;
using EmployeeManagementAPI.Repository.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace EmployeeManagementAPI.Repository;

public class EmployeeRepository : IEmployeeRepository
{
    private readonly ApplicationDbContext _context;

    public EmployeeRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    // GET ALL EMPLOYEES
    public async Task<List<Employee>> GetAllAsync()
    {
        return await _context.Employees
            .Include(e => e.Department)
            .Include(e => e.EmployeeProjects)
                .ThenInclude(ep => ep.Project)
            .ToListAsync();
    }

    // GET EMPLOYEE BY ID
    public async Task<Employee?> GetByIdAsync(int id)
    {
        return await _context.Employees
            .Include(e => e.Department)
            .Include(e => e.EmployeeProjects)
                .ThenInclude(ep => ep.Project)
            .FirstOrDefaultAsync(e => e.Id == id);
    }

    // DepartmentExists
    public async Task<bool> DepartmentExistsAsync(int departmentId)
    {
        return await _context.Departments
            .AnyAsync(d => d.Id == departmentId);
    }

    // INSERT EMPLOYEE
    public async Task<int> InsertAsync(Employee employee)
    {
        var connection = _context.Database.GetDbConnection();

        await using var command = connection.CreateCommand();

        command.CommandText = "sp_InsertEmployee";
        command.CommandType = System.Data.CommandType.StoredProcedure;

        AddParameter(command, "p_Name", employee.Name);
        AddParameter(command, "p_Email", employee.Email);
        AddParameter(command, "p_Salary", employee.Salary);
        AddParameter(command, "p_DepartmentId", employee.DepartmentId);

        if (connection.State != System.Data.ConnectionState.Open)
            await connection.OpenAsync();

        var result = await command.ExecuteScalarAsync();

        return Convert.ToInt32(result);
    }

    // UPDATE EMPLOYEE
    public async Task<bool> UpdateAsync(Employee employee)
    {
        var connection = _context.Database.GetDbConnection();

        await using var command = connection.CreateCommand();

        command.CommandText = "sp_UpdateEmployee";
        command.CommandType = System.Data.CommandType.StoredProcedure;

        AddParameter(command, "p_EmployeeId", employee.Id);
        AddParameter(command, "p_Name", employee.Name);
        AddParameter(command, "p_Email", employee.Email);
        AddParameter(command, "p_Salary", employee.Salary);
        AddParameter(command, "p_DepartmentId", employee.DepartmentId);

        if (connection.State != System.Data.ConnectionState.Open)
            await connection.OpenAsync();

        var result = await command.ExecuteScalarAsync();

        return Convert.ToInt32(result) > 0;
    }

    // DELETE EMPLOYEE
    public async Task<bool> DeleteAsync(int id)
    {
        var connection = _context.Database.GetDbConnection();

        await using var command = connection.CreateCommand();

        command.CommandText = "sp_DeleteEmployee";
        command.CommandType = System.Data.CommandType.StoredProcedure;

        AddParameter(command, "p_EmployeeId", id);

        if (connection.State != System.Data.ConnectionState.Open)
            await connection.OpenAsync();

        var result = await command.ExecuteScalarAsync();

        return Convert.ToInt32(result) > 0;
    }

    // COMMON PARAMETER METHOD
    private static void AddParameter(
        System.Data.Common.DbCommand command,
        string name,
        object value)
    {
        var parameter = command.CreateParameter();

        parameter.ParameterName = name;
        parameter.Value = value;

        command.Parameters.Add(parameter);
    }
}