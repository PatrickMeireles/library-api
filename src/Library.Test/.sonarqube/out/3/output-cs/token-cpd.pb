⁄"
QC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Configure.cs
	namespace 	
Library
 
. 
Application 
{ 
public 

static 
class 
	Configure !
{ 
public 
static 
void  
ConfigureApplication /
(/ 0
this0 4
IServiceCollection5 G
servicesH P
)P Q
{ 	
services 
. 
RegisterMappings %
(% &
)& '
;' (
services 
. 
ConfigureServices &
(& '
)' (
;( )
services 
. 
ConfigureHandlers &
(& '
)' (
;( )
services 
. 
ConfigureRules #
(# $
)$ %
;% &
services 
. 
	AddScoped 
< 
NotificationContext 2
>2 3
(3 4
)4 5
;5 6
} 	
private 
static 
void 
ConfigureServices -
(- .
this. 2
IServiceCollection3 E
servicesF N
)N O
{ 	
services 
. 
	AddScoped 
< 
IBookServices ,
,, -
BookServices. :
>: ;
(; <
)< =
;= >
services 
. 
	AddScoped 
< 
IAuthorServices .
,. /
AuthorServices0 >
>> ?
(? @
)@ A
;A B
}   	
private"" 
static"" 
void"" 
ConfigureHandlers"" -
(""- .
this"". 2
IServiceCollection""3 E
services""F N
)""N O
{## 	
services$$ 
.$$ 
	AddScoped$$ 
<$$ 
IRequestHandler$$ .
<$$. /
CreateBookCommand$$/ @
,$$@ A
CommandReturnDto$$B R
>$$R S
,$$S T
CreateBookHandler$$U f
>$$f g
($$g h
)$$h i
;$$i j
services%% 
.%% 
	AddScoped%% 
<%% 
IRequestHandler%% .
<%%. /
RemoveBookCommand%%/ @
,%%@ A
CommandReturnDto%%B R
>%%R S
,%%S T
RemoveBookHandler%%U f
>%%f g
(%%g h
)%%h i
;%%i j
services&& 
.&& 
	AddScoped&& 
<&& 
IRequestHandler&& .
<&&. /
UpdateBookCommand&&/ @
,&&@ A
CommandReturnDto&&B R
>&&R S
,&&S T
UpdateBookHandler&&U f
>&&f g
(&&g h
)&&h i
;&&i j
services(( 
.(( 
	AddScoped(( 
<(( 
IRequestHandler(( .
<((. /
CreateAuthorCommand((/ B
,((B C
CommandReturnDto((D T
>((T U
,((U V
CreateAuthorHandler((W j
>((j k
(((k l
)((l m
;((m n
services)) 
.)) 
	AddScoped)) 
<)) 
IRequestHandler)) .
<)). /
RemoveAuthorCommand))/ B
,))B C
CommandReturnDto))D T
>))T U
,))U V
RemoveAuthorHandler))W j
>))j k
())k l
)))l m
;))m n
services** 
.** 
	AddScoped** 
<** 
IRequestHandler** .
<**. /
UpdateAuthorCommand**/ B
,**B C
CommandReturnDto**D T
>**T U
,**U V
UpdateAuthorHandler**W j
>**j k
(**k l
)**l m
;**m n
}++ 	
private-- 
static-- 
void-- 
ConfigureRules-- *
(--* +
this--+ /
IServiceCollection--0 B
services--C K
)--K L
{.. 	
services// 
.// 
	AddScoped// 
<// 
AuthorRules// *
>//* +
(//+ ,
)//, -
;//- .
services00 
.00 
	AddScoped00 
<00 
	BookRules00 (
>00( )
(00) *
)00* +
;00+ ,
}11 	
}22 
}33 ª
jC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Handler\Author\CreateAuthorHandler.cs
	namespace 	
Library
 
. 
Application 
. 
Handler %
.% &
Author& ,
;, -
public 
class 
CreateAuthorHandler  
:! "
CommandHandler# 1
,1 2
IRequestHandler3 B
<B C
CreateAuthorCommandC V
,V W
CommandReturnDtoX h
>h i
{ 
private 
readonly ,
 IAuthorEntityFrameworkRepository 5
_repository6 A
;A B
private 
readonly 
AuthorRules  
_authorRules! -
;- .
public 

CreateAuthorHandler 
( "
EntityFrameworkContext 5
context6 =
,= >
DomainHandler 
domainHandler #
,# $
NotificationContext 
notificationContext /
,/ 0,
 IAuthorEntityFrameworkRepository (

repository) 3
,3 4
AuthorRules 
authorRules 
)  
:! "
base# '
(' (
context( /
,/ 0
domainHandler1 >
,> ?
notificationContext@ S
)S T
{ 
_repository 
= 

repository  
;  !
_authorRules 
= 
authorRules "
;" #
} 
public 

async 
Task 
< 
CommandReturnDto &
>& '
Handle( .
(. /
CreateAuthorCommand/ B
requestC J
,J K
CancellationTokenL ]
cancellationToken^ o
)o p
{ 
var 
result 
= 
new 
CommandReturnDto )
() *
)* +
;+ ,
var!! 
author!! 
=!! 
request!! 
.!! 
Adapt!! "
<!!" #
Domain!!# )
.!!) *
Model!!* /
.!!/ 0
Author!!0 6
>!!6 7
(!!7 8
)!!8 9
;!!9 :
var## 
isValid## 
=## 
await## 
_authorRules## (
.##( )
CreateIsValidAsync##) ;
(##; <
author##< B
,##B C
cancellationToken##D U
)##U V
;##V W
if%% 

