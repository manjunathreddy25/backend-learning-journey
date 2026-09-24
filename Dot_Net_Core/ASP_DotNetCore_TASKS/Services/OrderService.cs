using ASP_DotNetCore_TASKS.Models;

namespace ASP_DotNetCore_TASKS.Services
{
    public class OrderService : IOrderService
    {
        private readonly string instanceId;

        public OrderService()
        {
            instanceId = Guid.NewGuid().ToString();
        }

        public Order GetOrderById(int id)
        {
            return OrderData.Orders.FirstOrDefault(o => o.Id == id);
        }

        public string GetInstanceId()
        {
            return instanceId;
        }
    }
}