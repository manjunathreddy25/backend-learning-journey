using EmployeeManagementAPI.Models;

namespace EmployeeManagementAPI.Business.Interfaces;

public interface IEmployeeService
{
    Task<List<Employee>> GetAllAsync();

    Task<Employee?> GetByIdAsync(int id);

    Task<(int? EmployeeId, string? Error)> CreateAsync(Employee employee);

    Task<(bool Success, string? Error)> UpdateAsync(Employee employee);

    Task<bool> DeleteAsync(int id);
}