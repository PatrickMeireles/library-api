using Library.Data.Mapping.Base;
using Library.Domain.Model;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Library.Data.Mapping;

public class BookAuthorMapping : EFMappingConfiguration<BookAuthor>, IEFMappingEntrypoint
{
    public override void BuildMapping(EntityTypeBuilder<BookAuthor> builder)
    {
        builder.OwnsOne(c => c.Book);

        builder.HasKey(key => new { key.AuthorId, key.BookId });

        builder.HasOne(c => c.Author)
            .WithMany(c => c.BookAuthors)
            .HasForeignKey(c => c.AuthorId);

        builder.HasOne(c => c.Book)
            .WithMany(c => c.BookAuthors)
            .HasForeignKey(c => c.BookId);
    }
}
