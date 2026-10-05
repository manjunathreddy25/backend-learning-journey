using BankingFraudDetection.Models;
using Microsoft.EntityFrameworkCore;


namespace ASP_DotNetCore_TASKS.Data
{
    public class Banking_Fraud_DetectionDBContext : DbContext
    {
        public Banking_Fraud_DetectionDBContext(DbContextOptions<Banking_Fraud_DetectionDBContext> options)
            : base(options)
        { }
        public DbSet<CardTransaction> CardTransactions { get; set; }
    }
}
