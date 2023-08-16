using Library.Data.Mapping.Base;
using Library.Domain.Model;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Library.Data.Mapping;

public class AuthorMapping : EFMappingConfiguration<Author>, IEFMappingEntrypoint
{
    public override void BuildMapping(EntityTypeBuilder<Author> builder)
    {
        builder.Property(c => c.Biography).IsRequired().HasColumnType("Text");
        builder.Property(c => c.Name).IsRequired();
    }
}
