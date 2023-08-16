namespace Library.Domain.Message.Book;

public class BookAuthorMessage
{
    public Guid Id { get; set; }
    public Guid BookId { get; set; }
    public Guid AuthorId { get; set; }

    public BookAuthorMessage()
    {

    }
}
