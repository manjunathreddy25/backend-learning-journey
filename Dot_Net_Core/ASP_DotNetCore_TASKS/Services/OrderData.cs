using ASP_DotNetCore_TASKS.Models;

namespace ASP_DotNetCore_TASKS.Services
{
    public static class OrderData
    {
        public static List<Order> Orders = new List<Order>
        {
            new Order
            {
                Id = 101,
                ProductName = "Nike Air Max",
                Brand = "Nike",
                Price = 5999,
                Status = "Shipped"
            },

            new Order
            {
                Id = 102,
                ProductName = "Roadster T-Shirt",
                Brand = "Roadster",
                Price = 899,
                Status = "Delivered"
            },

            new Order
            {
                Id = 103,
                ProductName = "Puma Sneakers",
                Brand = "Puma",
                Price = 2999,
                Status = "Out for Delivery"
            }
        };
    }
}