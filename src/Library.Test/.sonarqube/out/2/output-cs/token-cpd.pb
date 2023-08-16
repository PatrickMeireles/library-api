˜$
SC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Cache\CacheService.cs
	namespace 	
Library
 
. 
Data 
. 
Cache 
; 
public 
class 
CacheService 
: 
ICacheService )
{ 
private		 
readonly		 
IDistributedCache		 &
_cache		' -
;		- .
private

 
readonly

 (
DistributedCacheEntryOptions

 1)
_distributedCacheEntryOptions

2 O
;

O P
public 

CacheService 
( 
IDistributedCache )
cache* /
,/ 0
IOptions1 9
<9 :
CacheSettings: G
>G H
cacheSettingsI V
)V W
{ 
_cache 
= 
cache 
; )
_distributedCacheEntryOptions %
=& '
new( +(
DistributedCacheEntryOptions, H
(H I
)I J
;J K
if 

( 
cacheSettings 
. 
Value 
.  +
AbsoluteExpirationRelativeHours  ?
.? @
HasValue@ H
)H I)
_distributedCacheEntryOptions )
.) *+
AbsoluteExpirationRelativeToNow* I
=J K
TimeSpanL T
.T U
	FromHoursU ^
(^ _
cacheSettings_ l
.l m
Valuem r
.r s,
AbsoluteExpirationRelativeHours	s í
.
í ì
Value
ì ò
)
ò ô
;
ô ö
if 

( 
cacheSettings 
. 
Value 
.  $
SlidingExpirationMinutes  8
.8 9
HasValue9 A
)A B)
_distributedCacheEntryOptions )
.) *
SlidingExpiration* ;
=< =
TimeSpan> F
.F G
	FromHoursG P
(P Q
cacheSettingsQ ^
.^ _
Value_ d
.d e$
SlidingExpirationMinutese }
.} ~
Value	~ É
)
É Ñ
;
Ñ Ö
} 
public 

virtual 
async 
Task 
< 
T 
?  
>  !
GetAsync" *
<* +
T+ ,
>, -
(- .
string. 4
key5 8
,8 9
CancellationToken: K
cancellationTokenL ]
=^ _
default` g
)g h
{ 
var 
value 
= 
await 
_cache  
.  !
GetAsync! )
() *
key* -
,- .
cancellationToken/ @
)@ A
;A B
if 

( 
value 
== 
null 
) 
return 
default 
; 
var 
deserialize 
= 
JsonSerializer (
.( )
Deserialize) 4
<4 5
T5 6
>6 7
(7 8
value8 =
)= >
;> ?
return!! 
deserialize!! 
;!! 
}"" 
public$$ 

virtual$$ 
async$$ 
Task$$ 
RemoveAsync$$ )
($$) *
string$$* 0
key$$1 4
,$$4 5
CancellationToken$$6 G
cancellationToken$$H Y
=$$Z [
default$$\ c
)$$c d
{%% 
await&& 
_cache&& 
.&& 
RemoveAsync&&  
(&&  !
key&&! $
,&&$ %
cancellationToken&&& 7
)&&7 8
;&&8 9
}'' 
public)) 

virtual)) 
async)) 
Task)) 
SetAsync)) &
<))& '
T))' (
>))( )
())) *
string))* 0
key))1 4
,))4 5
T))6 7
value))8 =
,))= >
CancellationToken))? P
cancellationToken))Q b
=))c d
default))e l
)))l m
{** 
var++ 
encoding++ 
=++ 
JsonSerializer++ %
.++% & 
SerializeToUtf8Bytes++& :
(++: ;
value++; @
)++@ A
;++A B
await-- 
_cache-- 
.-- 
SetAsync-- 
(-- 
key-- !
,--! "
encoding--# +
,--+ ,)
_distributedCacheEntryOptions--- J
,--J K
cancellationToken--L ]
)--] ^
;--^ _
}.. 
}// £
TC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Cache\CacheSettings.cs
	namespace 	
Library
 
. 
Data 
. 
Cache 
; 
public 
class 
CacheSettings 
{ 
public 

int 
? +
AbsoluteExpirationRelativeHours /
{0 1
get2 5
;5 6
set6 9
;9 :
}; <
public 

int 
? $
SlidingExpirationMinutes (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
} ª	
TC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Cache\ICacheService.cs
	namespace 	
Library
 
. 
Data 
. 
Cache 
; 
public 
	interface 
ICacheService 
{ 
Task 
< 	
T	 

?
 
> 
GetAsync 
< 
T 
> 
( 
string 
key  #
,# $
CancellationToken% 6
cancellationToken7 H
=I J
defaultK R
)R S
;S T
Task 
SetAsync	 
< 
T 
> 
( 
string 
key 
,  
T! "
value# (
,( )
CancellationToken* ;
cancellationToken< M
=N O
defaultP W
)W X
;X Y
Task 
RemoveAsync	 
( 
string 
key 
,  
CancellationToken! 2
cancellationToken3 D
=E F
defaultG N
)N O
;O P
} ±
\C:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Cache\RedisCacheHealthCheck.cs
	namespace 	
Library
 
. 
Data 
. 
Cache 
; 
public 
class !
RedisCacheHealthCheck "
:# $
IHealthCheck% 1
{		 
private

 
readonly

 
RedisCacheOptions

 &
_options

' /
;

/ 0
private 
readonly !
ConnectionMultiplexer *
_redis+ 1
;1 2
public 
!
RedisCacheHealthCheck  
(  !
IOptions! )
<) *
RedisCacheOptions* ;
>; <
optionsAccessor= L
)L M
{ 
_options 
= 
optionsAccessor "
." #
Value# (
;( )
_redis 
= !
ConnectionMultiplexer &
.& '
Connect' .
(. / 
GetConnectionOptions/ C
(C D
)D E
)E F
;F G
} 
public 

Task 
< 
HealthCheckResult !
>! "
CheckHealthAsync# 3
(3 4
HealthCheckContext4 F
contextG N
,N O
CancellationTokenP a
cancellationTokenb s
=t u
defaultv }
)} ~
{ 
var 
isConnected 
= 
_redis  
.  !
IsConnected! ,
;, -
var 
task 
= 
Task 
. 

FromResult "
(" #
isConnected# .
?/ 0
HealthCheckResult1 B
.B C
HealthyC J
(J K
)K L
:M N
HealthCheckResultO `
.` a
	Unhealthya j
(j k
$str	k ä
)
ä ã
)
å ç
;
ç é
return 
task 
; 
} 
private  
ConfigurationOptions   
GetConnectionOptions! 5
(5 6
)6 7
{  
ConfigurationOptions "
redisConnectionOptions 3
=4 5
(6 7
_options7 ?
.? @ 
ConfigurationOptions@ T
!=U W
nullX \
)\ ]
?  
ConfigurationOptions "
." #
Parse# (
(( )
_options) 1
.1 2 
ConfigurationOptions2 F
.F G
ToStringG O
(O P
)P Q
)Q R
:    
ConfigurationOptions   "
.  " #
Parse  # (
(  ( )
_options  ) 1
.  1 2
Configuration  2 ?
)  ? @
;  @ A"
redisConnectionOptions"" 
."" 
AbortOnConnectFail"" 1
=""2 3
false""4 9
;""9 :
return$$ "
redisConnectionOptions$$ %
;$$% &
}%% 
}&& °
TC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Cache\RedisSettings.cs
	namespace 	
Library
 
. 
Data 
. 
Cache 
; 
public 
class 
RedisSettings 
{ 
public 

string 
Configuration 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
string0 6
.6 7
Empty7 <
;< =
} πJ
JC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Configure.cs
	namespace 	
Library
 
. 
Data 
; 
public 
static 
class 
	Configure 
{ 
public 

static 
void 
ConfigureData $
($ %
this% )
IServiceCollection* <
services= E
,E F
IConfigurationG U
configurationV c
)c d
{ 
services 
. 
AddRepositories  
(  !
)! "
;" #
services 
. 
ConfigureSqlServer #
(# $
configuration$ 1
)1 2
;2 3
services 
. 
ConfigureMongoDb !
(! "
configuration" /
)/ 0
;0 1
services 
. 
ConfigureRedis 
(  
configuration  -
)- .
;. /
services 
. 
AddHealthCheck 
(  
)  !
;! "
} 
public 

static 
void 
AddRepositories &
(& '
this' +
IServiceCollection, >
services? G
)G H
{ 
services 
. 
	AddScoped 
< *
IBookEntityFrameworkRepository 9
,9 :)
BookEntityFrameworkRepository; X
>X Y
(Y Z
)Z [
;[ \
services 
. 
	AddScoped 
< ,
 IAuthorEntityFrameworkRepository ;
,; <+
AuthorEntityFrameworkRepository= \
>\ ]
(] ^
)^ _
;_ `
services   
.   
	AddScoped   
