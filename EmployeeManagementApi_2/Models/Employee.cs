
namespace EmployeeManagementAPI.Models;

public class Employee
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string Email { get; set; } = string.Empty;

    public decimal Salary { get; set; }

    public int DepartmentId { get; set; }

    public Department Department { get; set; } = null!;
    public ICollection<EmployeeProject> EmployeeProjects { get; set; }
    = new List<EmployeeProject>();
}
