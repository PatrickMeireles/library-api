∫0
[C:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure.Worker\Configure.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Worker! '
;' (
public		 
static		 
class		 
	Configure		 
{

 
public 

static 
void )
ConfigureInfrastructureWorker 4
(4 5
this5 9
IServiceCollection: L
servicesM U
,U V
IConfigurationW e
configurationf s
)s t
{ 
services 
. 
AddMassTransit 
(  
c  !
=>" $
{ 	
c 
. 
AddConsumer 
<  
CreateAuthorConsumer .
>. /
(/ 0
)0 1
;1 2
c 
. 
AddConsumer 
<  
RemoveAuthorConsumer .
>. /
(/ 0
)0 1
;1 2
c 
. 
AddConsumer 
<  
UpdateAuthorConsumer .
>. /
(/ 0
)0 1
;1 2
c 
. 
AddConsumer 
< 
CreateBookConsumer ,
>, -
(- .
). /
;/ 0
c 
. 
AddConsumer 
< 
RemoveBookConsumer ,
>, -
(- .
). /
;/ 0
c 
. 
AddConsumer 
< 
UpdateBookConsumer ,
>, -
(- .
). /
;/ 0
c 
. 
UsingRabbitMq 
( 
( 
ctx  
,  !
cfg" %
)% &
=>' )
{ 
var 
stringConnection $
=% &
configuration' 4
[4 5
$str5 P
]P Q
;Q R
cfg 
. 
Host 
( 
stringConnection )
)) *
;* +
cfg 
. 
ConfigureEndpoints &
(& '
ctx' *
)* +
;+ ,
cfg 
. 
ReceiveEndpoint #
(# $
configuration$ 1
[1 2
$str2 L
]L M
,M N
eO P
=>Q S
{ 
e 
. 
PrefetchCount #
=$ %
$num& (
;( )
e   
.   
ConfigureConsumer   '
<  ' (
CreateBookConsumer  ( :
>  : ;
(  ; <
ctx  < ?
)  ? @
;  @ A
}!! 
)!! 
;!! 
cfg## 
.## 
ReceiveEndpoint## #
(### $
configuration##$ 1
[##1 2
$str##2 N
]##N O
,##O P
e##Q R
=>##S U
{$$ 
e%% 
.%% 
PrefetchCount%% #
=%%$ %
$num%%& (
;%%( )
e&& 
.&& 
ConfigureConsumer&& '
<&&' ( 
CreateAuthorConsumer&&( <
>&&< =
(&&= >
ctx&&> A
)&&A B
;&&B C
}'' 
)'' 
;'' 
cfg)) 
.)) 
ReceiveEndpoint)) #
())# $
configuration))$ 1
[))1 2
$str))2 N
]))N O
,))O P
e))Q R
=>))S U
{** 
e++ 
.++ 
PrefetchCount++ #
=++$ %
$num++& (
;++( )
e,, 
.,, 
ConfigureConsumer,, '
<,,' ( 
RemoveAuthorConsumer,,( <
>,,< =
(,,= >
ctx,,> A
),,A B
;,,B C
}-- 
)-- 
;-- 
cfg// 
.// 
ReceiveEndpoint// #
(//# $
configuration//$ 1
[//1 2
$str//2 N
]//N O
,//O P
e//Q R
=>//S U
{00 
e11 
.11 
PrefetchCount11 #
=11$ %
$num11& (
;11( )
e22 
.22 
ConfigureConsumer22 '
<22' ( 
UpdateAuthorConsumer22( <
>22< =
(22= >
ctx22> A
)22A B
;22B C
}33 
)33 
;33 
cfg55 
.55 
InjectQueue55 
<55  
RemoveBookConsumer55  2
>552 3
(553 4
ctx554 7
,557 8
configuration559 F
[55F G
$str55G a
]55a b
)55b c
;55c d
cfg66 
.66 
InjectQueue66 
<66  
UpdateBookConsumer66  2
>662 3
(663 4
ctx664 7
,667 8
configuration669 F
[66F G
$str66G a
]66a b
)66b c
;66c d
}77 
)77 
;77 
}88 	
)88	 

