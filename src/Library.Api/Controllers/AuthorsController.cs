using Library.Application.Services.Interface;
using Library.Domain.DTO.Author;
using Library.Domain.DTO.Base;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace Library.Api.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiController]
    [ApiVersion("1.0")]
    public class AuthorsController : ControllerBase
    {
        private readonly IAuthorServices _services;

        public AuthorsController(IAuthorServices authorServices) =>
            _services = authorServices;

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Post([FromBody] AuthorRequestDto model, CancellationToken cancellationToken = default)
        {
            var result = await _services.Create(model, cancellationToken);

            if (!result.HasValue)
                return BadRequest();

            return Created($"{HttpContext.Request.Path}/{result}", new { });
        }

        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(AuthorResponseDto))]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById([Required] Guid id, CancellationToken cancellationToken = default)
        {
            var result = await _services.GetById(id, cancellationToken);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IEnumerable<AuthorResponseDto>))]
        public async Task<IActionResult> Get([FromQuery] AuthorQueryParamDto model, [FromQuery] int page = 1, [FromQuery] int size = 20, CancellationToken cancellationToken = default)
        {
             var paginate = new PaginateRequest(page, size);

            var result = await _services.GetAll(paginate, model, cancellationToken);

            return Ok(result);
        }

        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Remove([Required] Guid id, CancellationToken cancellationToken = default)
        {
            var result = await _services.Remove(id, cancellationToken);

            if (!result)
                return NotFound();

            return Ok();
        }

        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Update([Required] Guid id, [Required] AuthorRequestDto model, CancellationToken cancellationToken = default)
        {
            var result = await _services.Update(id, model, cancellationToken);

            if (!result)
                return NotFound();

            return Ok();
        }
    }
}
