using System.ComponentModel.DataAnnotations;

namespace Library.Domain.DTO.Base;

public class PaginateRequest
{
    const int _minPage = 1;
    const int _maxSize = 50;

    [MinLength(1)]
    public int Page { get; set; } = 1;

    [MinLength(2)]
    public int Size { get; set; } = 20;

    public PaginateRequest(int page, int size)
    {
        Page = page;
        Size = size;

        if(page < _minPage)
            Page = _minPage;

        if(size > _maxSize)
            Size = _maxSize;
    }

    public static PaginateRequest Default => new(_minPage, _maxSize);
}