<   "
IAuthorMongoRepository   1
,  1 2!
AuthorMongoRepository  3 H
>  H I
(  I J
)  J K
;  K L
services!! 
.!! 
	AddScoped!! 
<!!  
IBookMongoRepository!! /
,!!/ 0
BookMongoRepository!!1 D
>!!D E
(!!E F
)!!F G
;!!G H
}"" 
public$$ 

static$$ 
void$$ 
ConfigureSqlServer$$ )
($$) *
this$$* .
IServiceCollection$$/ A
services$$B J
,$$J K
IConfiguration$$L Z
configuration$$[ h
)$$h i
{%% 
var&& 
connectionString&& 
=&& 
configuration&& ,
[&&, -
$str&&- T
]&&T U
;&&U V
if(( 

((( 
string(( 
.(( 
IsNullOrWhiteSpace(( %
(((% &
connectionString((& 6
)((6 7
)((7 8
throw)) 
new)) 
ArgumentException)) '
())' (
$str))( \
)))\ ]
;))] ^
var++ 
options++ 
=++ 
new++ #
DbContextOptionsBuilder++ 1
<++1 2"
EntityFrameworkContext++2 H
>++H I
(++I J
)++J K
;++K L
options,, 
.,, 
	UseNpgsql,, 
(,, 
connectionString,, *
),,* +
;,,+ ,
_-- 	
=--
 
new-- "
EntityFrameworkContext-- &
(--& '
options--' .
.--. /
Options--/ 6
)--6 7
;--7 8
services// 
.// 
AddDbContext// 
<// "
EntityFrameworkContext// 4
>//4 5
(//5 6
options//6 =
=>//> @
{00 	
options11 
.11 
	UseNpgsql11 
(11 
connectionString11 .
)11. /
;11/ 0
options22 
.22 &
EnableSensitiveDataLogging22 .
(22. /
)22/ 0
;220 1
options33 
.33 $
UseQueryTrackingBehavior33 ,
(33, -!
QueryTrackingBehavior33- B
.33B C

NoTracking33C M
)33M N
;33N O
}44 	
)44	 

;44
 
}55 
private77 
static77 
void77 
ConfigureMongoDb77 (
(77( )
this77) -
IServiceCollection77. @
services77A I
,77I J
IConfiguration77K Y
configuration77Z g
)77g h
{88 
var99 
param99 
=99 
configuration99 !
.99! "

GetSection99" ,
(99, -
$str99- <
)99< =
;99= >
var;; 
connectionString;; 
=;; 
param;; $
[;;$ %
$str;;% 7
];;7 8
;;;8 9
if== 

(== 
string== 
.== 
IsNullOrWhiteSpace== %
(==% &
connectionString==& 6
)==6 7
)==7 8
throw>> 
new>> 
ArgumentException>> '
(>>' (
$str>>( Y
)>>Y Z
;>>Z [
services@@ 
.@@ 
PostConfigure@@ 
<@@ 
MongoSettings@@ ,
>@@, -
(@@- .
c@@. /
=>@@0 2
{AA 	
cBB 
.BB 

ConnectionBB 
=BB 
paramBB  
[BB  !
$strBB! 3
]BB3 4
;BB4 5
cCC 
.CC 
DatabaseNameCC 
=CC 
paramCC "
[CC" #
$strCC# 1
]CC1 2
;CC2 3
}DD 	
)DD	 

;DD
 
servicesFF 
.FF 
	AddScopedFF 
<FF 
MongoDbContextFF )
>FF) *
(FF* +
)FF+ ,
;FF, -
}GG 
privateII 
staticII 
voidII 
ConfigureRedisII &
(II& '
thisII' +
IServiceCollectionII, >
servicesII? G
,IIG H
IConfigurationIII W
configurationIIX e
)IIe f
{JJ 
servicesKK 
.KK 
	AddScopedKK 
<KK 
ICacheServiceKK (
,KK( )
CacheServiceKK* 6
>KK6 7
(KK7 8
)KK8 9
;KK9 :
servicesMM 
.MM 
PostConfigureMM 
<MM 
RedisSettingsMM ,
>MM, -
(MM- .
cMM. /
=>MM0 2
{NN 	
cOO 
.OO 
ConfigurationOO 
=OO 
configurationOO +
[OO+ ,
$strOO, D
]OOD E
;OOE F
}PP 	
)PP	 

;PP
 
varRR  
trySlidingExpirationRR  
=RR! "
intRR# &
.RR& '
TryParseRR' /
(RR/ 0
configurationRR0 =
[RR= >
$strRR> j
]RRj k
,RRk l
outRRm p
intRRq t
slidingExpiration	RRu Ü
)
RRÜ á
;
RRá à
varSS .
"tryAbsoluteExpirationRelativeToNowSS .
=SS/ 0
intSS1 4
.SS4 5
TryParseSS5 =
(SS= >
configurationSS> K
[SSK L
$strSSL y
]SSy z
,SSz {
outSS| 
int
SSÄ É-
absoluteExpirationRelativeToNow
SSÑ £
)
SS£ §
;
SS§ •
servicesUU 
.UU 
PostConfigureUU 
<UU 
CacheSettingsUU ,
>UU, -
(UU- .
cUU. /
=>UU0 2
{VV 	
cWW 
.WW $
SlidingExpirationMinutesWW &
=WW' ( 
trySlidingExpirationWW) =
?WW> ?
nullWW@ D
:WWE F
slidingExpirationWWG X
;WWX Y
cXX 
.XX +
AbsoluteExpirationRelativeHoursXX -
=XX. /.
"tryAbsoluteExpirationRelativeToNowXX0 R
?XXS T
nullXXU Y
:XXZ [+
absoluteExpirationRelativeToNowXX\ {
;XX{ |
}YY 	
)YY	 

;YY
 
services[[ 
.[[ &
AddStackExchangeRedisCache[[ +
([[+ ,
options[[, 3
=>[[4 6
{\\ 	
options]] 
.]] 
Configuration]] !
=]]" #
configuration]]$ 1
[]]1 2
$str]]2 J
]]]J K
;]]K L
}^^ 	
)^^	 

;^^
 
}__ 
privatebb 
staticbb 
voidbb 
AddHealthCheckbb &
(bb& '
thisbb' +
IServiceCollectionbb, >
servicesbb? G
)bbG H
{cc 
servicesdd 
.dd 
AddHealthChecksdd  
(dd  !
)dd! "
.ee 
AddDbContextCheckee "
<ee" #"
EntityFrameworkContextee# 9
>ee9 :
(ee: ;
$stree; C
)eeC D
;eeD E
servicesgg 
.gg 
AddHealthChecksgg  
(gg  !
)gg! "
.hh 
AddCheckhh 
<hh 
MongoDbHealthCheckhh (
>hh( )
(hh) *
$strhh* 1
)hh1 2
;hh2 3
servicesjj 
.jj 
AddHealthChecksjj  
(jj  !
)jj! "
.kk 
AddCheckkk 
<kk !
RedisCacheHealthCheckkk *
>kk* +
(kk+ ,
$strkk, 3
)kk3 4
;kk4 5
}nn 
}oo ú#
_C:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Context\EntityFrameworkContext.cs
	namespace		 	
