using ASP_DotNetCore_TASKS.Models;

namespace ASP_DotNetCore_TASKS.Services
{
    public interface IOrderCreateService
    {
        Order CreateOrder(Order order);
        string GetInstanceId();
    }
}