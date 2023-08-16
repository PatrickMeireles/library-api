namespace Library.Data.Cache;

public class CacheSettings
{
    public int? AbsoluteExpirationRelativeHours { get;set; }
    public int? SlidingExpirationMinutes { get; set; }
}
