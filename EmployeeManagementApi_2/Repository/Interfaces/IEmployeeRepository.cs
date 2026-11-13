using EmployeeManagementAPI.Models;

namespace EmployeeManagementAPI.Repository.Interfaces;

public interface IEmployeeRepository
{
    Task<List<Employee>> GetAllAsync();

    Task<Employee?> GetByIdAsync(int id);

    Task<bool> DepartmentExistsAsync(int departmentId);

    Task<int> InsertAsync(Employee employee);

    Task<bool> UpdateAsync(Employee employee);

    Task<bool> DeleteAsync(int id);
}