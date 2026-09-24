using ASP_DotNetCore_TASKS.Models;

namespace ASP_DotNetCore_TASKS.Services
{
    public interface IOrderUpdateService
    {
        Order UpdateOrder(int id, Order order);
        string GetInstanceId();
    }
}