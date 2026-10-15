
using Asp.Versioning;
using ASP_DotNetCore_TASKS.Models;
using ASP_DotNetCore_TASKS.Data;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ASP_DotNetCore_TASKS.Controllers
{
    /// <summary>
    /// Provides version 2 endpoints for managing real estate properties.
    /// </summary>
    [ApiController]
    [ApiVersion(2.0)]
    [Route("api/v{version:apiVersion}/[controller]")]
    public class RealEstateV2Controller : ControllerBase
    {
        // GET: api/v2/RealEstateV2
        /// <summary>
        /// Retrieves all v2 real estate properties.
        /// Supports city, property type, and price filtering
        /// </summary>
        [HttpGet]
        public ActionResult<IEnumerable<RealEstateAPI>> GetProperties(
            [FromQuery] string? city,
            [FromQuery] string? propertyType,
            [FromQuery] decimal? minPrice,
            [FromQuery] decimal? maxPrice)
        {
            var result = RealEstateStore.Properties.AsEnumerable();

            if (!string.IsNullOrWhiteSpace(city))
            {
                result = result.Where(p =>
                    p.City.Equals(
                        city,
                        StringComparison.OrdinalIgnoreCase));
            }

            if (!string.IsNullOrWhiteSpace(propertyType))
            {
                result = result.Where(p =>
                    p.PropertyType.Equals(
                        propertyType,
                        StringComparison.OrdinalIgnoreCase));
            }

            if (minPrice.HasValue)
            {
                result = result.Where(p =>
                    p.Price >= minPrice.Value);
            }

            if (maxPrice.HasValue)
            {
                result = result.Where(p =>
                    p.Price <= maxPrice.Value);
            }

            return Ok(result.ToList());
        }

        // GET: api/v2/RealEstateV2/1
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
    }
}
