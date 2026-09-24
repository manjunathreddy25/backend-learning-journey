using ASP_DotNetCore_TASKS.Models;

namespace ASP_DotNetCore_TASKS.Services
{
    public class OrderUpdateService : IOrderUpdateService
    {
        private readonly string instanceId;

        public OrderUpdateService()
        {
            instanceId = Guid.NewGuid().ToString();
        }

        public Order UpdateOrder(int id, Order order)
        {
            var existingOrder = OrderData.Orders.FirstOrDefault(o => o.Id == id);

            if (existingOrder == null)
            {
                return null;
            }

            existingOrder.ProductName = order.ProductName;
            existingOrder.Brand = order.Brand;
            existingOrder.Price = order.Price;
            existingOrder.Status = order.Status;

            return existingOrder;
        }

        public string GetInstanceId()
        {
            return instanceId;
        }
    }
}