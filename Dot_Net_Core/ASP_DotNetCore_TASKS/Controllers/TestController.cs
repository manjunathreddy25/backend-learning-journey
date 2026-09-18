using ASP_DotNetCore_TASKS.Models;
using Microsoft.AspNetCore.Mvc;

namespace ASP_DotNetCore_TASKS.Controllers
{
    [ApiController]
    [Route("api/test")]
    public class TestController : ControllerBase
    {
        [HttpGet("welcome")]
        public string Hello()
        {
            return "Hello from Test API!";
        }
        [HttpPost("students")]
        public string AddStudent(Student student)
        {
            return $"Student received: {student.Name}";
        }
        [HttpPost("students-dto")]
        public string AddStudent(StudentDto student)
        {
            return $"Student received: {student.Name} \n Student Age: {student.Age}";
        }
    }
}