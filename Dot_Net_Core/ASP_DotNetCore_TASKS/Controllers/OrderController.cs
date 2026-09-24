using ASP_DotNetCore_TASKS.Models;
using ASP_DotNetCore_TASKS.Services;
using Microsoft.AspNetCore.Mvc;

namespace ASP_DotNetCore_TASKS.Controllers
{
    [ApiController]
    [Route("api/orders")]
    public class OrderController : ControllerBase
    {
        private readonly IOrderService _orderService;
        private readonly IOrderCreateService _orderCreateService;
        private readonly IOrderUpdateService _orderUpdateService;

        public OrderController(
            IOrderService orderService,
            IOrderCreateService orderCreateService,
            IOrderUpdateService orderUpdateService)
        {
            _orderService = orderService;
            _orderCreateService = orderCreateService;
            _orderUpdateService = orderUpdateService;
        }


        // =========================
        // GET → SCOPED
        // =========================

        [HttpGet("{id}")]
        public IActionResult GetOrder(int id)
        {
            var order = _orderService.GetOrderById(id);

            if (order == null)
            {
                return NotFound();
            }

            // Same service used 3 times
            var instanceId1 = _orderService.GetInstanceId();
            var instanceId2 = _orderService.GetInstanceId();
            var instanceId3 = _orderService.GetInstanceId();

            return Ok(new
            {
                order = order,

                instanceId1 = instanceId1,
                instanceId2 = instanceId2,
                instanceId3 = instanceId3
            });
        }


        // =========================
        // POST → SINGLETON
        // =========================

        [HttpPost]
        public IActionResult CreateOrder(Order order)
        {
            var result = _orderCreateService.CreateOrder(order);

            return Ok(new
            {
                order = result,
                instanceId = _orderCreateService.GetInstanceId()
            });
        }


        // =========================
        // PUT → TRANSIENT
        // =========================

        [HttpPut("{id}")]
        public IActionResult UpdateOrder(int id, Order order)
        {
            var result = _orderUpdateService.UpdateOrder(id, order);

            if (result == null)
            {
                return NotFound();
            }

            return Ok(new
            {
                order = result,
                instanceId = _orderUpdateService.GetInstanceId()
            });
        }
    }
}