using ASP_DotNetCore_TASKS.Models;
using Microsoft.AspNetCore.Mvc;

namespace ASP_DotNetCore_TASKS.Controllers
{
    [ApiController]
    [Route("api/characters")]
    public class CharacterController : ControllerBase
    {
        private static List<Characters> characters = new List<Characters>();

        [HttpGet("get")]
        public IActionResult GetAllCharacters()
        {
            return Ok(characters);
        }
        [HttpPost("singlepost")]
        public IActionResult AddCharacter(Characters character)
        {
            characters.Add(character);

            return Ok(character);
        }
        [HttpPost("multipost")]
        public IActionResult AddMultiCharacters(List<Characters> charactersList)
        {
            characters.AddRange(charactersList);

            return Ok(charactersList);
        }
        [HttpGet("handlingIActionResult")]
        public IActionResult GetCharacter(int id)
        {
            var character = characters.FirstOrDefault(c => c.Id == id);

            if (character == null)
            {
                return NotFound();
            }

            return Ok(character);
        }
        [HttpGet("nothandlingIActionResult")]
        public Characters GetChar(int id)
        {
            var character = characters.FirstOrDefault(c => c.Id == id);

            return character;
        }
        [HttpPut("Put")]
        public IActionResult UpdateCharacter(int id, Characters character)
        {
            var existingCharacter = characters.FirstOrDefault(c => c.Id == id);

            if (existingCharacter == null)
            {
                return NotFound();
            }

            existingCharacter.Name = character.Name;
            existingCharacter.Village = character.Village;
            existingCharacter.Rank = character.Rank;

            return Ok(existingCharacter);
        }
        [HttpPatch("Patch")]
        public IActionResult PatchCharacter(int id, Characters character)
        {
            var existingCharacter = characters.FirstOrDefault(c => c.Id == id);

            if (existingCharacter == null)
            {
                return NotFound();
            }

            if (character.Name != null)
            {
                existingCharacter.Name = character.Name;
            }

            if (character.Village != null)
            {
                existingCharacter.Village = character.Village;
            }

            if (character.Rank != null)
            {
                existingCharacter.Rank = character.Rank;
            }

            return Ok(existingCharacter);
        }
        [HttpDelete("Delete")]
        public IActionResult DeleteCharacter(int id)
        {
            var character = characters.FirstOrDefault(c => c.Id == id);

            if (character == null)
            {
                return NotFound();
            }

            characters.Remove(character);

            //return NoContent();

            return Ok(character);
        }
    }
}