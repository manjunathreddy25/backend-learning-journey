
namespace ASP_DotNetCore_TASKS.Models
{
    public class RealEstateAPI
    {
        public int Id { get; set; }

        public string PropertyName { get; set; } = string.Empty;

        public string PropertyType { get; set; } = string.Empty;

        public decimal Price { get; set; }

        public string Address { get; set; } = string.Empty;

        public string City { get; set; } = string.Empty;

        public string State { get; set; } = string.Empty;

        public string Country { get; set; } = string.Empty;

        public int Bedrooms { get; set; }

        public int Bathrooms { get; set; }

        public decimal AreaInSqFt { get; set; }

        public bool IsAvailable { get; set; }

        public string Description { get; set; } = string.Empty;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}

