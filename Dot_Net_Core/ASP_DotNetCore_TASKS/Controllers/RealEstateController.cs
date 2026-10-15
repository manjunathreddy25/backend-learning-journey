
using ASP_DotNetCore_TASKS.Models;
using ASP_DotNetCore_TASKS.Data;
using Microsoft.AspNetCore.Mvc;
using Asp.Versioning;
using System.Linq;
using System.Collections.Generic;

namespace ASP_DotNetCore_TASKS.Controllers
{
    /// <summary>
    /// Provides version 1 endpoints for managing real estate properties.
    /// </summary>

    [ApiController]
    [ApiVersion(1.0)]
    [Route("api/v{version:apiVersion}/[controller]")]
    public class RealEstateController : ControllerBase
    {
        /// <summary>
        /// Retrieves all v1 real estate properties.
        /// </summary>
        // GET: api/v1/RealEstate
        [HttpGet]
        public ActionResult<IEnumerable<RealEstateAPI>> GetAllProperties()
        {
            return Ok(RealEstateStore.Properties);
        }

        // GET: api/v1/RealEstate/1
        [HttpGet("{id:int}")]
        public ActionResult<RealEstateAPI> GetPropertyById(int id)
        {
            var property = RealEstateStore.Properties
                .FirstOrDefault(p => p.Id == id);

            if (property == null)
            {
                return NotFound(new
                {
                    message = $"Property with ID {id} was not found."
                });
            }

            return Ok(property);
        }

        // POST: api/v1/RealEstate
        [HttpPost]
        public ActionResult<RealEstateAPI> CreateProperty(
            [FromBody] RealEstateAPI property)
        {
            property.Id = RealEstateStore.Properties.Count == 0
                ? 1
                : RealEstateStore.Properties.Max(p => p.Id) + 1;

            property.CreatedAt = DateTime.UtcNow;

            RealEstateStore.Properties.Add(property);

            return CreatedAtAction(
                nameof(GetPropertyById),
                new { version = "1", id = property.Id },
                property);
        }

        // PUT: api/v1/RealEstate/1
        [HttpPut("{id:int}")]
        public ActionResult UpdateProperty(
            int id,
            [FromBody] RealEstateAPI updatedProperty)
        {
            var property = RealEstateStore.Properties
                .FirstOrDefault(p => p.Id == id);

            if (property == null)
            {
                return NotFound(new
                {
                    message = $"Property with ID {id} was not found."
                });
            }

            property.PropertyName = updatedProperty.PropertyName;
            property.PropertyType = updatedProperty.PropertyType;
            property.Price = updatedProperty.Price;
            property.Address = updatedProperty.Address;
            property.City = updatedProperty.City;
            property.State = updatedProperty.State;
            property.Country = updatedProperty.Country;
            property.Bedrooms = updatedProperty.Bedrooms;
            property.Bathrooms = updatedProperty.Bathrooms;
            property.AreaInSqFt = updatedProperty.AreaInSqFt;
            property.IsAvailable = updatedProperty.IsAvailable;
            property.Description = updatedProperty.Description;

            return Ok(property);
        }

        // DELETE: api/v1/RealEstate/1
        [HttpDelete("{id:int}")]
        public ActionResult DeleteProperty(int id)
        {
            var property = RealEstateStore.Properties
                .FirstOrDefault(p => p.Id == id);

            if (property == null)
            {
                return NotFound(new
                {
                    message = $"Property with ID {id} was not found."
                });
            }

            RealEstateStore.Properties.Remove(property);

            return Ok(new
            {
                message = "Property deleted successfully."
            });
        }
    }
}
