using EmployeeManagementAPI.Business.Interfaces;
using EmployeeManagementAPI.Models;
using EmployeeManagementAPI.Repository.Interfaces;

namespace EmployeeManagementAPI.Business;

public class EmployeeService : IEmployeeService
{
    private readonly IEmployeeRepository _employeeRepository;

    public EmployeeService(IEmployeeRepository employeeRepository)
    {
        _employeeRepository = employeeRepository;
    }

    public async Task<List<Employee>> GetAllAsync()
    {
        return await _employeeRepository.GetAllAsync();
    }

    public async Task<Employee?> GetByIdAsync(int id)
    {
        return await _employeeRepository.GetByIdAsync(id);
    }

    public async Task<(int? EmployeeId, string? Error)> CreateAsync(Employee employee)
    {
        bool departmentExists =
            await _employeeRepository.DepartmentExistsAsync(employee.DepartmentId);

        if (!departmentExists)
        {
            return (null, "Department not found");
        }

        int employeeId = await _employeeRepository.InsertAsync(employee);

        return (employeeId, null);
    }

    public async Task<(bool Success, string? Error)> UpdateAsync(Employee employee)
    {
        var existingEmployee =
            await _employeeRepository.GetByIdAsync(employee.Id);

        if (existingEmployee == null)
        {
            return (false, "Employee not found");
        }

        bool departmentExists =
            await _employeeRepository.DepartmentExistsAsync(employee.DepartmentId);

        if (!departmentExists)
        {
            return (false, "Department not found");
        }

        existingEmployee.Name = employee.Name;
        existingEmployee.Email = employee.Email;
        existingEmployee.Salary = employee.Salary;
        existingEmployee.DepartmentId = employee.DepartmentId;

        bool updated =
            await _employeeRepository.UpdateAsync(existingEmployee);

        return (updated, updated ? null : "Employee update failed");
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var employee = await _employeeRepository.GetByIdAsync(id);

        if (employee == null)
        {
            return false;
        }

        return await _employeeRepository.DeleteAsync(id);
    }
}