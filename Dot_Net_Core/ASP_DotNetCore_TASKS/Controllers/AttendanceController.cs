using ASP_DotNetCore_TASKS.Models;
using Microsoft.AspNetCore.Mvc;

namespace ASP_DotNetCore_TASKS.Controllers
{
    [ApiController]
    [Route("api/attendance")]
    public class AttendanceController : ControllerBase
    {
        private static List<Attendance> attendance = new List<Attendance>
        {
            new Attendance
            {
                Id = 1,
                StudentName = "Naruto",
                Date = "2026-09-21",
                Status = AttendanceStatus.Present,
                AttendancePercentage = 55
            },

            new Attendance
            {
                Id = 2,
                StudentName = "Sasuke",
                Date = "2026-09-21",
                Status = AttendanceStatus.Absent,
                AttendancePercentage = 50
            }
        };


        // =========================
        // 200 OK
        // =========================

        [HttpGet("{id}")]
        public IActionResult GetAttendance(int id)
        {
            var record = attendance.FirstOrDefault(a => a.Id == id);

            if (record == null)
            {
                return NotFound();
            }

            return Ok(record);
        }


        // =========================
        // 400 Bad Request
        // =========================

        [HttpGet("search")]
        public IActionResult SearchAttendance(string studentName)
        {
            if (string.IsNullOrWhiteSpace(studentName))
            {
                return BadRequest("Student name is required.");
            }
            var record = attendance.FirstOrDefault(a => a.StudentName == studentName);
            if (record == null)
            {
                return NotFound("Student name is Not Found.");
            }

            return Ok($"Searching attendance for {studentName}");
        }


        // =========================
        // 404 Not Found
        // =========================

        [HttpGet("check/{id}")]
        public IActionResult CheckAttendance(int id)
        {
            var record = attendance.FirstOrDefault(a => a.Id == id);

            if (record == null)
            {
                return NotFound("Attendance record not found.");
            }

            return Ok(record);
        }
        [HttpPost("studentattendenceinfo")]
        public IActionResult AddingStudentAttendence(Attendance a)
        {
            attendance.Add(a);
            return Ok(a);
        }

    }
}