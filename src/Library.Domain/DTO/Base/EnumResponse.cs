namespace Library.Domain.DTO.Base;

public class EnumResponse
{
    public int Key { get; private set; }
    public string Description { get; private set; }
    public EnumResponse(int key, string description)
    {
        Key = key;
        Description = description;
    }

}
