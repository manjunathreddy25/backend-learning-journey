using ASP_DotNetCore_TASKS.Models;

namespace ASP_DotNetCore_TASKS.Services
{
    public class OrderCreateService : IOrderCreateService
    {
        private readonly string instanceId;

        public OrderCreateService()
        {
            instanceId = Guid.NewGuid().ToString();
        }

        public Order CreateOrder(Order order)
        {
            OrderData.Orders.Add(order);

            return order;
        }

        public string GetInstanceId()
        {
            return instanceId;
        }
    }
}