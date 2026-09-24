using System.ComponentModel.DataAnnotations;

namespace ASP_DotNetCore_TASKS.Models
{
    public enum AttendanceStatus
    {
        Present,
        Absent,
        Late
    }
    public class Attendance
    {
        public int Id { get; set; }
        [StringLength(20)]
        public string StudentName { get; set; }
        [Required]
        public string Date { get; set; }

        [Required]
        public AttendanceStatus Status { get; set; }
        [Range(0, 100)]
        public int AttendancePercentage { get; set; }
    }
}