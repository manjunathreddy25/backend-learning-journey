
using ASP_DotNetCore_TASKS.Models;

namespace ASP_DotNetCore_TASKS.Data
{
    public static class RealEstateStore
    {
        public static readonly List<RealEstateAPI> Properties = new()
        {
            new RealEstateAPI
            {
                Id = 1,
                PropertyName = "Green Valley Apartment",
                PropertyType = "Apartment",
                Price = 7500000,
                Address = "Madhapur",
                City = "Hyderabad",
                State = "Telangana",
                Country = "India",
                Bedrooms = 3,
                Bathrooms = 2,
                AreaInSqFt = 1500,
                IsAvailable = true,
                Description = "A spacious apartment in a prime location."
            },
            new RealEstateAPI
            {
                Id = 2,
                PropertyName = "Sunshine Villa",
                PropertyType = "Villa",
                Price = 15000000,
                Address = "Gachibowli",
                City = "Hyderabad",
                State = "Telangana",
                Country = "India",
                Bedrooms = 4,
                Bathrooms = 3,
                AreaInSqFt = 2500,
                IsAvailable = true,
                Description = "A modern villa."
            }
        };
    }
}
