using Library.Application.Notification;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Model;
using System.Linq.Expressions;

namespace Library.Application.Rules;

public class AuthorRules
{
    private readonly IAuthorEntityFrameworkRepository _authorRepository;
    private readonly IBookEntityFrameworkRepository _bookRepository;
    private readonly NotificationContext _notification;

    public AuthorRules(IAuthorEntityFrameworkRepository authorRepository, IBookEntityFrameworkRepository bookRepository, NotificationContext notification)
    {
        _authorRepository = authorRepository;
        _notification = notification;
        _bookRepository = bookRepository;
    }

    public virtual async Task<bool> CreateIsValidAsync(Author param, CancellationToken cancellationToken = default)
    {
        if (await ExistAuthor(c => c.Name == param.Name, cancellationToken))
        {
            _notification.AddNotification("Invalid Create Author", $"Cannot register {param.Name} as an Author because already exist.");
            return await Task.FromResult(false);
        }

        return await Task.FromResult(true);
    }

    public virtual async Task<bool> RemoveIsValidAsync(Guid id, CancellationToken cancellationToken = default)
    {
        var existBookWithAuthor = await _bookRepository.Get(c => c.BookAuthors.Any(c => c.AuthorId == id), page: 1, pageSize: 1, cancellationToken: cancellationToken);

        if (existBookWithAuthor.Any())
        {
            _notification.AddNotification("Invalid Remove Author", $"Cannot delete Author because exist a Book registered with this Author.");
            return await Task.FromResult(false);

        }
        return await Task.FromResult(true);
    }

    public virtual async Task<bool> UpdateIsValidAsync(Author param, CancellationToken cancellationToken = default)
    {
        if (await ExistAuthor(c => c.Name == param.Name && c.Id != param.Id, cancellationToken))
        {
            _notification.AddNotification("Invalid Update Author", $"Cannot register {param.Name} as an Author because already exist.");
            return await Task.FromResult(false);
        }

        return await Task.FromResult(true);
    }
    private async Task<bool> ExistAuthor(Expression<Func<Author, bool>> expression, CancellationToken cancellationToken = default)
    {
        var result = await _authorRepository.Get(expression, page: 1, pageSize: 1, cancellationToken: cancellationToken);

        return result.Any();
    }
}
