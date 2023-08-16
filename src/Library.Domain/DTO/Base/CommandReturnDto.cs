namespace Library.Domain.DTO.Base;

public class CommandReturnDto
{
    public bool Success { get; private set; }

    public CommandReturnDto() =>
        Success = false;

    public void Successfully() =>
        Success = true;

    public void Unsuccessfully() =>
        Success = false;
}