(%% 
!%% 
isValid%% 
)%% 
return&& 
result&& 
;&& 
await(( 
_repository(( 
.(( 
AddOrUpdate(( %
(((% &
author((& ,
,((, -
cancellationToken((. ?
)((? @
;((@ A
var** 
domainEvent** 
=** 
new** 
CreatedAuthorEvent** 0
(**0 1
author**1 7
)**7 8
;**8 9
AddEvent,, 
(,, 
domainEvent,, 
),, 
;,, 
if.. 

(.. 
await.. 
CommitAsync.. 
(.. 
cancellationToken.. /
)../ 0
)..0 1
result// 
.// 
Successfully// 
(//  
)//  !
;//! "
return11 
result11 
;11 
}22 
}33 ‚
jC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Handler\Author\RemoveAuthorHandler.cs
	namespace 	
Library
 
. 
Application 
. 
Handler %
.% &
Author& ,
;, -
public 
class 
RemoveAuthorHandler  
:! "
CommandHandler# 1
,1 2
IRequestHandler3 B
<B C
RemoveAuthorCommandC V
,V W
CommandReturnDtoX h
>h i
{ 
private 
readonly ,
 IAuthorEntityFrameworkRepository 5
_repository6 A
;A B
private 
readonly 
AuthorRules  
_authorRules! -
;- .
public 

RemoveAuthorHandler 
( "
EntityFrameworkContext 5
context6 =
,= >
DomainHandler 
domainHandler #
,# $
NotificationContext 
notificationContext /
,/ 0,
 IAuthorEntityFrameworkRepository (

repository) 3
,3 4
AuthorRules 
authorRules 
)  
:! "
base# '
(' (
context( /
,/ 0
domainHandler1 >
,> ?
notificationContext@ S
)S T
{ 
_repository 
= 

repository  
;  !
_authorRules 
= 
authorRules "
;" #
_authorRules 
= 
authorRules "
;" #
} 
public 

async 
Task 
< 
CommandReturnDto &
>& '
Handle( .
(. /
RemoveAuthorCommand/ B
requestC J
,J K
CancellationTokenL ]
cancellationToken^ o
)o p
{ 
var 
result 
= 
new 
CommandReturnDto )
() *
)* +
;+ ,
var!! 
exist!! 
=!! 
await!! 
_repository!! %
.!!% &
GetById!!& -
(!!- .
request!!. 5
.!!5 6
Id!!6 8
,!!8 9
cancellationToken!!: K
)!!K L
;!!L M
if## 

(## 
exist## 
is## 
null## 
)## 
return$$ 
result$$ 
;$$ 
var&& 
isValid&& 
=&& 
await&& 
_authorRules&& (
.&&( )
RemoveIsValidAsync&&) ;
(&&; <
request&&< C
.&&C D
Id&&D F
,&&F G
cancellationToken&&H Y
)&&Y Z
;&&Z [
if(( 

((( 
!(( 
isValid(( 
)(( 
return)) 
result)) 
;)) 
await++ 
_repository++ 
.++ 
Remove++  
(++  !
exist++! &
,++& '
cancellationToken++( 9
)++9 :
;++: ;
var-- 
domainEvent-- 
=-- 
new-- 
RemoveAuthorEvent-- /
(--/ 0
request--0 7
.--7 8
Id--8 :
)--: ;
;--; <
AddEvent// 
(// 
domainEvent// 
)// 
;// 
if11 

(11 
await11 
CommitAsync11 
(11 
cancellationToken11 /
)11/ 0
)110 1
result22 
.22 
Successfully22 
(22  
)22  !
;22! "
return44 
result44 
;44 
}55 
}66 ˝
jC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Handler\Author\UpdateAuthorHandler.cs
	namespace 	
Library
 
. 
Application 
. 
Handler %
.% &
Author& ,
;, -
public 
class 
UpdateAuthorHandler  
:! "
CommandHandler# 1
,1 2
IRequestHandler3 B
<B C
UpdateAuthorCommandC V
,V W
CommandReturnDtoX h
>h i
{ 
private 
readonly ,
 IAuthorEntityFrameworkRepository 5
_repository6 A
;A B
private 
readonly 
AuthorRules  
_authorRules! -
;- .
public 

UpdateAuthorHandler 
( "
EntityFrameworkContext 5
context6 =
,= >
DomainHandler 
domainHandler #
,# $
NotificationContext 
notificationContext /
,/ 0,
 IAuthorEntityFrameworkRepository (

repository) 3
,3 4
AuthorRules 
authorRules 
)  
:! "
base# '
(' (
context( /
,/ 0
domainHandler1 >
,> ?
notificationContext@ S
)S T
{ 
_repository 
= 

repository  
;  !
_authorRules 
= 
authorRules "
;" #
} 
public 

async 
Task 
< 
CommandReturnDto &
>& '
Handle( .
(. /
UpdateAuthorCommand/ B
requestC J
,J K
CancellationTokenL ]
cancellationToken^ o
)o p
{ 
var 
result 
= 
new 
CommandReturnDto )
() *
)* +
;+ ,
var!! 
exist!! 
=!! 
await!! 
_repository!! %
.!!% &
GetById!!& -
(!!- .
request!!. 5
.!!5 6
Id!!6 8
,!!8 9
cancellationToken!!: K
)!!K L
;!!L M
if## 

(## 
exist## 
is## 
null## 
)## 
return$$ 
result$$ 
;$$ 
var&& 
data&& 
=&& 
request&& 
.&& 
Adapt&&  
<&&  !
Domain&&! '
.&&' (
Model&&( -
.&&- .
Author&&. 4
>&&4 5
(&&5 6
)&&6 7
;&&7 8
var(( 
isValid(( 
=(( 
await(( 
_authorRules(( (
.((( )
UpdateIsValidAsync(() ;
(((; <
data((< @
,((@ A
cancellationToken((B S
)((S T
;((T U
if** 

(** 
!** 
isValid** 
)** 
return++ 
result++ 
;++ 
await-- 
_repository-- 
.-- 
AddOrUpdate-- %
(--% &
data--& *
,--* +
cancellationToken--, =
)--= >
;--> ?
AddEvent// 
(// 
new// 
UpdateAuthorEvent// &
(//& '
data//' +
)//+ ,
)//, -
;//- .
if11 

(11 
await11 
CommitAsync11 
(11 
cancellationToken11 /
)11/ 0
)110 1
result22 
.22 
Successfully22 
(22  
)22  !
;22! "
return44 
result44 
;44 
}55 
}66 ˚
fC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Handler\Book\CreateBookHandler.cs
	namespace 	
Library
 
. 
Application 
. 
Handler %
.% &
Book& *
;* +
public 
class 
CreateBookHandler 
:  
CommandHandler! /
,/ 0
IRequestHandler 
< 
CreateBookCommand %
,% &
CommandReturnDto' 7
>7 8
{ 
private 
readonly *
IBookEntityFrameworkRepository 3
_repository4 ?
;? @
private 
readonly 
	BookRules 
_rules %
;% &
public 

CreateBookHandler 
( "
EntityFrameworkContext 3
context4 ;
,; <
DomainHandler 
domainHandler #
,# $
NotificationContext 
notificationContext /
,/ 0*
IBookEntityFrameworkRepository &

repository' 1
,1 2
	BookRules 
rules 
) 
: 
base 
(  
context  '
,' (
domainHandler) 6
,6 7
notificationContext8 K
)K L
{ 
_repository 
= 

repository  
;  !
_rules 
= 
rules 
; 
} 
public 

async 
Task 
< 
CommandReturnDto &
>& '
Handle( .
(. /
CreateBookCommand/ @
requestA H
,H I
CancellationTokenJ [
cancellationToken\ m
)m n
{ 
var 
result 
= 
new 
CommandReturnDto )
() *
)* +
;+ ,
var!! 
book!! 
=!! 
request!! 
.!! 
Adapt!!  
<!!  !
Domain!!! '
.!!' (
Model!!( -
.!!- .
Book!!. 2
>!!2 3
(!!3 4
)!!4 5
;!!5 6
var## 
isValid## 
=## 
await## 
_rules## "
.##" #
CreateIsValidAsync### 5
(##5 6
book##6 :
,##: ;
cancellationToken##< M
)##M N
;##N O
if%% 

(%% 
!%% 
isValid%% 
)%% 
return&& 
result&& 
;&& 
await(( 
_repository(( 
.(( 
AddOrUpdate(( %
(((% &
book((& *
,((* +
cancellationToken((, =
)((= >
;((> ?
var** 
domainEvent** 
=** 
new** 
CreatedBookEvent** .
(**. /
book**/ 3
)**3 4
;**4 5
AddEvent,, 
(,, 
domainEvent,, 
),, 
;,, 
if.. 

(.. 
await.. 
CommitAsync.. 
(.. 
cancellationToken.. /
)../ 0
)..0 1
result// 
.// 
Successfully// 
(//  
)//  !
;//! "
return11 
result11 
;11 
}22 
}33 ’
fC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Handler\Book\RemoveBookHandler.cs
	namespace

 	
Library


 
.

 
Application

 
.

 
Handler

 %
.

% &
Book

& *
;

* +
public 
class 
RemoveBookHandler 
:  
CommandHandler! /
,/ 0
IRequestHandler1 @
<@ A
RemoveBookCommandA R
,R S
CommandReturnDtoT d
>d e
{ 
private 
readonly *
IBookEntityFrameworkRepository 3
_repository4 ?
;? @
public 

RemoveBookHandler 
( "
EntityFrameworkContext 3
context4 ;
,; <
DomainHandler 
domainHandler #
,# $
NotificationContext 
notificationContext /
,/ 0*
IBookEntityFrameworkRepository &

repository' 1
)1 2
:3 4
base5 9
(9 :
context: A
,A B
domainHandlerC P
,P Q
notificationContextR e
)e f
{ 
_repository 
= 

repository  
;  !
} 
public 

async 
Task 
< 
CommandReturnDto &
>& '
Handle( .
(. /
RemoveBookCommand/ @
requestA H
,H I
CancellationTokenJ [
cancellationToken\ m
)m n
{ 
var 
result 
= 
new 
CommandReturnDto )
() *
)* +
;+ ,
var 
exist 
= 
await 
_repository %
.% &
GetById& -
(- .
request. 5
.5 6
Id6 8
,8 9
cancellationToken: K
)K L
;L M
if 

( 
exist 
is 
null 
) 
return 
result 
; 
await!! 
_repository!! 
.!! 
Remove!!  
(!!  !
exist!!! &
,!!& '
cancellationToken!!( 9
)!!9 :
;!!: ;
var## 
domainEvent## 
=## 
new## 
RemoveBookEvent## -
(##- .
request##. 5
.##5 6
Id##6 8
)##8 9
;##9 :
AddEvent%% 
(%% 
domainEvent%% 
)%% 
;%% 
if'' 

('' 
await'' 
CommitAsync'' 
('' 
cancellationToken'' /
)''/ 0
)''0 1
result(( 
.(( 
Successfully(( 
(((  
)((  !
;((! "
return** 
result** 
;** 
}++ 
},, ≈
fC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Handler\Book\UpdateBookHandler.cs
	namespace 	
Library
 
. 
Application 
. 
Handler %
.% &
Book& *
;* +
public 
class 
UpdateBookHandler 
:  
CommandHandler! /
,/ 0
IRequestHandler1 @
<@ A
UpdateBookCommandA R
,R S
CommandReturnDtoT d
>d e
{ 
private 
readonly *
IBookEntityFrameworkRepository 3
_repository4 ?
;? @
private 
readonly 
	BookRules 
_rules %
;% &
public 

UpdateBookHandler 
( "
EntityFrameworkContext 3
context4 ;
,; <
DomainHandler 
domainHandler #
,# $
NotificationContext 
notificationContext /
,/ 0*
IBookEntityFrameworkRepository &

repository' 1
,1 2
	BookRules 
rules 
) 
: 
base 
(  
context  '
,' (
domainHandler) 6
,6 7
notificationContext8 K
)K L
{ 
_repository 
= 

repository  
;  !
_rules 
= 
rules 
; 
} 
public 

async 
Task 
< 
CommandReturnDto &
>& '
Handle( .
(. /
UpdateBookCommand/ @
requestA H
,H I
CancellationTokenJ [
cancellationToken\ m
)m n
{ 
var 
result 
= 
new 
CommandReturnDto )
() *
)* +
;+ ,
var   
exist   
=   
await   
_repository   %
.  % &
GetById  & -
(  - .
request  . 5
.  5 6
Id  6 8
,  8 9
cancellationToken  : K
)  K L
;  L M
if"" 

("" 
exist"" 
is"" 
null"" 
)"" 
return## 
result## 
;## 
var%% 
data%% 
=%% 
request%% 
.%% 
Adapt%%  
<%%  !
Domain%%! '
.%%' (
Model%%( -
.%%- .
Book%%. 2
>%%2 3
(%%3 4
)%%4 5
;%%5 6
var'' 
isValid'' 
='' 
await'' 
_rules'' "
.''" #
UpdateIsValidAsync''# 5
(''5 6
data''6 :
,'': ;
cancellationToken''< M
)''M N
;''N O
if)) 

()) 
!)) 
isValid)) 
))) 
return** 
result** 
;** 
await,, 
_repository,, 
.,, 
AddOrUpdate,, %
(,,% &
data,,& *
,,,* +
cancellationToken,,, =
),,= >
;,,> ?
AddEvent.. 
(.. 
new.. 
UpdateBookEvent.. $
(..$ %
data..% )
)..) *
)..* +
;..+ ,
if00 

(00 
await00 
CommitAsync00 
(00 
cancellationToken00 /
)00/ 0
)000 1
result11 
.11 
Successfully11 
(11  
)11  !
;11! "
return33 
result33 
;33 
}44 
}55 å
^C:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Handler\CommandHandler.cs
	namespace 	
Library
 
. 
Application 
. 
Handler %
;% &
public 
abstract 
class 
CommandHandler $
{ 
private		 
readonly		 
IContext		 
_context		 &
;		& '
private

 
readonly

 
DomainHandler

 "
_domainHandler

# 1
;

1 2
private 
readonly 
NotificationContext ( 
_notificationContext) =
;= >
	protected 
CommandHandler 
( 
IContext %
context& -
,- .
DomainHandler/ <
domainHandler= J
,J K
NotificationContextL _
notificationContext` s
)s t
{ 
_context 
= 
context 
; 
_domainHandler 
= 
domainHandler &
;& ' 
_notificationContext 
= 
notificationContext 2
;2 3
} 
	protected 
async 
Task 
< 
bool 
> 
CommitAsync *
(* +
CancellationToken+ <
token= B
=C D
defaultE L
)L M
{ 
try 
{ 	
var 
result 
= 
await 
_context '
.' (
CommitAsync( 3
(3 4
token4 9
)9 :
;: ;
return 
result 
; 
} 	
catch 
( 
	Exception 
ex 
) 
{ 	 
_notificationContext  
.  !
AddNotification! 0
(0 1
$str1 >
,> ?
$"@ B
$strB K
{K L
exL N
.N O
MessageO V
}V W
"W X
)X Y
;Y Z
return 
false 
; 
} 	
}   
	protected"" 
void"" 
AddEvent"" 
("" 
DomainEvent"" '
domainEvent""( 3
)""3 4
=>""5 7
_domainHandler## 
.## 
AddEvent## 
(##  
domainEvent##  +
)##+ ,
;##, -
}$$ ˜z
cC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Mapper\MappingConfiguration.cs
	namespace 	
Library
 
. 
Application 
. 
Mapper $
;$ %
public 
static 
class  
MappingConfiguration (
{ 
public 

static 
void 
RegisterMappings '
(' (
this( ,
IServiceCollection- ?
services@ H
)H I
{ 
TypeAdapterConfig 
< 
AuthorRequestDto *
,* +
CreateAuthorCommand, ?
>? @
.@ A
	NewConfigA J
(J K
)K L
;L M
TypeAdapterConfig 
< 
AuthorRequestDto *
,* +
UpdateAuthorCommand, ?
>? @
.@ A
	NewConfigA J
(J K
)K L
;L M
TypeAdapterConfig 
< 
BookRequestDto (
,( )
CreateBookCommand* ;
>; <
.< =
	NewConfig= F
(F G
)G H
;H I
TypeAdapterConfig 
< 
BookRequestDto (
,( )
UpdateBookCommand* ;
>; <
.< =
	NewConfig= F
(F G
)G H
;H I
TypeAdapterConfig 
< 
CreateAuthorCommand -
,- .
Author/ 5
>5 6
.6 7
	NewConfig7 @
(@ A
)A B
. 
MapWith 
( 
x 
=> 
Author  
.  !
Create! '
(' (
x( )
.) *
Id* ,
,, -
x. /
./ 0
Name0 4
,4 5
x6 7
.7 8
	Biography8 A
,A B
xC D
.D E
DateOfBirthE P
)P Q
)Q R
;R S
TypeAdapterConfig 
< 
UpdateAuthorCommand -
,- .
Author/ 5
>5 6
.6 7
	NewConfig7 @
(@ A
)A B
.   
ConstructUsing   
(   
x   
=>    
Author  ! '
.  ' (
Update  ( .
(  . /
x  / 0
.  0 1
Id  1 3
,  3 4
x  5 6
.  6 7
Name  7 ;
,  ; <
x  = >
.  > ?
	Biography  ? H
,  H I
x  J K
.  K L
DateOfBirth  L W
)  W X
)  X Y
;  Y Z
TypeAdapterConfig"" 
<"" 
CreateBookCommand"" +
,""+ ,
Book""- 1
>""1 2
.""2 3
	NewConfig""3 <
(""< =
)""= >
.""> ?
ConstructUsing""? M
(""M N
c""N O
=>""P R
Book""S W
.""W X
Create""X ^
(""^ _
c""_ `
.""` a
Id""a c
,""c d
c##* +
.##+ ,
Title##, 1
,##1 2
c$$* +
.$$+ ,
Description$$, 7
,$$7 8
c%%* +
.%%+ ,
YearPublication%%, ;
,%%; <
c&&* +
.&&+ ,
Pages&&, 1
,&&1 2
(''* +
BookType''+ 3
)''3 4
c''4 5
.''5 6
BookType''6 >
,''> ?
(((* +
Genre((+ 0
)((0 1
c((1 2
.((2 3
Genre((3 8
,((8 9
c))* +
.))+ ,
Authors)), 3
)))3 4
)))4 5
;))5 6
TypeAdapterConfig++ 
<++ 
UpdateBookCommand++ +
,+++ ,
Book++- 1
>++1 2
.++2 3
	NewConfig++3 <
(++< =
)++= >
.++> ?
ConstructUsing++? M
(++M N
c++N O
=>++P R
Book++S W
.++W X
Update++X ^
(++^ _
c++_ `
.++` a
Id++a c
,++c d
c,,* +
.,,+ ,
Title,,, 1
,,,1 2
c--* +
.--+ ,
Description--, 7
,--7 8
c..* +
...+ ,
YearPublication.., ;
,..; <
c//* +
.//+ ,
Pages//, 1
,//1 2
(00* +
BookType00+ 3
)003 4
c004 5
.005 6
BookType006 >
,00> ?
(11* +
Genre11+ 0
)110 1
c111 2
.112 3
Genre113 8
,118 9
c22* +
.22+ ,
Authors22, 3
)223 4
)224 5
;225 6
TypeAdapterConfig55 
<55 
Author55  
,55  !
AuthorResponseDto55" 3
>553 4
.554 5
	NewConfig555 >
(55> ?
)55? @
;55@ A
TypeAdapterConfig66 
<66 
Book66 
,66 
BookResponseDto66  /
>66/ 0
.660 1
	NewConfig661 :
(66: ;
)66; <
.77 
MapWith77 
(77 
c77 
=>77 
new77 
BookResponseDto77 -
{88 
BookType99 
=99 
new99 
(99 
(99  
int99  #
)99# $
c99$ %
.99% &
BookType99& .
,99. /
nameof990 6
(996 7
c997 8
.998 9
BookType999 A
)99A B
)99B C
,99C D
Description:: 
=:: 
c:: 
.::  
Description::  +
,::+ ,
Genre;; 
=;; 
new;; 
(;; 
(;; 
int;;  
);;  !
c;;! "
.;;" #
Genre;;# (
,;;( )
nameof;;* 0
(;;0 1
c;;1 2
.;;2 3
Genre;;3 8
);;8 9
);;9 :
,;;: ;
Id<< 
=<< 
c<< 
.<< 
Id<< 
,<< 
Pages== 
=== 
c== 
.== 
Pages== 
,==  
Title>> 
=>> 
c>> 
.>> 
Title>> 
,>>  
YearPublication?? 
=??  !
c??" #
.??# $
YearPublication??$ 3
,??3 4
Authors@@ 
=@@ 
c@@ 
.@@ 
BookAuthors@@ '
.@@' (
Select@@( .
(@@. /
c@@/ 0
=>@@1 3
c@@4 5
.@@5 6
AuthorId@@6 >
)@@> ?
}AA 
)AA 
;AA 
TypeAdapterConfigDD 
<DD 

BookAuthorDD $
,DD$ %
BookAuthorMessageDD& 7
>DD7 8
.DD8 9
	NewConfigDD9 B
(DDB C
)DDC D
;DDD E
TypeAdapterConfigFF 
<FF 
BookFF 
,FF 
CreateBookMessageFF  1
>FF1 2
.FF2 3
	NewConfigFF3 <
(FF< =
)FF= >
.GG 
ConstructUsingGG 
(GG 
cGG 
=>GG  
newGG! $
CreateBookMessageGG% 6
(GG6 7
)GG7 8
{HH 
BookAuthorsII 
=II 
cII 
.II  
BookAuthorsII  +
.JJ 
SelectJJ 
(JJ 
cJJ 
=>JJ  
cJJ! "
.JJ" #
AdaptJJ# (
<JJ( )
BookAuthorMessageJJ) :
>JJ: ;
(JJ; <
)JJ< =
)JJ= >
.JJ> ?
ToListJJ? E
(JJE F
)JJF G
,JJG H
BookTypeKK 
=KK 
cKK 
.KK 
BookTypeKK %
,KK% &
	CreatedAtLL 
=LL 
cLL 
.LL 
	CreatedAtLL '
,LL' (
DescriptionMM 
=MM 
cMM 
.MM  
DescriptionMM  +
,MM+ ,
GenreNN 
=NN 
cNN 
.NN 
GenreNN 
,NN  
IdOO 
=OO 
cOO 
.OO 
IdOO 
,OO 
PagesPP 
=PP 
cPP 
.PP 
PagesPP 
,PP  
TitleQQ 
=QQ 
cQQ 
.QQ 
TitleQQ 
,QQ  
	UpdatedAtRR 
=RR 
cRR 
.RR 
	UpdatedAtRR '
,RR' (
YearPublicationSS 
=SS  !
cSS" #
.SS# $
YearPublicationSS$ 3
}TT 
)TT 
;TT 
TypeAdapterConfigVV 
<VV 
BookVV 
,VV 
UpdateBookMessageVV  1
>VV1 2
.VV2 3
	NewConfigVV3 <
(VV< =
)VV= >
.WW 
ConstructUsingWW 
(WW 
cWW 
=>WW  
newWW! $
UpdateBookMessageWW% 6
(WW6 7
)WW7 8
{XX 
BookAuthorsYY 
=YY 
cYY 
.YY  
BookAuthorsYY  +
.ZZ 
SelectZZ 
(ZZ 
cZZ 
=>ZZ  
cZZ! "
.ZZ" #
AdaptZZ# (
<ZZ( )
BookAuthorMessageZZ) :
>ZZ: ;
(ZZ; <
)ZZ< =
)ZZ= >
.ZZ> ?
ToListZZ? E
(ZZE F
)ZZF G
,ZZG H
BookType[[ 
=[[ 
c[[ 
.[[ 
BookType[[ %
,[[% &
	CreatedAt\\ 
=\\ 
c\\ 
.\\ 
	CreatedAt\\ '
,\\' (
Description]] 
=]] 
c]] 
.]]  
Description]]  +
,]]+ ,
Genre^^ 
=^^ 
c^^ 
.^^ 
Genre^^ 
,^^  
Id__ 
=__ 
c__ 
.__ 
Id__ 
,__ 
Pages`` 
=`` 
c`` 
.`` 
Pages`` 
,``  
Titleaa 
=aa 
caa 
.aa 
Titleaa 
,aa  
	UpdatedAtbb 
=bb 
cbb 
.bb 
	UpdatedAtbb '
,bb' (
YearPublicationcc 
=cc  !
ccc" #
.cc# $
YearPublicationcc$ 3
}dd 
)dd 
;dd 
TypeAdapterConfigff 
<ff 
Authorff  
,ff  !
CreateAuthorMessageff" 5
>ff5 6
.ff6 7
	NewConfigff7 @
(ff@ A
)ffA B
;ffB C
TypeAdapterConfiggg 
<gg 
Authorgg  
,gg  !
UpdateAuthorMessagegg" 5
>gg5 6
.gg6 7
	NewConfiggg7 @
(gg@ A
)ggA B
;ggB C
TypeAdapterConfigjj 
<jj 
CreateBookMessagejj +
,jj+ ,
Bookjj- 1
>jj1 2
.jj2 3
	NewConfigjj3 <
(jj< =
)jj= >
.jj> ?
ConstructUsingjj? M
(jjM N
cjjN O
=>jjP R
BookjjS W
.jjW X
CreatejjX ^
(jj^ _
cjj_ `
.jj` a
Idjja c
,jjc d
ckk* +
.kk+ ,
Titlekk, 1
,kk1 2
cll* +
.ll+ ,
Descriptionll, 7
,ll7 8
cmm* +
.mm+ ,
YearPublicationmm, ;
,mm; <
cnn* +
.nn+ ,
Pagesnn, 1
,nn1 2
coo* +
.oo+ ,
BookTypeoo, 4
,oo4 5
cpp* +
.pp+ ,
Genrepp, 1
,pp1 2
cqq* +
.qq+ ,
BookAuthorsqq, 7
.qq7 8
Selectqq8 >
(qq> ?
cqq? @
=>qqA C
newqqD G

BookAuthorqqH R
(qqR S
cqqS T
.qqT U
IdqqU W
,qqW X
cqqY Z
.qqZ [
BookIdqq[ a
,qqa b
cqqc d
.qqd e
AuthorIdqqe m
)qqm n
)qqn o
.qqo p
ToListqqp v
(qqv w
)qqw x
)qqx y
)qqy z
;qqz {
TypeAdapterConfigss 
<ss 
UpdateBookMessagess +
,ss+ ,
Bookss- 1
>ss1 2
.ss2 3
	NewConfigss3 <
(ss< =
)ss= >
.ss> ?
ConstructUsingss? M
(ssM N
cssN O
=>ssP R
BookssS W
.ssW X
UpdatessX ^
(ss^ _
css_ `
.ss` a
Idssa c
,ssc d
ctt* +
.tt+ ,
Titlett, 1
,tt1 2
cuu* +
.uu+ ,
Descriptionuu, 7
,uu7 8
cvv* +
.vv+ ,
YearPublicationvv, ;
,vv; <
cww* +
.ww+ ,
Pagesww, 1
,ww1 2
cxx* +
.xx+ ,
BookTypexx, 4
,xx4 5
cyy* +
.yy+ ,
Genreyy, 1
,yy1 2
czz* +
.zz+ ,
BookAuthorszz, 7
.zz7 8
Selectzz8 >
(zz> ?
czz? @
=>zzA C
newzzD G

BookAuthorzzH R
(zzR S
czzS T
.zzT U
IdzzU W
,zzW X
czzY Z
.zzZ [
BookIdzz[ a
,zza b
czzc d
.zzd e
AuthorIdzze m
)zzm n
)zzn o
.zzo p
ToListzzp v
(zzv w
)zzw x
)zzx y
)zzy z
;zzz {
TypeAdapterConfig|| 
<|| 
CreateAuthorMessage|| -
,||- .
Author||/ 5
>||5 6
.||6 7
	NewConfig||7 @
(||@ A
)||A B
.}} 
ConstructUsing}} 
(}} 
x}} 
=>}}  
Author}}! '
.}}' (
Create}}( .
(}}. /
x}}/ 0
.}}0 1
Id}}1 3
,}}3 4
x}}5 6
.}}6 7
Name}}7 ;
,}}; <
x}}= >
.}}> ?
	Biography}}? H
,}}H I
x}}J K
.}}K L
DateOfBirth}}L W
)}}W X
)}}X Y
;}}Y Z
TypeAdapterConfig 
< 
UpdateAuthorMessage -
,- .
Author/ 5
>5 6
.6 7
	NewConfig7 @
(@ A
)A B
.
ÄÄ 
ConstructUsing
ÄÄ 
(
ÄÄ 
x
ÄÄ 
=>
ÄÄ  
Author
ÄÄ! '
.
ÄÄ' (
Update
ÄÄ( .
(
ÄÄ. /
x
ÄÄ/ 0
.
ÄÄ0 1
Id
ÄÄ1 3
,
ÄÄ3 4
x
ÄÄ5 6
.
ÄÄ6 7
Name
ÄÄ7 ;
,
ÄÄ; <
x
ÄÄ= >
.
ÄÄ> ?
	Biography
ÄÄ? H
,
ÄÄH I
x
ÄÄJ K
.
ÄÄK L
DateOfBirth
ÄÄL W
)
ÄÄW X
)
ÄÄX Y
;
ÄÄY Z
TypeAdapterConfig
ÇÇ 
<
ÇÇ 
BookAuthorMessage
ÇÇ +
,
ÇÇ+ ,

BookAuthor
ÇÇ- 7
>
ÇÇ7 8
.
ÇÇ8 9
	NewConfig
ÇÇ9 B
(
ÇÇB C
)
ÇÇC D
.
ÉÉ 
MapWith
ÉÉ 
(
ÉÉ 
c
ÉÉ 
=>
ÉÉ 
new
ÉÉ 
(
ÉÉ 
c
ÉÉ 
.
ÉÉ  
Id
ÉÉ  "
,
ÉÉ" #
c
ÉÉ$ %
.
ÉÉ% &
BookId
ÉÉ& ,
,
ÉÉ, -
c
ÉÉ. /
.
ÉÉ/ 0
AuthorId
ÉÉ0 8
)
ÉÉ8 9
)
ÉÉ9 :
;
ÉÉ: ;
TypeAdapterConfig
ÖÖ 
.
ÖÖ 
GlobalSettings
ÖÖ (
.
ÖÖ( )
Scan
ÖÖ) -
(
ÖÖ- .
Assembly
ÖÖ. 6
.
ÖÖ6 7"
GetExecutingAssembly
ÖÖ7 K
(
ÖÖK L
)
ÖÖL M
)
ÖÖM N
;
ÖÖN O
}
ÜÜ 
}áá á
aC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Notification\Notification.cs
	namespace 	
Library
 
. 
Application 
. 
Notification *
;* +
public 
class 
Notification 
{ 
public 

string 
Key 
{ 
get 
; 
} 
public 

string 
Message 
{ 
get 
;  
}! "
public 

Notification 
( 
string 
key "
," #
string$ *
message+ 2
)2 3
{		 
Key

 
=

 
key

 
;

 
Message 
= 
message 
; 
} 
} ª
hC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Notification\NotificationContext.cs
	namespace 	
Library
 
. 
Application 
. 
Notification *
;* +
public 
class 
NotificationContext  
{ 
private 
readonly 
List 
< 
Notification &
>& '
_notifications( 6
;6 7
public 

IReadOnlyCollection 
< 
Notification +
>+ ,
Notifications- :
=>; =
_notifications> L
;L M
public 

bool 
HasNotifications  
=>! #
_notifications$ 2
.2 3
Any3 6
(6 7
)7 8
;8 9
public		 

NotificationContext		 
(		 
)		  
{

 
_notifications 
= 
new 
List !
<! "
Notification" .
>. /
(/ 0
)0 1
;1 2
} 
public 

virtual 
void 
AddNotification '
(' (
string( .
key/ 2
,2 3
string4 :
message; B
)B C
{ 
_notifications 
. 
Add 
( 
new 
Notification +
(+ ,
key, /
,/ 0
message1 8
)8 9
)9 :
;: ;
} 
public 

virtual 
void 
AddNotification '
(' (
Notification( 4
notification5 A
)A B
{ 
_notifications 
. 
Add 
( 
notification '
)' (
;( )
} 
} Í5
YC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Rules\AuthorRules.cs
	namespace 	
Library
 
. 
Application 
. 
Rules #
;# $
public 
class 
AuthorRules 
{		 
private

 
readonly

 ,
 IAuthorEntityFrameworkRepository

 5
_authorRepository

6 G
;

G H
private 
readonly *
IBookEntityFrameworkRepository 3
_bookRepository4 C
;C D
private 
readonly 
NotificationContext (
_notification) 6
;6 7
public 

AuthorRules 
( ,
 IAuthorEntityFrameworkRepository 7
authorRepository8 H
,H I*
IBookEntityFrameworkRepositoryJ h
bookRepositoryi w
,w x 
NotificationContext	y å
notification
ç ô
)
ô ö
{ 
_authorRepository 
= 
authorRepository ,
;, -
_notification 
= 
notification $
;$ %
_bookRepository 
= 
bookRepository (
;( )
} 
public 

virtual 
async 
Task 
< 
bool "
>" #
CreateIsValidAsync$ 6
(6 7
Author7 =
param> C
,C D
CancellationTokenE V
cancellationTokenW h
=i j
defaultk r
)r s
{ 
if 

( 
await 
ExistAuthor 
( 
c 
=>  "
c# $
.$ %
Name% )
==* ,
param- 2
.2 3
Name3 7
,7 8
cancellationToken9 J
)J K
)K L
{ 	
_notification 
. 
AddNotification )
() *
$str* A
,A B
$"C E
$strE U
{U V
paramV [
.[ \
Name\ `
}` a
$str	a Ö
"
Ö Ü
)
Ü á
;
á à
return 
await 
Task 
. 

FromResult (
(( )
false) .
). /
;/ 0
} 	
return 
await 
Task 
. 

FromResult $
($ %
true% )
)) *
;* +
} 
public   

virtual   
async   
Task   
<   
bool   "
>  " #
RemoveIsValidAsync  $ 6
(  6 7
Guid  7 ;
id  < >
,  > ?
CancellationToken  @ Q
cancellationToken  R c
=  d e
default  f m
)  m n
{!! 
var"" 
existBookWithAuthor"" 
=""  !
await""" '
_bookRepository""( 7
.""7 8
Get""8 ;
(""; <
c""< =
=>""> @
c""A B
.""B C
BookAuthors""C N
.""N O
Any""O R
(""R S
c""S T
=>""U W
c""X Y
.""Y Z
AuthorId""Z b
==""c e
id""f h
)""h i
,""i j
page""k o
:""o p
$num""q r
,""r s
pageSize""t |
:""| }
$num""~ 
,	"" Ä
cancellationToken
""Å í
:
""í ì
cancellationToken
""î •
)
""• ¶
;
""¶ ß
if$$ 

($$ 
existBookWithAuthor$$ 
.$$  
Any$$  #
($$# $
)$$$ %
)$$% &
{%% 	
_notification&& 
.&& 
AddNotification&& )
(&&) *
$str&&* A
,&&A B
$"&&C E
$str	&&E ã
"
&&ã å
)
&&å ç
;
&&ç é
return'' 
await'' 
Task'' 
.'' 

FromResult'' (
(''( )
false'') .
)''. /
;''/ 0
})) 	
return** 
await** 
Task** 
.** 

FromResult** $
(**$ %
true**% )
)**) *
;*** +
}++ 
public-- 

virtual-- 
async-- 
Task-- 
<-- 
bool-- "
>--" #
UpdateIsValidAsync--$ 6
(--6 7
Author--7 =
param--> C
,--C D
CancellationToken--E V
cancellationToken--W h
=--i j
default--k r
)--r s
{.. 
if// 

(// 
await// 
ExistAuthor// 
(// 
c// 
=>//  "
c//# $
.//$ %
Name//% )
==//* ,
param//- 2
.//2 3
Name//3 7
&&//8 :
c//; <
.//< =
Id//= ?
!=//@ B
param//C H
.//H I
Id//I K
,//K L
cancellationToken//M ^
)//^ _
)//_ `
{00 	
_notification11 
.11 
AddNotification11 )
(11) *
$str11* A
,11A B
$"11C E
$str11E U
{11U V
param11V [
.11[ \
Name11\ `
}11` a
$str	11a Ö
"
11Ö Ü
)
11Ü á
;
11á à
return22 
await22 
Task22 
.22 

FromResult22 (
(22( )
false22) .
)22. /
;22/ 0
}33 	
return55 
await55 
Task55 
.55 

FromResult55 $
(55$ %
true55% )
)55) *
;55* +
}66 
private77 
async77 
Task77 
<77 
bool77 
>77 
ExistAuthor77 (
(77( )

Expression77) 3
<773 4
Func774 8
<778 9
Author779 ?
,77? @
bool77A E
>77E F
>77F G

expression77H R
,77R S
CancellationToken77T e
cancellationToken77f w
=77x y
default	77z Å
)
77Å Ç
{88 
var99 
result99 
=99 
await99 
_authorRepository99 ,
.99, -
Get99- 0
(990 1

expression991 ;
,99; <
page99= A
:99A B
$num99C D
,99D E
pageSize99F N
:99N O
$num99P Q
,99Q R
cancellationToken99S d
:99d e
cancellationToken99f w
)99w x
;99x y
return;; 
result;; 
.;; 
Any;; 
(;; 
);; 
;;; 
}<< 
}== ûC
WC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Rules\BookRules.cs
	namespace 	
Library
 
. 
Application 
. 
Rules #
;# $
public 
class 
	BookRules 
{		 
private

 
readonly

 *
IBookEntityFrameworkRepository

 3
_bookRepository

4 C
;

C D
private 
readonly ,
 IAuthorEntityFrameworkRepository 5
_authorRepository6 G
;G H
private 
readonly 
NotificationContext (
_notification) 6
;6 7
public 

	BookRules 
( *
IBookEntityFrameworkRepository 3
bookRepository4 B
,B C,
 IAuthorEntityFrameworkRepositoryD d
authorRepositorye u
,u v 
NotificationContext	w ä
notification
ã ó
)
ó ò
{ 
_bookRepository 
= 
bookRepository (
;( )
_notification 
= 
notification $
;$ %
_authorRepository 
= 
authorRepository ,
;, -
} 
public 

virtual 
async 
Task 
< 
bool "
>" #
CreateIsValidAsync$ 6
(6 7
Book7 ;
param< A
,A B
CancellationTokenC T
cancellationTokenU f
=g h
defaulti p
)p q
{ 
if 

( 
await 
	ExistBook 
( 
c 
=>  
c! "
." #
Title# (
==) +
param, 1
.1 2
Title2 7
,7 8
cancellationToken9 J
)J K
)K L
{ 	
_notification 
. 
AddNotification )
() *
$str* ,
,, -
$". 0
$str0 @
{@ A
paramA F
.F G
TitleG L
}L M
$strM n
"n o
)o p
;p q
return 
await 
Task 
. 

FromResult (
(( )
false) .
). /
;/ 0
} 	
if 

( 
! 
await 
ExistAuthors 
(  
param  %
.% &
BookAuthors& 1
.1 2
Select2 8
(8 9
c9 :
=>; =
c> ?
.? @
AuthorId@ H
)H I
.I J
ToArrayJ Q
(Q R
)R S
,S T
cancellationTokenU f
)f g
)g h
{ 	
_notification 
. 
AddNotification )
() *
$str* ,
,, -
$". 0
$str0 @
{@ A
paramA F
.F G
TitleG L
}L M
$strM q
"q r
)r s
;s t
return   
await   
Task   
.   

FromResult   (
(  ( )
false  ) .
)  . /
;  / 0
}!! 	
return## 
await## 
Task## 
.## 

FromResult## $
(##$ %
true##% )
)##) *
;##* +
}$$ 
public&& 

virtual&& 
async&& 
Task&& 
<&& 
bool&& "
>&&" #
UpdateIsValidAsync&&$ 6
(&&6 7
Book&&7 ;
param&&< A
,&&A B
CancellationToken&&C T
cancellationToken&&U f
=&&g h
default&&i p
)&&p q
{'' 
if(( 

((( 
await(( 
	ExistBook(( 
((( 
c(( 
=>((  
c((! "
.((" #
Title((# (
==(() +
param((, 1
.((1 2
Title((2 7
&&((8 :
c((; <
.((< =
Id((= ?
!=((@ B
param((C H
.((H I
Id((I K
,((K L
cancellationToken((M ^
)((^ _
)((_ `
{)) 	
_notification** 
.** 
AddNotification** )
(**) *
$str*** ,
,**, -
$"**. 0
$str**0 @
{**@ A
param**A F
.**F G
Title**G L
}**L M
$str**M n
"**n o
)**o p
;**p q
return,, 
await,, 
Task,, 
.,, 

FromResult,, (
(,,( )
false,,) .
),,. /
;,,/ 0
}-- 	
if// 

(// 
!// 
await// 
ExistAuthors// 
(//  
param//  %
.//% &
BookAuthors//& 1
.//1 2
Select//2 8
(//8 9
c//9 :
=>//; =
c//> ?
.//? @
AuthorId//@ H
)//H I
.//I J
ToArray//J Q
(//Q R
)//R S
,//S T
cancellationToken//U f
)//f g
)//g h
{00 	
_notification11 
.11 
AddNotification11 )
(11) *
$str11* ,
,11, -
$"11. 0
$str110 @
{11@ A
param11A F
.11F G
Title11G L
}11L M
$str11M o
"11o p
)11p q
;11q r
return22 
await22 
Task22 
.22 

FromResult22 (
(22( )
false22) .
)22. /
;22/ 0
}33 	
return55 
await55 
Task55 
.55 

FromResult55 $
(55$ %
true55% )
)55) *
;55* +
}66 
private88 
async88 
Task88 
<88 
bool88 
>88 
ExistAuthors88 )
(88) *
Guid88* .
[88. /
]88/ 0
ids881 4
,884 5
CancellationToken886 G
cancellationToken88H Y
)88Y Z
{99 
var:: 
authors:: 
=:: 
await:: 
_authorRepository:: -
.::- .
Get::. 1
(::1 2
c::2 3
=>::4 6
ids::7 :
.::: ;
Contains::; C
(::C D
c::D E
.::E F
Id::F H
)::H I
,::I J
page::K O
:::O P
$num::Q R
,::R S
pageSize::T \
:::\ ]
$num::^ _
,::_ `
cancellationToken::a r
:::r s
cancellationToken	::t Ö
)
::Ö Ü
;
::Ü á
if<< 

(<< 
authors<< 
==<< 
null<< 
||<< 
!<<  
authors<<  '
.<<' (
Any<<( +
(<<+ ,
)<<, -
||<<. 0
authors<<1 8
.<<8 9
Count<<9 >
(<<> ?
)<<? @
!=<<A C
ids<<D G
.<<G H
Length<<H N
)<<N O
return== 
await== 
Task== 
.== 

FromResult== (
(==( )
false==) .
)==. /
;==/ 0
return?? 
await?? 
Task?? 
.?? 

FromResult?? $
(??$ %
true??% )
)??) *
;??* +
}@@ 
privateBB 
asyncBB 
TaskBB 
<BB 
boolBB 
>BB 
	ExistBookBB &
(BB& '

ExpressionBB' 1
<BB1 2
FuncBB2 6
<BB6 7
BookBB7 ;
,BB; <
boolBB= A
>BBA B
>BBB C

expressionBBD N
,BBN O
CancellationTokenBBP a
cancellationTokenBBb s
=BBt u
defaultBBv }
)BB} ~
{CC 
varDD 
resultDD 
=DD 
awaitDD 
_bookRepositoryDD *
.DD* +
GetDD+ .
(DD. /

expressionDD/ 9
,DD9 :
pageDD; ?
:DD? @
$numDDA B
,DDB C
pageSizeDDD L
:DDL M
$numDDN O
,DDO P
cancellationTokenDDQ b
:DDb c
cancellationTokenDDd u
)DDu v
;DDv w
returnFF 
resultFF 
.FF 
AnyFF 
(FF 
)FF 
;FF 
}GG 
}HH ÓJ
_C:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Services\AuthorServices.cs
	namespace 	
Library
 
. 
Application 
. 
Services &
;& '
public 
class 
AuthorServices 
: 
IAuthorServices -
{ 
private 
readonly 
	IMediator 
	_mediator (
;( )
private 
readonly "
IAuthorMongoRepository +"
_authorMongoRepository, B
;B C
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 

AuthorServices 
( 
	IMediator #
mediator$ ,
,, -"
IAuthorMongoRepository. D!
authorMongoRepositoryE Z
,Z [
ICacheService\ i
cacheServicej v
)v w
{ 
	_mediator 
= 
mediator 
; "
_authorMongoRepository 
=  !
authorMongoRepository! 6
;6 7
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
< 
Guid 
? 
> 
Create #
(# $
AuthorRequestDto$ 4
param5 :
,: ;
CancellationToken< M
cancellationTokenN _
=` a
defaultb i
)i j
{ 
var 
data 
= 
param 
. 
Adapt 
< 
CreateAuthorCommand 2
>2 3
(3 4
)4 5
;5 6
var   
result   
=   
await   
	_mediator   $
.  $ %
Send  % )
(  ) *
data  * .
,  . /
cancellationToken  0 A
)  A B
;  B C
if"" 

("" 
!"" 
result"" 
."" 
Success"" 
)"" 
return## 
await## 
Task## 
.## 

FromResult## (
<##( )
Guid##) -
?##- .
>##. /
(##/ 0
null##0 4
)##4 5
;##5 6
return%% 
data%% 
.%% 
Id%% 
;%% 
}&& 
public(( 

async(( 
Task(( 
<(( 
AuthorResponseDto(( '
?((' (
>((( )
GetById((* 1
(((1 2
Guid((2 6
id((7 9
,((9 :
CancellationToken((; L
cancellationToken((M ^
=((_ `
default((a h
)((h i
{)) 
var** 
key** 
=** 
$"** 
{** 
CachePrefix**  
.**  !
AuthorCachePrefix**! 2
}**2 3
$str**3 4
{**4 5
id**5 7
}**7 8
"**8 9
;**9 :
var,, 
	fromCache,, 
=,, 
await,, 
_cacheService,, +
.,,+ ,
GetAsync,,, 4
<,,4 5
Author,,5 ;
>,,; <
(,,< =
key,,= @
,,,@ A
cancellationToken,,B S
),,S T
;,,T U
if.. 

(..
 
	fromCache.. 
is.. 
not.. 
null..  
)..  !
return// 
	fromCache// 
.// 
Adapt// "
<//" #
AuthorResponseDto//# 4
>//4 5
(//5 6
)//6 7
;//7 8
var11 
data11 
=11 
await11 "
_authorMongoRepository11 /
.11/ 0
GetById110 7
(117 8
id118 :
,11: ;
cancellationToken11< M
)11M N
;11N O
if33 

(33 
data33 
is33 
null33 
)33 
return44 
await44 
Task44 
.44 

FromResult44 (
<44( )
AuthorResponseDto44) :
?44: ;
>44; <
(44< =
null44= A
)44A B
;44B C
await66 
_cacheService66 
.66 
SetAsync66 $
(66$ %
key66% (
,66( )
data66* .
,66. /
cancellationToken660 A
)66A B
;66B C
var88 
result88 
=88 
data88 
.88 
Adapt88 
<88  
AuthorResponseDto88  1
>881 2
(882 3
)883 4
;884 5
return:: 
result:: 
;:: 
};; 
public== 

async== 
Task== 
<== 
IEnumerable== !
<==! "
AuthorResponseDto==" 3
>==3 4
>==4 5
GetAll==6 <
(==< =
PaginateRequest=== L
paginate==M U
,==U V
AuthorQueryParamDto==W j
param==k p
,==p q
CancellationToken	==r É
cancellationToken
==Ñ ï
=
==ñ ó
default
==ò ü
)
==ü †
{>> 

Expression?? 
<?? 
Func?? 
<?? 
Author?? 
,?? 
bool??  $
>??$ %
>??% &

expression??' 1
=??2 3
c??4 5
=>??6 8
param??9 >
!=??? A
null??B F
&&??G I
(@@ 
string@@ 
.@@ 
IsNullOrWhiteSpace@@ *
(@@* +
param@@+ 0
.@@0 1
Name@@1 5
)@@5 6
||@@7 9
c@@: ;
.@@; <
Name@@< @
.@@@ A
Contains@@A I
(@@I J
param@@J O
.@@O P
Name@@P T
)@@T U
&&@@V X
(AA 
!AA 
paramAA 
.AA 
IdAA 
.AA 
AnyAA 
(AA 
)AA  
||AA! #
paramAA$ )
.AA) *
IdAA* ,
.AA, -
ContainsAA- 5
(AA5 6
cAA6 7
.AA7 8
IdAA8 :
)AA: ;
)AA; <
)AA< =
;AA= >
varCC 
dataCC 
=CC 
awaitCC "
_authorMongoRepositoryCC /
.CC/ 0
GetCC0 3
(CC3 4

expressionCC4 >
,CC> ?
paginateCC@ H
.CCH I
pageCCI M
,CCM N
paginateCCO W
.CCW X
sizeCCX \
,CC\ ]
cancellationTokenCC^ o
)CCo p
;CCp q
ifEE 

(EE 
dataEE 
isEE 
nullEE 
)EE 
returnFF 
awaitFF 
TaskFF 
.FF 

FromResultFF (
(FF( )
ArrayFF) .
.FF. /
EmptyFF/ 4
<FF4 5
AuthorResponseDtoFF5 F
>FFF G
(FFG H
)FFH I
)FFI J
;FFJ K
returnHH 
dataHH 
.HH 
SelectHH 
(HH 
cHH 
=>HH 
cHH  !
.HH! "
AdaptHH" '
<HH' (
AuthorResponseDtoHH( 9
>HH9 :
(HH: ;
)HH; <
)HH< =
;HH= >
}II 
publicLL 

asyncLL 
TaskLL 
<LL 
boolLL 
>LL 
RemoveLL "
(LL" #
GuidLL# '
idLL( *
,LL* +
CancellationTokenLL, =
cancellationTokenLL> O
=LLP Q
defaultLLR Y
)LLY Z
{MM 
varNN 
dataNN 
=NN 
newNN 
RemoveAuthorCommandNN *
(NN* +
idNN+ -
)NN- .
;NN. /
varPP 
resultPP 
=PP 
awaitPP 
	_mediatorPP $
.PP$ %
SendPP% )
(PP) *
dataPP* .
,PP. /
cancellationTokenPP0 A
)PPA B
;PPB C
returnRR 
resultRR 
.RR 
SuccessRR 
;RR 
}SS 
publicUU 

asyncUU 
TaskUU 
<UU 
boolUU 
>UU 
UpdateUU "
(UU" #
GuidUU# '
idUU( *
,UU* +
AuthorRequestDtoUU, <
paramUU= B
,UUB C
CancellationTokenUUD U
cancellationTokenUUV g
=UUh i
defaultUUj q
)UUq r
{VV 
varWW 
dataWW 
=WW 
paramWW 
.WW 
AdaptWW 
<WW 
UpdateAuthorCommandWW 2
>WW2 3
(WW3 4
)WW4 5
;WW5 6
dataXX 
.XX 
IdXX 
=XX 
idXX 
;XX 
varZZ 
resultZZ 
=ZZ 
awaitZZ 
	_mediatorZZ $
.ZZ$ %
SendZZ% )
(ZZ) *
dataZZ* .
,ZZ. /
cancellationTokenZZ0 A
)ZZA B
;ZZB C
return\\ 
result\\ 
.\\ 
Success\\ 
;\\ 
}]] 
public`` 

	ValueTask`` 
DisposeAsync`` !
(``! "
)``" #
{aa 
GCbb 

.bb
 
SuppressFinalizebb 
(bb 
thisbb  
)bb  !
;bb! "
returncc 
	ValueTaskcc 
.cc 
CompletedTaskcc &
;cc& '
}dd 
}ee §T
]C:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Services\BookServices.cs
	namespace 	
Library
 
. 
Application 
. 
Services &
;& '
public 
class 
BookServices 
: 
IBookServices )
{ 
private 
readonly 
	IMediator 
	_mediator (
;( )
private 
readonly  
IBookMongoRepository ) 
_bookMongoRepository* >
;> ?
private 
readonly 
ICacheService "
_cacheService# 0
;0 1
public 

BookServices 
( 
	IMediator !
mediator" *
,* + 
IBookMongoRepository, @
bookMongoRepositoryA T
,T U
ICacheServiceV c
cacheServiced p
)p q
{ 
	_mediator 
= 
mediator 
;  
_bookMongoRepository 
= 
bookMongoRepository 2
;2 3
_cacheService 
= 
cacheService $
;$ %
} 
public 

async 
Task 
< 
Guid 
? 
> 
Create #
(# $
BookRequestDto$ 2
param3 8
,8 9
CancellationToken: K
cancellationTokenL ]
=^ _
default` g
)g h
{ 
var 
data 
= 
param 
. 
Adapt 
< 
CreateBookCommand 0
>0 1
(1 2
)2 3
;3 4
var 
result 
= 
await 
	_mediator $
.$ %
Send% )
() *
data* .
,. /
cancellationToken0 A
)A B
;B C
if!! 

(!! 
!!! 
result!! 
.!! 
Success!! 
)!! 
return"" 
null"" 
;"" 
return$$ 
data$$ 
.$$ 
Id$$ 
;$$ 
}%% 
public'' 

	ValueTask'' 
DisposeAsync'' !
(''! "
)''" #
{(( 
GC)) 

.))
 
SuppressFinalize)) 
()) 
this))  
)))  !
;))! "
return** 
	ValueTask** 
.** 
CompletedTask** &
;**& '
}++ 
public-- 

async-- 
Task-- 
<-- 
BookResponseDto-- %
?--% &
>--& '
GetById--( /
(--/ 0
Guid--0 4
id--5 7
,--7 8
CancellationToken--9 J
cancellationToken--K \
=--] ^
default--_ f
)--f g
{.. 
var// 
key// 
=// 
$"// 
{// 
CachePrefix//  
.//  !
BookCachePrefix//! 0
}//0 1
$str//1 2
{//2 3
id//3 5
}//5 6
"//6 7
;//7 8
var11 
	fromCache11 
=11 
await11 
_cacheService11 +
.11+ ,
GetAsync11, 4
<114 5
Book115 9
>119 :
(11: ;
key11; >
,11> ?
cancellationToken11@ Q
)11Q R
;11R S
if33 

(33 
	fromCache33 
is33 
not33 
null33 !
)33! "
return44 
	fromCache44 
.44 
Adapt44 "
<44" #
BookResponseDto44# 2
>442 3
(443 4
)444 5
;445 6
var66 
data66 
=66 
await66  
_bookMongoRepository66 -
.66- .
GetById66. 5
(665 6
id666 8
,668 9
cancellationToken66: K
)66K L
;66L M
if88 

(88 
data88 
is88 
null88 
)88 
return99 
await99 
Task99 
.99 

FromResult99 (
<99( )
BookResponseDto99) 8
?998 9
>999 :
(99: ;
null99; ?
)99? @
;99@ A
await;; 
_cacheService;; 
.;; 
SetAsync;; $
(;;$ %
key;;% (
,;;( )
data;;* .
,;;. /
cancellationToken;;0 A
);;A B
;;;B C
return== 
data== 
.== 
Adapt== 
<== 
BookResponseDto== )
>==) *
(==* +
)==+ ,
;==, -
}>> 
public@@ 

async@@ 
Task@@ 
<@@ 
IEnumerable@@ !
<@@! "
BookResponseDto@@" 1
>@@1 2
>@@2 3
GetAll@@4 :
(@@: ;
PaginateRequest@@; J
paginate@@K S
,@@S T
BookQueryParamDto@@U f
param@@g l
,@@l m
CancellationToken@@n 
cancellationToken
@@Ä ë
=
@@í ì
default
@@î õ
)
@@õ ú
{AA 

ExpressionBB 
<BB 
FuncBB 
<BB 
BookBB 
,BB 
boolBB "
>BB" #
>BB# $

expressionBB% /
=BB0 1
cBB2 3
=>BB4 6
paramBB7 <
!=BB= ?
nullBB@ D
&&BBE G
(CC 
stringCC 
.CC 
IsNullOrWhiteSpaceCC *
(CC* +
paramCC+ 0
.CC0 1
TitleCC1 6
)CC6 7
||CC8 :
cCC; <
.CC< =
TitleCC= B
.CCB C
ContainsCCC K
(CCK L
paramCCL Q
.CCQ R
TitleCCR W
)CCW X
&&CCY [
(DD 
paramDD 
.DD 
YearPublicationDD &
<=DD' )
$numDD* +
||DD, .
cDD/ 0
.DD0 1
YearPublicationDD1 @
==DDA C
paramDDD I
.DDI J
YearPublicationDDJ Y
)DDY Z
&&DD[ ]
(EE 
paramEE 
.EE 
BookTypeEE 
<EE  !
$numEE" #
||EE$ &
(EE' (
intEE( +
)EE+ ,
cEE, -
.EE- .
BookTypeEE. 6
==EE7 9
paramEE: ?
.EE? @
BookTypeEE@ H
)EEH I
&&EEJ L
(FF 
paramFF 
.FF 
GenreFF 
<FF 
$numFF  
||FF! #
(FF$ %
intFF% (
)FF( )
cFF) *
.FF* +
GenreFF+ 0
==FF1 3
paramFF4 9
.FF9 :
GenreFF: ?
)FF? @
&&FFA C
(HH 
!HH 
paramHH 
.HH 
IdHH 
.HH 
AnyHH 
(HH 
)HH  
||HH! #
paramHH$ )
.HH) *
IdHH* ,
.HH, -
ContainsHH- 5
(HH5 6
cHH6 7
.HH7 8
IdHH8 :
)HH: ;
)HH; <
)HH< =
&&HH> @
(II 
!II 
paramII 
.II 
AuthorIdII  
.II  !
AnyII! $
(II$ %
)II% &
||II' )
paramII* /
.II/ 0
AuthorIdII0 8
.II8 9
	IntersectII9 B
(IIB C
cIIC D
.IID E
BookAuthorsIIE P
.IIP Q
SelectIIQ W
(IIW X
cIIX Y
=>IIZ \
cII] ^
.II^ _
AuthorIdII_ g
)IIg h
)IIh i
.IIi j
AnyIIj m
(IIm n
)IIn o
)IIo p
;IIp q
varKK 
dataKK 
=KK 
awaitKK  
_bookMongoRepositoryKK -
.KK- .
GetKK. 1
(KK1 2

expressionKK2 <
,KK< =
paginateKK> F
.KKF G
pageKKG K
,KKK L
paginateKKM U
.KKU V
sizeKKV Z
,KKZ [
cancellationTokenKK\ m
)KKm n
;KKn o
ifMM 

(MM 
dataMM 
isMM 
nullMM 
)MM 
returnNN 
awaitNN 
TaskNN 
.NN 

FromResultNN (
(NN( )
ArrayNN) .
.NN. /
EmptyNN/ 4
<NN4 5
BookResponseDtoNN5 D
>NND E
(NNE F
)NNF G
)NNG H
;NNH I
returnPP 
dataPP 
.PP 
SelectPP 
(PP 
cPP 
=>PP 
cPP  !
.PP! "
AdaptPP" '
<PP' (
BookResponseDtoPP( 7
>PP7 8
(PP8 9
)PP9 :
)PP: ;
;PP; <
}QQ 
publicSS 

asyncSS 
TaskSS 
<SS 
boolSS 
>SS 
RemoveSS "
(SS" #
GuidSS# '
idSS( *
,SS* +
CancellationTokenSS, =
cancellationTokenSS> O
=SSP Q
defaultSSR Y
)SSY Z
{TT 
varUU 
dataUU 
=UU 
newUU 
RemoveBookCommandUU (
(UU( )
idUU) +
)UU+ ,
;UU, -
varWW 
resultWW 
=WW 
awaitWW 
	_mediatorWW $
.WW$ %
SendWW% )
(WW) *
dataWW* .
,WW. /
cancellationTokenWW0 A
)WWA B
;WWB C
returnYY 
resultYY 
.YY 
SuccessYY 
;YY 
}[[ 
public]] 

async]] 
Task]] 
<]] 
bool]] 
>]] 
Update]] "
(]]" #
Guid]]# '
id]]( *
,]]* +
BookRequestDto]], :
param]]; @
,]]@ A
CancellationToken]]B S
cancellationToken]]T e
=]]f g
default]]h o
)]]o p
{^^ 
var__ 
data__ 
=__ 
param__ 
.__ 
Adapt__ 
<__ 
UpdateBookCommand__ 0
>__0 1
(__1 2
)__2 3
;__3 4
data`` 
.`` 
Id`` 
=`` 
id`` 
;`` 
varbb 
resultbb 
=bb 
awaitbb 
	_mediatorbb $
.bb$ %
Sendbb% )
(bb) *
databb* .
,bb. /
cancellationTokenbb0 A
)bbA B
;bbB C
returndd 
resultdd 
.dd 
Successdd 
;dd 
}ee 
}ff Ø
jC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Services\Interface\IAuthorServices.cs
	namespace 	
Library
 
. 
Application 
. 
Services &
.& '
	Interface' 0
;0 1
public 
	interface 
IAuthorServices  
:! "
IAsyncDisposable# 3
{ 
Task 
< 	
Guid	 
? 
> 
Create 
( 
AuthorRequestDto '
param( -
,- .
CancellationToken/ @
cancellationTokenA R
=S T
defaultU \
)\ ]
;] ^
Task		 
<		 	
AuthorResponseDto			 
?		 
>		 
GetById		 $
(		$ %
Guid		% )
id		* ,
,		, -
CancellationToken		. ?
cancellationToken		@ Q
=		R S
default		T [
)		[ \
;		\ ]
Task

 
<

 	
IEnumerable

	 
<

 
AuthorResponseDto

 &
>

& '
>

' (
GetAll

) /
(

/ 0
PaginateRequest

0 ?
paginate

@ H
,

H I
AuthorQueryParamDto

J ]
param

^ c
,

c d
CancellationToken

e v
cancellationToken	

w à
=


â ä
default


ã í
)


í ì
;


ì î
Task 
< 	
bool	 
> 
Remove 
( 
Guid 
id 
, 
CancellationToken 0
cancellationToken1 B
=C D
defaultE L
)L M
;M N
Task 
< 	
bool	 
> 
Update 
( 
Guid 
id 
, 
AuthorRequestDto /
param0 5
,5 6
CancellationToken7 H
cancellationTokenI Z
=[ \
default] d
)d e
;e f
} °
hC:\Users\patrick.amorim\source\repos\Library\src\Library.Application\Services\Interface\IBookServices.cs
	namespace 	
Library
 
. 
Application 
. 
Services &
.& '
	Interface' 0
;0 1
public 
	interface 
IBookServices 
:  
IAsyncDisposable! 1
{ 
Task 
< 	
Guid	 
? 
> 
Create 
( 
BookRequestDto %
param& +
,+ ,
CancellationToken- >
cancellationToken? P
=Q R
defaultS Z
)Z [
;[ \
Task		 
<		 	
BookResponseDto			 
?		 
>		 
GetById		 "
(		" #
Guid		# '
id		( *
,		* +
CancellationToken		, =
cancellationToken		> O
=		P Q
default		R Y
)		Y Z
;		Z [
Task

 
<

 	
IEnumerable

	 
<

 
BookResponseDto

 $
>

$ %
>

% &
GetAll

' -
(

- .
PaginateRequest

. =
paginate

> F
,

F G
BookQueryParamDto

H Y
param

Z _
,

_ `
CancellationToken

a r
cancellationToken	

s Ñ
=


Ö Ü
default


á é
)


é è
;


è ê
Task 
< 	
bool	 
> 
Remove 
( 
Guid 
id 
, 
CancellationToken 0
cancellationToken1 B
=C D
defaultE L
)L M
;M N
Task 
< 	
bool	 
> 
Update 
( 
Guid 
id 
, 
BookRequestDto -
param. 3
,3 4
CancellationToken5 F
cancellationTokenG X
=Y Z
default[ b
)b c
;c d
} 