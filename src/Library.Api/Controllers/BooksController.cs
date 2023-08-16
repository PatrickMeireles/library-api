using Library.Application.Services.Interface;
using Library.Domain.DTO.Base;
using Library.Domain.DTO.Book;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace Library.Api.Controllers;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiController]
public class BooksController : ControllerBase
{
    private readonly IBookServices _services;

    public BooksController(IBookServices services) =>
        _services = services;

    [HttpPost]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Post([FromBody] BookRequestDto model)
    {
        var result = await _services.Create(model);

        if (!result.HasValue)
            return BadRequest();

        return Created($"{HttpContext.Request.Path}/{result}", new { });
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(BookResponseDto))]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetById([Required] Guid id)
    {
        var result = await _services.GetById(id);

        if (result is null)
            return NotFound();

        return Ok(result);
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IEnumerable<BookResponseDto>))]
    public async Task<IActionResult> Get([FromQuery] BookQueryParamDto model, [FromQuery] int page = 1, [FromQuery] int size = 20, CancellationToken cancellationToken = default)
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
    public async Task<IActionResult> Update([Required] Guid id, [Required] BookRequestDto model, CancellationToken cancellationToken = default)
    {
        var result = await _services.Update(id, model, cancellationToken);

        if (!result)
            return NotFound();

        return Ok();
    }
}