Library		
 
.		 
Infrastructure		  
.		  !
Data		! %
.		% &
EF		& (
;		( )
public 
class "
EntityFrameworkContext #
:$ %
	DbContext& /
,/ 0
IContext1 9
{ 
private 
readonly !
IDbContextTransaction *
_transaction+ 7
;7 8
private 
readonly 
DomainHandler "
_domainHandler# 1
;1 2
private 
readonly 
	IMediator 
	_mediator (
;( )
public 
"
EntityFrameworkContext !
(! "
DbContextOptions" 2
<2 3"
EntityFrameworkContext3 I
>I J
optionsK R
,R S
DomainHandlerT a
domainHandlerb o
,o p
	IMediatorq z
mediator	{ É
)
É Ñ
:
Ö Ü
base
á ã
(
ã å
options
å ì
)
ì î
{ 
_transaction 
= 
Database 
.  
BeginTransaction  0
(0 1
)1 2
;2 3
_domainHandler 
= 
domainHandler &
;& '
	_mediator 
= 
mediator 
; 
} 
public 
"
EntityFrameworkContext !
(! "
DbContextOptions" 2
<2 3"
EntityFrameworkContext3 I
>I J
optionsK R
)R S
:T U
baseV Z
(Z [
options[ b
)b c
{ 
if 

( 
Database 
. 
IsRelational !
(! "
)" #
)# $
Database 
. 
Migrate 
( 
) 
; 
} 
public 
"
EntityFrameworkContext !
(! "
)" #
{ 
}!! 
	protected## 
override## 
void## 
OnModelCreating## +
(##+ ,
ModelBuilder##, 8
modelBuilder##9 E
)##E F
{$$ 
modelBuilder%% 
.%% +
ApplyConfigurationsFromAssembly%% 4
(%%4 5
typeof%%5 ;
(%%; < 
IEFMappingEntrypoint%%< P
)%%P Q
.%%Q R
Assembly%%R Z
)%%Z [
;%%[ \
base'' 
.'' 
OnModelCreating'' 
('' 
modelBuilder'' )
)'') *
;''* +
}(( 
public** 

virtual** 
async** 
Task** 
<** 
bool** "
>**" #
CommitAsync**$ /
(**/ 0
CancellationToken**0 A
cancellationToken**B S
=**T U
default**V ]
)**] ^
{++ 
try,, 
{-- 	
var.. 
saveChanges.. 
=.. 
await.. #
SaveChangesAsync..$ 4
(..4 5
cancellationToken..5 F
)..F G
>..H I
$num..J K
;..K L
if00 
(00 
!00 
saveChanges00 
)00 
return11 
false11 
;11 
await33 
	_mediator33 
.33  
DispatchDomainEvents33 0
(330 1
_domainHandler331 ?
.33? @
DomainEvents33@ L
,33L M
cancellationToken33N _
)33_ `
;33` a
_domainHandler55 
.55 
ClearEvents55 &
(55& '
)55' (
;55( )
await77 
_transaction77 
.77 
CommitAsync77 *
(77* +
cancellationToken77+ <
)77< =
;77= >
return99 
true99 
;99 
}:: 	
catch;; 
(;; 
	Exception;; 
);; 
{<< 	
_domainHandler== 
.== 
ClearEvents== &
(==& '
)==' (
;==( )
await>> 
_transaction>> 
.>> 
RollbackAsync>> ,
(>>, -
cancellationToken>>- >
)>>> ?
;>>? @
throw@@ 
;@@ 
}AA 	
}BB 
}CC î
QC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Context\IContext.cs
	namespace 	
Library
 
. 
Data 
. 
Context 
; 
public 
	interface 
IContext 
{ 
Task 
< 	
bool	 
> 
CommitAsync 
( 
CancellationToken ,
cancellationToken- >
=? @
defaultA H
)H I
;I J
} › 
WC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Context\MongoDbContext.cs
	namespace		 	
Library		
 
.		 
Infrastructure		  
.		  !
Data		! %
.		% &
Mongo		& +
;		+ ,
public 
class 
MongoDbContext 
: 
IContext &
,& '
IAsyncDisposable( 8
{ 
private 
MongoClient 
MongoClient #
{$ %
get& )
;) *
set+ .
;. /
}0 1
private 
readonly 
DomainHandler "
_domainHandler# 1
;1 2
private 
IMongoDatabase 
MongoDatabase (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
private 
readonly 
	IMediator 
	_mediator (
;( )
public 

MongoDbContext 
( 
IOptions "
<" #
MongoSettings# 0
>0 1
configuration2 ?
,? @
DomainHandlerA N
domainHandlerO \
,\ ]
	IMediator^ g
mediatorh p
)p q
{ 
MongoClient 
= 
new 
MongoClient %
(% &
configuration& 3
.3 4
Value4 9
.9 :

Connection: D
)D E
;E F
MongoDatabase 
= 
MongoClient #
.# $
GetDatabase$ /
(/ 0
configuration0 =
.= >
Value> C
.C D
DatabaseNameD P
)P Q
;Q R
_domainHandler 
= 
domainHandler &
;& '
	_mediator 
= 
mediator 
; 
ConventionRegistry 
. 
Register #
(# $
$str$ 3
,3 4
new5 8
ConventionPack9 G
{H I
newJ M"
IgnoreIfNullConventionN d
(d e
truee i
)i j
}k l
,l m
tn o
=>p r
trues w
)w x
;x y
} 
public 

virtual 
IMongoCollection #
<# $
T$ %
>% &
GetCollection' 4
<4 5
T5 6
>6 7
(7 8
string8 >
name? C
)C D
{   
return!! 
MongoDatabase!! 
.!! 
GetCollection!! *
<!!* +
T!!+ ,
>!!, -
(!!- .
name!!. 2
)!!2 3
;!!3 4
}"" 
public$$ 

async$$ 
Task$$ 
<$$ 
bool$$ 
>$$ 
CommitAsync$$ '
($$' (
CancellationToken$$( 9
cancellationToken$$: K
=$$L M
default$$N U
)$$U V
{%% 
try&& 
{'' 	
await(( 
	_mediator(( 
.((  
DispatchDomainEvents(( 0
(((0 1
_domainHandler((1 ?
.((? @
DomainEvents((@ L
,((L M
cancellationToken((N _
)((_ `
;((` a
_domainHandler** 
.** 
ClearEvents** &
(**& '
)**' (
;**( )
return,, 
true,, 
;,, 
}-- 	
catch.. 
(.. 
	Exception.. 
).. 
{// 	
_domainHandler00 
.00 
ClearEvents00 &
(00& '
)00' (
;00( )
throw22 
;22 
}33 	
}44 
public66 

	ValueTask66 
DisposeAsync66 !
(66! "
)66" #
{77 
GC88 

.88
 
SuppressFinalize88 
(88 
this88  
)88  !
;88! "
return99 
	ValueTask99 
.99 
CompletedTask99 &
;99& '
}:: 
};; ò
[C:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Context\MongoDbHealthCheck.cs
	namespace 	
Library
 
. 
Data 
. 
Context 
; 
public		 
class		 
MongoDbHealthCheck		 
:		  !
IHealthCheck		" .
{

 
private 
IMongoDatabase 
MongoDatabase (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public 

MongoClient 
MongoClient "
{# $
get% (
;( )
set* -
;- .
}/ 0
private 
string 
DatabaseName 
{  !
get" %
;% &
set' *
;* +
}, -
public 

MongoDbHealthCheck 
( 
IOptions &
<& '
MongoSettings' 4
>4 5
configuration6 C
)C D
{ 
MongoClient 
= 
new 
MongoClient %
(% &
configuration& 3
.3 4
Value4 9
.9 :

Connection: D
)D E
;E F
MongoDatabase 
= 
MongoClient #
.# $
GetDatabase$ /
(/ 0
configuration0 =
.= >
Value> C
.C D
DatabaseNameD P
)P Q
;Q R
DatabaseName 
= 
configuration $
.$ %
Value% *
.* +
DatabaseName+ 7
;7 8
} 
public 

async 
Task 
< 
HealthCheckResult '
>' (
CheckHealthAsync) 9
(9 :
HealthCheckContext: L
contextM T
,T U
CancellationTokenV g
cancellationTokenh y
=z {
default	| É
)
É Ñ
{ 
var $
healthCheckResultHealthy $
=% &
await' ,'
CheckMongoDBConnectionAsync- H
(H I
)I J
;J K
if 

( $
healthCheckResultHealthy $
)$ %
{ 	
return 
HealthCheckResult $
.$ %
Healthy% ,
(, -
$"- /
$str/ @
{@ A
DatabaseNameA M
}M N
$strN c
"c d
)d e
;e f
} 	
return 
HealthCheckResult  
.  !
	Unhealthy! *
(* +
$"+ -
$str- >
{> ?
DatabaseName? K
}K L
$strL a
"a b
)b c
;c d
}   
private"" 
async"" 
Task"" 
<"" 
bool"" 
>"" '
CheckMongoDBConnectionAsync"" 8
(""8 9
)""9 :
{## 
try$$ 
{%% 	
await&& 
MongoDatabase&& 
.&&  
RunCommandAsync&&  /
(&&/ 0
(&&0 1
Command&&1 8
<&&8 9
BsonDocument&&9 E
>&&E F
)&&F G
$str&&G Q
)&&Q R
;&&R S
}'' 	
catch)) 
()) 
	Exception)) 
))) 
{** 	
return++ 
false++ 
;++ 
},, 	
return.. 
true.. 
;.. 
}// 
}00 ë
_C:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Context\Settings\MongoSettings.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Data! %
.% &
Mongo& +
{ 
public 

class 
MongoSettings 
{ 
public 
string 

Connection  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 
string 
DatabaseName "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
} 
} ì

VC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Mapping\AuthorMapping.cs
	namespace 	
Library
 
. 
Data 
. 
Mapping 
; 
public 
class 
AuthorMapping 
: "
EFMappingConfiguration 3
<3 4
Author4 :
>: ;
,; < 
IEFMappingEntrypoint= Q
{		 
public

 

override

 
void

 
BuildMapping

 %
(

% &
EntityTypeBuilder

& 7
<

7 8
Author

8 >
>

> ?
builder

@ G
)

G H
{ 
builder 
. 
Property 
( 
c 
=> 
c 
.  
	Biography  )
)) *
.* +

IsRequired+ 5
(5 6
)6 7
.7 8
HasColumnType8 E
(E F
$strF L
)L M
;M N
builder 
. 
Property 
( 
c 
=> 
c 
.  
Name  $
)$ %
.% &

IsRequired& 0
(0 1
)1 2
;2 3
} 
} ’
dC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Mapping\Base\EFMappingConfiguration.cs
	namespace 	
Library
 
. 
Data 
. 
Mapping 
. 
Base #
;# $
public 
abstract 
class "
EFMappingConfiguration ,
<, -
T- .
>. /
:0 1$
IEntityTypeConfiguration2 J
<J K
TK L
>L M
whereN S
TT U
:V W
EntityX ^
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
T		, -
>		- .
builder		/ 6
)		6 7
{

 
builder 
. 
HasKey 
( 
x 
=> 
x 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
c 
=> 
c 
.  
	CreatedAt  )
)) *
.* +

IsRequired+ 5
(5 6
)6 7
;7 8
builder 
. 
Property 
( 
c 
=> 
c 
.  
	UpdatedAt  )
)) *
.* +

IsRequired+ 5
(5 6
false6 ;
); <
;< =
} 
public 

abstract 
void 
BuildMapping %
(% &
EntityTypeBuilder& 7
<7 8
T8 9
>9 :
builder; B
)B C
;C D
} ˘
bC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Mapping\Base\IEFMappingEntrypoint.cs
	namespace 	
Library
 
. 
Data 
. 
Mapping 
. 
Base #
{ 
public 

	interface  
IEFMappingEntrypoint )
{ 
} 
} Å
ZC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Mapping\BookAuthorMapping.cs
	namespace 	
Library
 
. 
Data 
. 
Mapping 
; 
public 
class 
BookAuthorMapping 
:  "
EFMappingConfiguration! 7
<7 8

BookAuthor8 B
>B C
,C D 
IEFMappingEntrypointE Y
{ 
public		 

override		 
void		 
BuildMapping		 %
(		% &
EntityTypeBuilder		& 7
<		7 8

BookAuthor		8 B
>		B C
builder		D K
)		K L
{

 
builder 
. 
OwnsOne 
( 
c 
=> 
c 
. 
Book #
)# $
;$ %
builder 
. 
HasKey 
( 
key 
=> 
new !
{" #
key$ '
.' (
AuthorId( 0
,0 1
key2 5
.5 6
BookId6 <
}= >
)> ?
;? @
builder 
. 
HasOne 
( 
c 
=> 
c 
. 
Author $
)$ %
. 
WithMany 
( 
c 
=> 
c 
. 
BookAuthors (
)( )
. 
HasForeignKey 
( 
c 
=> 
c  !
.! "
AuthorId" *
)* +
;+ ,
builder 
. 
HasOne 
( 
c 
=> 
c 
. 
Book "
)" #
. 
WithMany 
( 
c 
=> 
c 
. 
BookAuthors (
)( )
. 
HasForeignKey 
( 
c 
=> 
c  !
.! "
BookId" (
)( )
;) *
} 
} ¿
TC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Mapping\BookMapping.cs
	namespace 	
Library
 
. 
Data 
. 
Mapping 
; 
public 
class 
BookMapping 
: "
EFMappingConfiguration 1
<1 2
Book2 6
>6 7
,7 8 
IEFMappingEntrypoint9 M
{		 
public

 

override

 
void

 
BuildMapping

 %
(

% &
EntityTypeBuilder

& 7
<

7 8
Book

8 <
>

< =
builder

> E
)

E F
{ 
builder 
. 
Property 
( 
e 
=> 
e 
.  
Title  %
)% &
.& '

IsRequired' 1
(1 2
)2 3
.3 4
HasMaxLength4 @
(@ A
$numA C
)C D
;D E
builder 
. 
Property 
( 
e 
=> 
e 
.  
Description  +
)+ ,
., -

IsRequired- 7
(7 8
)8 9
.9 :
HasColumnType: G
(G H
$strH N
)N O
;O P
builder 
. 
Property 
( 
e 
=> 
e 
.  
YearPublication  /
)/ 0
.0 1

IsRequired1 ;
(; <
)< =
;= >
builder 
. 
Property 
( 
e 
=> 
e 
.  
Pages  %
)% &
.& '

IsRequired' 1
(1 2
)2 3
;3 4
builder 
. 
Property 
( 
e 
=> 
e 
.  
BookType  (
)( )
.) *
HasConversion* 7
(7 8
typeof8 >
(> ?
int? B
)B C
)C D
.D E

IsRequiredE O
(O P
)P Q
;Q R
builder 
. 
Property 
( 
e 
=> 
e 
.  
Genre  %
)% &
.& '
HasConversion' 4
(4 5
typeof5 ;
(; <
int< ?
)? @
)@ A
.A B

IsRequiredB L
(L M
)M N
;N O
builder 
. 
HasMany 
( 
c 
=> 
c 
. 
BookAuthors *
)* +
. 
WithOne 
( 
) 
. 

IsRequired 
( 
) 
. 
OnDelete 
( 
DeleteBehavior (
.( )
Cascade) 0
)0 1
;1 2
} 
} ÍU
bC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Migrations\20230814201530_Initial.cs
	namespace 	
Library
 
. 
Data 
. 

Migrations !
{ 
public 

partial 
class 
Initial  
:! "
	Migration# ,
{		 
	protected

 
override

 
void

 
Up

  "
(

" #
MigrationBuilder

# 3
migrationBuilder

4 D
)

D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
, 
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
Guid& *
>* +
(+ ,
type, 0
:0 1
$str2 8
,8 9
nullable: B
:B C
falseD I
)I J
,J K
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
falseH M
)M N
,N O
	Biography 
= 
table  %
.% &
Column& ,
<, -
string- 3
>3 4
(4 5
type5 9
:9 :
$str; A
,A B
nullableC K
:K L
falseM R
)R S
,S T
DateOfBirth 
=  !
table" '
.' (
Column( .
<. /
DateTime/ 7
>7 8
(8 9
type9 =
:= >
$str? J
,J K
nullableL T
:T U
falseV [
)[ \
,\ ]
	CreatedAt 
= 
table  %
.% &
Column& ,
<, -
DateTime- 5
>5 6
(6 7
type7 ;
:; <
$str= H
,H I
nullableJ R
:R S
falseT Y
)Y Z
,Z [
	UpdatedAt 
= 
table  %
.% &
Column& ,
<, -
DateTime- 5
>5 6
(6 7
type7 ;
:; <
$str= H
,H I
nullableJ R
:R S
trueT X
)X Y
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 0
,0 1
x2 3
=>4 6
x7 8
.8 9
Id9 ;
); <
;< =
} 
) 
; 
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
, 
columns 
: 
table 
=> !
new" %
{ 
Id   
=   
table   
.   
Column   %
<  % &
Guid  & *
>  * +
(  + ,
type  , 0
:  0 1
$str  2 8
,  8 9
nullable  : B
:  B C
false  D I
)  I J
,  J K
Title!! 
=!! 
table!! !
.!!! "
Column!!" (
<!!( )
string!!) /
>!!/ 0
(!!0 1
type!!1 5
:!!5 6
$str!!7 =
,!!= >
nullable!!? G
:!!G H
false!!I N
)!!N O
,!!O P
Description"" 
=""  !
table""" '
.""' (
Column""( .
<"". /
string""/ 5
>""5 6
(""6 7
type""7 ;
:""; <
$str""= C
,""C D
nullable""E M
:""M N
false""O T
)""T U
,""U V
YearPublication## #
=##$ %
table##& +
.##+ ,
Column##, 2
<##2 3
int##3 6
>##6 7
(##7 8
type##8 <
:##< =
$str##> G
,##G H
nullable##I Q
:##Q R
false##S X
)##X Y
,##Y Z
Pages$$ 
=$$ 
table$$ !
.$$! "
Column$$" (
<$$( )
int$$) ,
>$$, -
($$- .
type$$. 2
:$$2 3
$str$$4 =
,$$= >
nullable$$? G
:$$G H
false$$I N
)$$N O
,$$O P
BookType%% 
=%% 
table%% $
.%%$ %
Column%%% +
<%%+ ,
int%%, /
>%%/ 0
(%%0 1
type%%1 5
:%%5 6
$str%%7 @
,%%@ A
nullable%%B J
:%%J K
false%%L Q
)%%Q R
,%%R S
Genre&& 
=&& 
table&& !
.&&! "
Column&&" (
<&&( )
int&&) ,
>&&, -
(&&- .
type&&. 2
:&&2 3
$str&&4 =
,&&= >
nullable&&? G
:&&G H
false&&I N
)&&N O
,&&O P
	CreatedAt'' 
='' 
table''  %
.''% &
Column''& ,
<'', -
DateTime''- 5
>''5 6
(''6 7
type''7 ;
:''; <
$str''= H
,''H I
nullable''J R
:''R S
false''T Y
)''Y Z
,''Z [
	UpdatedAt(( 
=(( 
table((  %
.((% &
Column((& ,
<((, -
DateTime((- 5
>((5 6
(((6 7
type((7 ;
:((; <
$str((= H
,((H I
nullable((J R
:((R S
true((T X
)((X Y
})) 
,)) 
constraints** 
:** 
table** "
=>**# %
{++ 
table,, 
.,, 

PrimaryKey,, $
(,,$ %
$str,,% .
,,,. /
x,,0 1
=>,,2 4
x,,5 6
.,,6 7
Id,,7 9
),,9 :
;,,: ;
}-- 
)-- 
;-- 
migrationBuilder// 
.// 
CreateTable// (
(//( )
name00 
:00 
$str00 "
,00" #
columns11 
:11 
table11 
=>11 !
new11" %
{22 
Id33 
=33 
table33 
.33 
Column33 %
<33% &
Guid33& *
>33* +
(33+ ,
type33, 0
:330 1
$str332 8
,338 9
nullable33: B
:33B C
false33D I
)33I J
,33J K
BookId44 
=44 
table44 "
.44" #
Column44# )
<44) *
Guid44* .
>44. /
(44/ 0
type440 4
:444 5
$str446 <
,44< =
nullable44> F
:44F G
false44H M
)44M N
,44N O
AuthorId55 
=55 
table55 $
.55$ %
Column55% +
<55+ ,
Guid55, 0
>550 1
(551 2
type552 6
:556 7
$str558 >
,55> ?
nullable55@ H
:55H I
false55J O
)55O P
,55P Q
	CreatedAt66 
=66 
table66  %
.66% &
Column66& ,
<66, -
DateTime66- 5
>665 6
(666 7
type667 ;
:66; <
$str66= H
,66H I
nullable66J R
:66R S
false66T Y
)66Y Z
,66Z [
	UpdatedAt77 
=77 
table77  %
.77% &
Column77& ,
<77, -
DateTime77- 5
>775 6
(776 7
type777 ;
:77; <
$str77= H
,77H I
nullable77J R
:77R S
true77T X
)77X Y
}88 
,88 
constraints99 
:99 
table99 "
=>99# %
{:: 
table;; 
.;; 

PrimaryKey;; $
(;;$ %
$str;;% 4
,;;4 5
x;;6 7
=>;;8 :
x;;; <
.;;< =
Id;;= ?
);;? @
;;;@ A
table<< 
.<< 

ForeignKey<< $
(<<$ %
name== 
:== 
$str== =
,=== >
column>> 
:>> 
x>>  !
=>>>" $
x>>% &
.>>& '
AuthorId>>' /
,>>/ 0
principalTable?? &
:??& '
$str??( 0
,??0 1
principalColumn@@ '
:@@' (
$str@@) -
,@@- .
onDeleteAA  
:AA  !
ReferentialActionAA" 3
.AA3 4
CascadeAA4 ;
)AA; <
;AA< =
tableBB 
.BB 

ForeignKeyBB $
(BB$ %
nameCC 
:CC 
$strCC 9
,CC9 :
columnDD 
:DD 
xDD  !
=>DD" $
xDD% &
.DD& '
BookIdDD' -
,DD- .
principalTableEE &
:EE& '
$strEE( .
,EE. /
principalColumnFF '
:FF' (
$strFF) -
,FF- .
onDeleteGG  
:GG  !
ReferentialActionGG" 3
.GG3 4
CascadeGG4 ;
)GG; <
;GG< =
}HH 
)HH 
;HH 
migrationBuilderJJ 
.JJ 
CreateIndexJJ (
(JJ( )
nameKK 
:KK 
$strKK .
,KK. /
tableLL 
:LL 
$strLL #
,LL# $
columnMM 
:MM 
$strMM "
)MM" #
;MM# $
migrationBuilderOO 
.OO 
CreateIndexOO (
(OO( )
namePP 
:PP 
$strPP ,
,PP, -
tableQQ 
:QQ 
$strQQ #
,QQ# $
columnRR 
:RR 
$strRR  
)RR  !
;RR! "
}SS 	
	protectedUU 
overrideUU 
voidUU 
DownUU  $
(UU$ %
MigrationBuilderUU% 5
migrationBuilderUU6 F
)UUF G
{VV 	
migrationBuilderWW 
.WW 
	DropTableWW &
(WW& '
nameXX 
:XX 
$strXX "
)XX" #
;XX# $
migrationBuilderZZ 
.ZZ 
	DropTableZZ &
(ZZ& '
name[[ 
:[[ 
$str[[ 
)[[ 
;[[  
migrationBuilder]] 
.]] 
	DropTable]] &
(]]& '
name^^ 
:^^ 
$str^^ 
)^^ 
;^^ 
}__ 	
}`` 
}aa ≤3
oC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\Base\EntityFrameworkRepositoryAsync.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
Base" &
;& '
public 
class *
EntityFrameworkRepositoryAsync +
<+ ,
T, -
>- .
:/ 0
IRepositoryAsync1 A
<A B
TB C
>C D
whereE J
TK L
:M N
AggregateRootO \
{		 
	protected

 
readonly

 "
EntityFrameworkContext

 -
_context

. 6
;

6 7
	protected 
readonly 
DbSet 
< 
T 
> 
_dbSet  &
;& '
public 
*
EntityFrameworkRepositoryAsync )
() *"
EntityFrameworkContext* @
contextA H
)H I
{ 
_context 
= 
context 
; 
_dbSet 
= 
_context 
. 
Set 
< 
T 
>  
(  !
)! "
;" #
} 
public 

async 
Task 
AddOrUpdate !
(! "
T" #
aggregateRoot$ 1
,1 2
CancellationToken3 D
cancellationTokenE V
=W X
defaultY `
)` a
{ 
var 
exist 
= 
await 
_dbSet  
.  !
AsNoTracking! -
(- .
). /
./ 0 
SingleOrDefaultAsync0 D
(D E
cE F
=>G I
cJ K
.K L
IdL N
==O Q
aggregateRootR _
._ `
Id` b
,b c
cancellationTokend u
)u v
;v w
if 

( 
exist 
is 
null 
) 
await 
_dbSet 
. 
AddAsync !
(! "
aggregateRoot" /
,/ 0
cancellationToken1 B
)B C
;C D
else 
{ 	
_context 
. 
Entry 
( 
exist  
)  !
.! "
CurrentValues" /
./ 0
	SetValues0 9
(9 :
aggregateRoot: G
)G H
;H I
_context 
. 
Entry 
( 
aggregateRoot (
)( )
.) *
State* /
=0 1
EntityState2 =
.= >
Modified> F
;F G
_context 
. 
Update 
( 
aggregateRoot )
)) *
;* +
} 	
}   
public"" 

async"" 
Task"" 
<"" 
IEnumerable"" !
<""! "
T""" #
>""# $
>""$ %
Get""& )
("") *

Expression""* 4
<""4 5
Func""5 9
<""9 :
T"": ;
,""; <
bool""= A
>""A B
>""B C
?""C D
	predicate""E N
=""O P
null""Q U
,""U V
int""W Z
page""[ _
=""` a
$num""b c
,""c d
int""e h
pageSize""i q
=""r s
$num""t u
,""u v
CancellationToken	""w à
cancellationToken
""â ö
=
""õ ú
default
""ù §
)
""§ •
{## 
var$$ 
query$$ 
=$$ 
_dbSet$$ 
.$$ 
AsNoTracking$$ '
($$' (
)$$( )
;$$) *
if&& 

(&& 
	predicate&& 
!=&& 
null&& 
)&& 
query'' 
='' 
query'' 
.'' 
Where'' 
(''  
	predicate''  )
)'') *
;''* +
if)) 

()) 
page)) 
!=)) 
default)) 
&&)) 
pageSize)) '
!=))( *
default))+ 2
)))2 3
query** 
=** 
query** 
.** 
Skip** 
(** 
Math** #
.**# $
Abs**$ '
(**' (
(**( )
page**) -
-**. /
$num**0 1
)**1 2
***3 4
pageSize**5 =
)**= >
)**> ?
.**? @
Take**@ D
(**D E
pageSize**E M
)**M N
;**N O
return,, 
await,, 
query,, 
.,, 
ToListAsync,, &
(,,& '
cancellationToken,,' 8
),,8 9
;,,9 :
}-- 
public// 

async// 
Task// 
<// 
T// 
?// 
>// 
GetById// !
(//! "
Guid//" &
id//' )
,//) *
CancellationToken//+ <
cancellationToken//= N
=//O P
default//Q X
)//X Y
{00 
var11 
result11 
=11 
await11 
_dbSet11 !
.11! "
FirstOrDefaultAsync11" 5
(115 6
c116 7
=>118 :
c11; <
.11< =
Id11= ?
==11@ B
id11C E
,11E F
cancellationToken11G X
)11X Y
;11Y Z
return22 
result22 
;22 
}33 
public55 

async55 
Task55 
Remove55 
(55 
T55 
aggregateRoot55 ,
,55, -
CancellationToken55. ?
cancellationToken55@ Q
=55R S
default55T [
)55[ \
{66 
var77 
result77 
=77 
await77 
_dbSet77 !
.77! "
FirstOrDefaultAsync77" 5
(775 6
c776 7
=>778 :
c77; <
.77< =
Id77= ?
==77@ B
aggregateRoot77C P
.77P Q
Id77Q S
,77S T
cancellationToken77U f
)77f g
;77g h
if99 

(99 
result99 
is99 
not99 
null99 
)99 
_dbSet:: 
.:: 
Remove:: 
(:: 
result::  
)::  !
;::! "
};; 
}<< £
aC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\Base\IRepositoryAsync.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
Base" &
;& '
public 
	interface 
IRepositoryAsync !
<! "
T" #
># $
where% *
T+ ,
:- .
AggregateRoot/ <
{ 
Task 
< 	
T	 

?
 
> 
GetById 
( 
Guid 
id 
, 
CancellationToken /
cancellationToken0 A
=B C
defaultD K
)K L
;L M
Task		 
AddOrUpdate			 
(		 
T		 
aggregateRoot		 $
,		$ %
CancellationToken		& 7
cancellationToken		8 I
=		J K
default		L S
)		S T
;		T U
Task

 
Remove

	 
(

 
T

 
aggregateRoot

 
,

  
CancellationToken

! 2
cancellationToken

3 D
=

E F
default

G N
)

N O
;

O P
Task 
< 	
IEnumerable	 
< 
T 
> 
> 
Get 
( 

Expression '
<' (
Func( ,
<, -
T- .
,. /
bool0 4
>4 5
>5 6
?6 7
	predicate8 A
=B C
defaultD K
,K L
intM P
pageQ U
=V W
defaultX _
,_ `
inta d
pageSizee m
=n o
defaultp w
,w x
CancellationToken	y ä
cancellationToken
ã ú
=
ù û
default
ü ¶
)
¶ ß
;
ß ®
} ô1
eC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\Base\MongoRepositoryAsync.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
Base" &
;& '
public 
class  
MongoRepositoryAsync !
<! "
T" #
># $
:% &
IRepositoryAsync' 7
<7 8
T8 9
>9 :
where; @
TA B
:C D
AggregateRootE R
{		 
	protected

 
readonly

 
MongoDbContext

 %
_mongoContext

& 3
;

3 4
	protected 
IMongoCollection 
< 
T  
>  !
_mongoCollection" 2
;2 3
public 
 
MongoRepositoryAsync 
(  
MongoDbContext  .
mongoContext/ ;
); <
{ 
_mongoContext 
= 
mongoContext $
;$ %
_mongoCollection 
= 
_mongoContext (
.( )
GetCollection) 6
<6 7
T7 8
>8 9
(9 :
typeof: @
(@ A
TA B
)B C
.C D
NameD H
)H I
;I J
} 
public 

async 
Task 
AddOrUpdate !
(! "
T" #
aggregateRoot$ 1
,1 2
CancellationToken3 D
cancellationTokenE V
=W X
defaultY `
)` a
{ 
FilterDefinition 
< 
T 
> 
filter "
=# $
Builders% -
<- .
T. /
>/ 0
.0 1
Filter1 7
.7 8
Eq8 :
(: ;
$str; ?
,? @
aggregateRootA N
.N O
IdO Q
)Q R
;R S
var 
exist 
= 
await 
_mongoCollection *
.* +
Find+ /
(/ 0
filter0 6
)6 7
.7 8
FirstOrDefaultAsync8 K
(K L
cancellationTokenL ]
)] ^
;^ _
if 

( 
exist 
== 
null 
) 
await 
_mongoCollection "
." #
InsertOneAsync# 1
(1 2
aggregateRoot2 ?
,? @
nullA E
,E F
cancellationTokenG X
)X Y
;Y Z
else 
await 
_mongoCollection "
." #
ReplaceOneAsync# 2
(2 3
filter3 9
,9 :
aggregateRoot; H
,H I
cancellationTokenJ [
:[ \
cancellationToken] n
)n o
;o p
} 
public 

async 
Task 
< 
IEnumerable !
<! "
T" #
># $
>$ %
Get& )
() *

Expression* 4
<4 5
Func5 9
<9 :
T: ;
,; <
bool= A
>A B
>B C
?C D
	predicateE N
=O P
nullQ U
,U V
intW Z
page[ _
=` a
$numb c
,c d
inte h
pageSizei q
=r s
$numt u
,u v
CancellationToken	w à
cancellationToken
â ö
=
õ ú
default
ù §
)
§ •
{   
var!! 
query!! 
=!! 
_mongoCollection!! $
.!!$ %
Find!!% )
(!!) *
	predicate!!* 3
)!!3 4
;!!4 5
if## 

(## 
page## 
!=## 
default## 
&&## 
pageSize## '
!=##( *
default##+ 2
)##2 3
query$$ 
=$$ 
query$$ 
.$$ 
Skip$$ 
($$ 
Math$$ #
.$$# $
Abs$$$ '
($$' (
($$( )
page$$) -
-$$. /
$num$$0 1
)$$1 2
*$$3 4
pageSize$$5 =
)$$= >
)$$> ?
.$$? @
Limit$$@ E
($$E F
pageSize$$F N
)$$N O
;$$O P
return&& 
await&& 
query&& 
.&& 
ToListAsync&& &
(&&& '
cancellationToken&&' 8
)&&8 9
;&&9 :
}'' 
public)) 

async)) 
Task)) 
<)) 
T)) 
?)) 
>)) 
GetById)) !
())! "
Guid))" &
id))' )
,))) *
CancellationToken))+ <
cancellationToken))= N
=))O P
default))Q X
)))X Y
{** 
FilterDefinition++ 
<++ 
T++ 
>++ 
filter++ "
=++# $
Builders++% -
<++- .
T++. /
>++/ 0
.++0 1
Filter++1 7
.++7 8
Eq++8 :
(++: ;
$str++; ?
,++? @
id++A C
)++C D
;++D E
return-- 
await-- 
_mongoCollection-- %
.--% &
Find--& *
(--* +
filter--+ 1
)--1 2
.--2 3
FirstOrDefaultAsync--3 F
(--F G
cancellationToken--G X
)--X Y
;--Y Z
}.. 
public00 

async00 
Task00 
Remove00 
(00 
T00 
aggregateRoot00 ,
,00, -
CancellationToken00. ?
cancellationToken00@ Q
=00R S
default00T [
)00[ \
{11 
await22 
_mongoCollection22 
.22 
DeleteOneAsync22 -
(22- .
c22. /
=>220 2
c223 4
.224 5
Id225 7
==228 :
aggregateRoot22; H
.22H I
Id22I K
,22K L
cancellationToken22M ^
)22^ _
;22_ `
}33 
}44  
{C:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\EntityFramework\AuthorEntityFrameworkRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
EntityFramework" 1
;1 2
public 
class +
AuthorEntityFrameworkRepository ,
:- .*
EntityFrameworkRepositoryAsync/ M
<M N
AuthorN T
>T U
,U V,
 IAuthorEntityFrameworkRepositoryW w
{		 
public

 
+
AuthorEntityFrameworkRepository

 *
(

* +"
EntityFrameworkContext

+ A
context

B I
)

I J
:

K L
base

M Q
(

Q R
context

R Y
)

Y Z
{ 
} 
} ¿
yC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\EntityFramework\BookEntityFrameworkRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
EntityFramework" 1
;1 2
public 
class )
BookEntityFrameworkRepository *
:+ ,*
EntityFrameworkRepositoryAsync- K
<K L
BookL P
>P Q
,Q R*
IBookEntityFrameworkRepositoryS q
{		 
public

 
)
BookEntityFrameworkRepository

 (
(

( )"
EntityFrameworkContext

) ?
context

@ G
)

G H
:

I J
base

K O
(

O P
context

P W
)

W X
{ 
} 
} ¨
ÜC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\EntityFramework\Interface\IAuthorEntityFrameworkRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
EntityFramework" 1
.1 2
	Interface2 ;
;; <
public 
	interface ,
 IAuthorEntityFrameworkRepository 1
:2 3
IRepositoryAsync4 D
<D E
AuthorE K
>K L
{ 
} ¶
ÑC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\EntityFramework\Interface\IBookEntityFrameworkRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
EntityFramework" 1
.1 2
	Interface2 ;
;; <
public 
	interface *
IBookEntityFrameworkRepository /
:0 1
IRepositoryAsync2 B
<B C
BookC G
>G H
{ 
} Ü
gC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\Mongo\AuthorMongoRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
Mongo" '
;' (
public 
class !
AuthorMongoRepository "
:# $ 
MongoRepositoryAsync% 9
<9 :
Author: @
>@ A
,A B"
IAuthorMongoRepositoryC Y
{		 
public

 
!
AuthorMongoRepository

  
(

  !
MongoDbContext

! /
mongoContext

0 <
)

< =
:

> ?
base

@ D
(

D E
mongoContext

E Q
)

Q R
{ 
} 
} ¸
eC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\Mongo\BookMongoRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
Mongo" '
;' (
public 
class 
BookMongoRepository  
:! " 
MongoRepositoryAsync# 7
<7 8
Book8 <
>< =
,= > 
IBookMongoRepository? S
{		 
public

 

BookMongoRepository

 
(

 
MongoDbContext

 -
mongoContext

. :
)

: ;
:

< =
base

> B
(

B C
mongoContext

C O
)

O P
{ 
} 
} É
rC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\Mongo\Interface\IAuthorMongoRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
Mongo" '
.' (
	Interface( 1
;1 2
public 
	interface "
IAuthorMongoRepository '
:( )
IRepositoryAsync* :
<: ;
Author; A
>A B
{ 
} ˝
pC:\Users\patrick.amorim\source\repos\Library\src\Library.Data\Repository\Mongo\Interface\IBookMongoRepository.cs
	namespace 	
Library
 
. 
Data 
. 

Repository !
.! "
Mongo" '
.' (
	Interface( 1
;1 2
public 
	interface  
IBookMongoRepository %
:& '
IRepositoryAsync( 8
<8 9
Book9 =
>= >
{ 
} 