
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BankingFraudDetection.Models
{
    [Table("card_transactions_27")]
    public class CardTransaction
    {
        [Key]
        [Column("card_transaction_id")]
        public int CardTransactionId { get; set; }

        [Column("card_id")]
        public int CardId { get; set; }

        [Column("amount")]
        public decimal Amount { get; set; }

        [Column("transaction_time")]
        public DateTime TransactionTime { get; set; }

        [Column("city_id")]
        public int CityId { get; set; }

        [Column("merchant_name")]
        public string MerchantName { get; set; } = string.Empty;
    }
}