;88
 
}99 
private;; 
static;; 
void;; 
InjectQueue;; #
<;;# $
T;;$ %
>;;% &
(;;& '
this;;' ++
IRabbitMqBusFactoryConfigurator;;, K
configurator;;L X
,;;X Y#
IBusRegistrationContext;;Z q
context;;r y
,;;y z
string	;;{ Å
queue
;;Ç á
)
;;á à
where
;;â é
T
;;è ê
:
;;ë í
class
;;ì ò
,
;;ò ô
	IConsumer
;;ö £
{<< 
configurator== 
.== 
ReceiveEndpoint== $
(==$ %
queue==% *
,==* +
e==, -
=>==. 0
{>> 	
e?? 
.?? 
PrefetchCount?? 
=?? 
$num??  
;??  !
e@@ 
.@@ 
ConfigureConsumer@@ 
(@@  
context@@  '
,@@' (
typeof@@) /
(@@/ 0
T@@0 1
)@@1 2
)@@2 3
;@@3 4
}AA 	
)AA	 

;AA
 
}BB 
}CC ≈
vC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure.Worker\Consumer\Author\CreateAuthorConsumer.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Worker! '
.' (
Consumer( 0
.0 1
Author1 7
;7 8
public

 
class

  
CreateAuthorConsumer

 !
:

" #
	IConsumer

$ -
<

- .
CreateAuthorMessage

. A
>

A B
{ 
private 
readonly "
IAuthorMongoRepository +
_repository, 7
;7 8
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 
 
CreateAuthorConsumer 
(  "
IAuthorMongoRepository  6

repository7 A
,A B
ICacheServiceC P
cacheServiceQ ]
)] ^
{ 
_repository 
= 

repository  
;  !
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -
CreateAuthorMessage- @
>@ A
contextB I
)I J
{ 
var 
param 
= 
context 
. 
Message #
.# $
Adapt$ )
<) *
Domain* 0
.0 1
Model1 6
.6 7
Author7 =
>= >
(> ?
)? @
;@ A
await 
_repository 
. 
AddOrUpdate %
(% &
param& +
,+ ,
context- 4
.4 5
CancellationToken5 F
)F G
;G H
var 
key 
= 
$" 
{ 
CachePrefix  
.  !
AuthorCachePrefix! 2
}2 3
$str3 4
{4 5
param5 :
.: ;
Id; =
}= >
"> ?
;? @
await 
_cacheService 
. 
SetAsync $
($ %
key% (
,( )
param* /
,/ 0
context1 8
.8 9
CancellationToken9 J
)J K
;K L
} 
} î
vC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure.Worker\Consumer\Author\RemoveAuthorConsumer.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Worker! '
.' (
Consumer( 0
.0 1
Author1 7
;7 8
public		 
class		  
RemoveAuthorConsumer		 !
:		" #
	IConsumer		$ -
<		- .
RemoveAuthorMessage		. A
>		A B
{

 
private 
readonly "
IAuthorMongoRepository +
_repository, 7
;7 8
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 
 
RemoveAuthorConsumer 
(  "
IAuthorMongoRepository  6

repository7 A
,A B
ICacheServiceC P
cacheServiceQ ]
)] ^
{ 
_repository 
= 

repository  
;  !
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -
RemoveAuthorMessage- @
>@ A
contextB I
)I J
{ 
var 
author 
= 
new 
Domain 
.  
Model  %
.% &
Author& ,
(, -
context- 4
.4 5
Message5 <
.< =
Id= ?
)? @
;@ A
await 
_repository 
. 
Remove  
(  !
author! '
,' (
context) 0
.0 1
CancellationToken1 B
)B C
;C D
var 
key 
= 
$" 
{ 
CachePrefix  
.  !
AuthorCachePrefix! 2
}2 3
$str3 4
{4 5
author5 ;
.; <
Id< >
}> ?
"? @
;@ A
await 
_cacheService 
. 
RemoveAsync '
(' (
key( +
,+ ,
context- 4
.4 5
CancellationToken5 F
)F G
;G H
} 
} ≈
vC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure.Worker\Consumer\Author\UpdateAuthorConsumer.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Worker! '
.' (
Consumer( 0
.0 1
Author1 7
;7 8
public

 
class

  
UpdateAuthorConsumer

 !
:

" #
	IConsumer

$ -
<

- .
UpdateAuthorMessage

. A
>

A B
{ 
private 
readonly "
IAuthorMongoRepository +
_repository, 7
;7 8
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 
 
UpdateAuthorConsumer 
(  "
IAuthorMongoRepository  6

repository7 A
,A B
ICacheServiceC P
cacheServiceQ ]
)] ^
{ 
_repository 
= 

repository  
;  !
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -
UpdateAuthorMessage- @
>@ A
contextB I
)I J
{ 
var 
param 
= 
context 
. 
Message #
.# $
Adapt$ )
<) *
Domain* 0
.0 1
Model1 6
.6 7
Author7 =
>= >
(> ?
)? @
;@ A
await 
_repository 
. 
AddOrUpdate %
(% &
param& +
,+ ,
context- 4
.4 5
CancellationToken5 F
)F G
;G H
var 
key 
= 
$" 
{ 
CachePrefix  
.  !
AuthorCachePrefix! 2
}2 3
$str3 4
{4 5
param5 :
.: ;
Id; =
}= >
"> ?
;? @
await 
_cacheService 
. 
SetAsync $
($ %
key% (
,( )
param* /
,/ 0
context1 8
.8 9
CancellationToken9 J
)J K
;K L
} 
} ‹
rC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure.Worker\Consumer\Book\CreateBookConsumer.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Worker! '
.' (
Consumer( 0
.0 1
Book1 5
;5 6
public

 
class

 
CreateBookConsumer

 
:

  !
	IConsumer

" +
<

+ ,
CreateBookMessage

, =
>

= >
{ 
private 
readonly  
IBookMongoRepository ) 
_bookMongoRepository* >
;> ?
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 

CreateBookConsumer 
(  
IBookMongoRepository 2
bookMongoRepository3 F
,F G
ICacheServiceH U
cacheServiceV b
)b c
{  
_bookMongoRepository 
= 
bookMongoRepository 2
;2 3
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -
CreateBookMessage- >
>> ?
context@ G
)G H
{ 
var 
param 
= 
context 
. 
Message #
.# $
Adapt$ )
<) *
Domain* 0
.0 1
Model1 6
.6 7
Book7 ;
>; <
(< =
)= >
;> ?
await  
_bookMongoRepository "
." #
AddOrUpdate# .
(. /
param/ 4
,4 5
context6 =
.= >
CancellationToken> O
)O P
;P Q
var 
key 
= 
$" 
{ 
CachePrefix  
.  !
BookCachePrefix! 0
}0 1
$str1 2
{2 3
param3 8
.8 9
Id9 ;
}; <
"< =
;= >
await 
_cacheService 
. 
SetAsync $
($ %
key% (
,( )
param* /
,/ 0
context1 8
.8 9
CancellationToken9 J
)J K
;K L
} 
} •
rC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure.Worker\Consumer\Book\RemoveBookConsumer.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Worker! '
.' (
Consumer( 0
.0 1
Book1 5
;5 6
public

 
class

 
RemoveBookConsumer

 
:

  !
	IConsumer

" +
<

+ ,
RemoveBookMessage

, =
>

= >
{ 
private 
readonly  
IBookMongoRepository ) 
_bookMongoRepository* >
;> ?
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 

RemoveBookConsumer 
(  
IBookMongoRepository 2
bookMongoRepository3 F
,F G
ICacheServiceH U
cacheServiceV b
)b c
{  
_bookMongoRepository 
= 
bookMongoRepository 2
;2 3
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -
RemoveBookMessage- >
>> ?
context@ G
)G H
{ 
var 
book 
= 
new 
Domain 
. 
Model #
.# $
Book$ (
(( )
context) 0
.0 1
Message1 8
.8 9
Id9 ;
); <
;< =
await  
_bookMongoRepository "
." #
Remove# )
() *
book* .
,. /
context0 7
.7 8
CancellationToken8 I
)I J
;J K
var 
key 
= 
$" 
{ 
CachePrefix  
.  !
BookCachePrefix! 0
}0 1
$str1 2
{2 3
book3 7
.7 8
Id8 :
}: ;
"; <
;< =
await 
_cacheService 
. 
RemoveAsync '
(' (
key( +
,+ ,
context- 4
.4 5
CancellationToken5 F
)F G
;G H
} 
} ‹
rC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure.Worker\Consumer\Book\UpdateBookConsumer.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Worker! '
.' (
Consumer( 0
.0 1
Book1 5
;5 6
public

 
class

 
UpdateBookConsumer

 
:

  !
	IConsumer

" +
<

+ ,
UpdateBookMessage

, =
>

= >
{ 
private 
readonly  
IBookMongoRepository ) 
_bookMongoRepository* >
;> ?
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 

UpdateBookConsumer 
(  
IBookMongoRepository 2
bookMongoRepository3 F
,F G
ICacheServiceH U
cacheServiceV b
)b c
{  
_bookMongoRepository 
= 
bookMongoRepository 2
;2 3
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -
UpdateBookMessage- >
>> ?
context@ G
)G H
{ 
var 
param 
= 
context 
. 
Message #
.# $
Adapt$ )
<) *
Domain* 0
.0 1
Model1 6
.6 7
Book7 ;
>; <
(< =
)= >
;> ?
await  
_bookMongoRepository "
." #
AddOrUpdate# .
(. /
param/ 4
,4 5
context6 =
.= >
CancellationToken> O
)O P
;P Q
var 
key 
= 
$" 
{ 
CachePrefix  
.  !
BookCachePrefix! 0
}0 1
$str1 2
{2 3
param3 8
.8 9
Id9 ;
}; <
"< =
;= >
await 
_cacheService 
. 
SetAsync $
($ %
key% (
,( )
param* /
,/ 0
context1 8
.8 9
CancellationToken9 J
)J K
;K L
} 
} 