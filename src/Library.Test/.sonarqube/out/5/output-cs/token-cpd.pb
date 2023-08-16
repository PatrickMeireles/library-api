áB
]C:\Users\patrick.amorim\source\repos\Library\src\Library.Api\Controllers\AuthorsController.cs
	namespace 	
Library
 
. 
Api 
. 
Controllers !
{ 
[		 
Route		 

(		
 
$str		 3
)		3 4
]		4 5
[

 
ApiController

 
]

 
[ 

ApiVersion 
( 
$str 
) 
] 
public 

class 
AuthorsController "
:# $
ControllerBase% 3
{ 
private 
readonly 
IAuthorServices (
	_services) 2
;2 3
public 
AuthorsController  
(  !
IAuthorServices! 0
authorServices1 ?
)? @
=>A C
	_services 
= 
authorServices &
;& '
[ 	
HttpPost	 
] 
[ 	 
ProducesResponseType	 
( 
StatusCodes )
.) *
Status200OK* 5
)5 6
]6 7
[ 	 
ProducesResponseType	 
( 
StatusCodes )
.) *
Status400BadRequest* =
)= >
]> ?
public 
async 
Task 
< 
IActionResult '
>' (
Post) -
(- .
[. /
FromBody/ 7
]7 8
AuthorRequestDto9 I
modelJ O
,O P
CancellationTokenQ b
cancellationTokenc t
=u v
defaultw ~
)~ 
{ 	
var 
result 
= 
await 
	_services (
.( )
Create) /
(/ 0
model0 5
,5 6
cancellationToken7 H
)H I
;I J
if 
( 
! 
result 
. 
HasValue  
)  !
return 

BadRequest !
(! "
)" #
;# $
return 
Created 
( 
$" 
{ 
HttpContext )
.) *
Request* 1
.1 2
Path2 6
}6 7
$str7 8
{8 9
result9 ?
}? @
"@ A
,A B
newC F
{G H
}I J
)J K
;K L
} 	
[   	
HttpGet  	 
(   
$str   
)   
]   
[!! 	 
ProducesResponseType!!	 
(!! 
StatusCodes!! )
.!!) *
Status200OK!!* 5
,!!5 6
Type!!7 ;
=!!< =
typeof!!> D
(!!D E
AuthorResponseDto!!E V
)!!V W
)!!W X
]!!X Y
["" 	 
ProducesResponseType""	 
("" 
StatusCodes"" )
."") *
Status404NotFound""* ;
)""; <
]""< =
public## 
async## 
Task## 
<## 
IActionResult## '
>##' (
GetById##) 0
(##0 1
[##1 2
Required##2 :
]##: ;
Guid##< @
id##A C
,##C D
CancellationToken##E V
cancellationToken##W h
=##i j
default##k r
)##r s
{$$ 	
var%% 
result%% 
=%% 
await%% 
	_services%% (
.%%( )
GetById%%) 0
(%%0 1
id%%1 3
,%%3 4
cancellationToken%%5 F
)%%F G
;%%G H
if'' 
('' 
result'' 
is'' 
null'' 
)'' 
return(( 
NotFound(( 
(((  
)((  !
;((! "
return** 
Ok** 
(** 
result** 
)** 
;** 
}++ 	
[-- 	
HttpGet--	 
]-- 
[.. 	 
ProducesResponseType..	 
(.. 
StatusCodes.. )
...) *
Status200OK..* 5
,..5 6
Type..7 ;
=..< =
typeof..> D
(..D E
IEnumerable..E P
<..P Q
AuthorResponseDto..Q b
>..b c
)..c d
)..d e
]..e f
public// 
async// 
Task// 
<// 
IActionResult// '
>//' (
Get//) ,
(//, -
[//- .
	FromQuery//. 7
]//7 8
PaginateRequest//9 H
paginate//I Q
,//Q R
[//S T
	FromQuery//T ]
]//] ^
AuthorQueryParamDto//_ r
model//s x
,//x y
CancellationToken	//z ã
cancellationToken
//å ù
=
//û ü
default
//† ß
)
//ß ®
{00 	
var11 
result11 
=11 
await11 
	_services11 (
.11( )
GetAll11) /
(11/ 0
paginate110 8
,118 9
model11: ?
,11? @
cancellationToken11A R
)11R S
;11S T
return33 
Ok33 
(33 
result33 
)33 
;33 
}44 	
[66 	

HttpDelete66	 
(66 
$str66 
)66 
]66 
[77 	 
ProducesResponseType77	 
(77 
StatusCodes77 )
.77) *
Status200OK77* 5
)775 6
]776 7
[88 	 
ProducesResponseType88	 
(88 
StatusCodes88 )
.88) *
Status404NotFound88* ;
)88; <
]88< =
[99 	 
ProducesResponseType99	 
(99 
StatusCodes99 )
.99) *
Status400BadRequest99* =
)99= >
]99> ?
public:: 
async:: 
Task:: 
<:: 
IActionResult:: '
>::' (
Remove::) /
(::/ 0
[::0 1
Required::1 9
]::9 :
Guid::; ?
id::@ B
,::B C
CancellationToken::D U
cancellationToken::V g
=::h i
default::j q
)::q r
{;; 	
var<< 
result<< 
=<< 
await<< 
	_services<< (
.<<( )
Remove<<) /
(<</ 0
id<<0 2
,<<2 3
cancellationToken<<4 E
)<<E F
;<<F G
if>> 
(>> 
!>> 
result>> 
)>> 
return?? 
NotFound?? 
(??  
)??  !
;??! "
returnAA 
OkAA 
(AA 
)AA 
;AA 
}BB 	
[DD 	
HttpPutDD	 
(DD 
$strDD 
)DD 
]DD 
[EE 	 
ProducesResponseTypeEE	 
(EE 
StatusCodesEE )
.EE) *
Status200OKEE* 5
)EE5 6
]EE6 7
[FF 	 
ProducesResponseTypeFF	 
(FF 
StatusCodesFF )
.FF) *
Status400BadRequestFF* =
)FF= >
]FF> ?
[GG 	 
ProducesResponseTypeGG	 
(GG 
StatusCodesGG )
.GG) *
Status404NotFoundGG* ;
)GG; <
]GG< =
publicHH 
asyncHH 
TaskHH 
<HH 
IActionResultHH '
>HH' (
UpdateHH) /
(HH/ 0
[HH0 1
RequiredHH1 9
]HH9 :
GuidHH; ?
idHH@ B
,HHB C
[HHD E
RequiredHHE M
]HHM N
AuthorRequestDtoHHO _
modelHH` e
,HHe f
CancellationTokenHHg x
cancellationToken	HHy ä
=
HHã å
default
HHç î
)
HHî ï
{II 	
varJJ 
resultJJ 
=JJ 
awaitJJ 
	_servicesJJ (
.JJ( )
UpdateJJ) /
(JJ/ 0
idJJ0 2
,JJ2 3
modelJJ4 9
,JJ9 :
cancellationTokenJJ; L
)JJL M
;JJM N
ifLL 
(LL 
!LL 
resultLL 
)LL 
returnMM 
NotFoundMM 
(MM  
)MM  !
;MM! "
returnOO 
OkOO 
(OO 
)OO 
;OO 
}PP 	
}QQ 
}RR í?
[C:\Users\patrick.amorim\source\repos\Library\src\Library.Api\Controllers\BooksController.cs
	namespace 	
Library
 
. 
Api 
. 
Controllers !
;! "
[		 

ApiVersion		 
(		 
$str		 
)		 
]		 
[

 
Route

 
(

 
$str

 /
)

/ 0
]

0 1
[ 
ApiController 
] 
public 
class 
BooksController 
: 
ControllerBase -
{ 
private 
readonly 
IBookServices "
	_services# ,
;, -
public 

BooksController 
( 
IBookServices (
services) 1
)1 2
=>3 5
	_services 
= 
services 
; 
[ 
HttpPost 
] 
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status200OK& 1
)1 2
]2 3
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status400BadRequest& 9
)9 :
]: ;
public 

async 
Task 
< 
IActionResult #
># $
Post% )
() *
[* +
FromBody+ 3
]3 4
BookRequestDto5 C
modelD I
)I J
{ 
var 
result 
= 
await 
	_services $
.$ %
Create% +
(+ ,
model, 1
)1 2
;2 3
if 

( 
! 
result 
. 
HasValue 
) 
return 

BadRequest 
( 
) 
;  
return 
Created 
( 
$" 
{ 
HttpContext %
.% &
Request& -
.- .
Path. 2
}2 3
$str3 4
{4 5
result5 ;
}; <
"< =
,= >
new? B
{C D
}E F
)F G
;G H
} 
[   
HttpGet   
(   
$str   
)   
]   
[!!  
ProducesResponseType!! 
(!! 
StatusCodes!! %
.!!% &
Status200OK!!& 1
,!!1 2
Type!!3 7
=!!8 9
typeof!!: @
(!!@ A
BookResponseDto!!A P
)!!P Q
)!!Q R
]!!R S
[""  
ProducesResponseType"" 
("" 
StatusCodes"" %
.""% &
Status404NotFound""& 7
)""7 8
]""8 9
public## 

async## 
Task## 
<## 
IActionResult## #
>### $
GetById##% ,
(##, -
[##- .
Required##. 6
]##6 7
Guid##8 <
id##= ?
)##? @
{$$ 
var%% 
result%% 
=%% 
await%% 
	_services%% $
.%%$ %
GetById%%% ,
(%%, -
id%%- /
)%%/ 0
;%%0 1
if'' 

('' 
result'' 
is'' 
null'' 
)'' 
return(( 
NotFound(( 
((( 
)(( 
;(( 
return** 
Ok** 
(** 
result** 
)** 
;** 
}++ 
[-- 
HttpGet-- 
]-- 
[..  
ProducesResponseType.. 
(.. 
StatusCodes.. %
...% &
Status200OK..& 1
,..1 2
Type..3 7
=..8 9
typeof..: @
(..@ A
IEnumerable..A L
<..L M
BookResponseDto..M \
>..\ ]
)..] ^
)..^ _
].._ `
public// 

async// 
Task// 
<// 
IActionResult// #
>//# $
Get//% (
(//( )
[//) *
	FromQuery//* 3
]//3 4
PaginateRequest//5 D
paginate//E M
,//M N
[//O P
	FromQuery//P Y
]//Y Z
BookQueryParamDto//[ l
model//m r
,//r s
CancellationToken	//t Ö
cancellationToken
//Ü ó
=
//ò ô
default
//ö °
)
//° ¢
{00 
var11 
result11 
=11 
await11 
	_services11 $
.11$ %
GetAll11% +
(11+ ,
paginate11, 4
,114 5
model116 ;
,11; <
cancellationToken11= N
)11N O
;11O P
return33 
Ok33 
(33 
result33 
)33 
;33 
}44 
[66 

HttpDelete66 
(66 
$str66 
)66 
]66 
[77  
ProducesResponseType77 
(77 
StatusCodes77 %
.77% &
Status200OK77& 1
)771 2
]772 3
[88  
ProducesResponseType88 
(88 
StatusCodes88 %
.88% &
Status404NotFound88& 7
)887 8
]888 9
[99  
ProducesResponseType99 
(99 
StatusCodes99 %
.99% &
Status400BadRequest99& 9
)999 :
]99: ;
public:: 

async:: 
Task:: 
<:: 
IActionResult:: #
>::# $
Remove::% +
(::+ ,
[::, -
Required::- 5
]::5 6
Guid::7 ;
id::< >
,::> ?
CancellationToken::@ Q
cancellationToken::R c
=::d e
default::f m
)::m n
{;; 
var<< 
result<< 
=<< 
await<< 
	_services<< $
.<<$ %
Remove<<% +
(<<+ ,
id<<, .
,<<. /
cancellationToken<<0 A
)<<A B
;<<B C
if>> 

(>> 
!>> 
result>> 
)>> 
return?? 
NotFound?? 
(?? 
)?? 
;?? 
returnAA 
OkAA 
(AA 
)AA 
;AA 
}BB 
[DD 
HttpPutDD 
(DD 
$strDD 
)DD 
]DD 
[EE  
ProducesResponseTypeEE 
(EE 
StatusCodesEE %
.EE% &
Status200OKEE& 1
)EE1 2
]EE2 3
[FF  
ProducesResponseTypeFF 
(FF 
StatusCodesFF %
.FF% &
Status400BadRequestFF& 9
)FF9 :
]FF: ;
[GG  
ProducesResponseTypeGG 
(GG 
StatusCodesGG %
.GG% &
Status404NotFoundGG& 7
)GG7 8
]GG8 9
publicHH 

asyncHH 
TaskHH 
<HH 
IActionResultHH #
>HH# $
UpdateHH% +
(HH+ ,
[HH, -
RequiredHH- 5
]HH5 6
GuidHH7 ;
idHH< >
,HH> ?
[HH@ A
RequiredHHA I
]HHI J
BookRequestDtoHHK Y
modelHHZ _
,HH_ `
CancellationTokenHHa r
cancellationToken	HHs Ñ
=
HHÖ Ü
default
HHá é
)
HHé è
{II 
varJJ 
resultJJ 
=JJ 
awaitJJ 
	_servicesJJ $
.JJ$ %
UpdateJJ% +
(JJ+ ,
idJJ, .
,JJ. /
modelJJ0 5
,JJ5 6
cancellationTokenJJ7 H
)JJH I
;JJI J
ifLL 

(LL 
!LL 
resultLL 
)LL 
returnMM 
NotFoundMM 
(MM 
)MM 
;MM 
returnOO 
OkOO 
(OO 
)OO 
;OO 
}PP 
}QQ ª
\C:\Users\patrick.amorim\source\repos\Library\src\Library.Api\Controllers\HealthController.cs
	namespace 	
Library
 
. 
Api 
. 
Controllers !
;! "
[ 
Route 
( 
$str 
) 
] 
[ 
ApiController 
] 
[		 
ApiVersionNeutral		 
]		 
public

 
class

 
HealthController

 
:

 
ControllerBase

  .
{ 
private 
readonly 
HealthCheckService '
_healthCheckService( ;
;; <
public 

HealthController 
( 
HealthCheckService .
healthCheckService/ A
)A B
=>C E
_healthCheckService 
= 
healthCheckService 0
;0 1
[ 
HttpGet 
] 
public 

async 
Task 
< 
IActionResult #
># $
Get% (
(( )
CancellationToken) :
cancellationToken; L
=M N
defaultO V
)V W
{ 
var 
checkHealth 
= 
await 
_healthCheckService  3
.3 4
CheckHealthAsync4 D
(D E
cancellationTokenE V
)V W
;W X
var 
data 
= 
new 
{ 	
status 
= 
checkHealth  
.  !
Status! '
.' (
ToString( 0
(0 1
)1 2
,2 3
details 
= 
checkHealth !
.! "
Entries" )
.) *
Select* 0
(0 1
x1 2
=>3 5
new 
{ 
name 
= 
x 
. 
Key  
,  !
status 
= 
x 
. 
Value $
.$ %
Status% +
.+ ,
ToString, 4
(4 5
)5 6
,6 7
description 
=  !
x" #
.# $
Value$ )
.) *
Description* 5
} 
) 
}   	
;  	 

if"" 

("" 
checkHealth"" 
."" 
Status"" 
=="" !
HealthStatus""" .
."". /
Healthy""/ 6
)""6 7
{## 	
return$$ 
Ok$$ 
($$ 
data$$ 
)$$ 
;$$ 
}%% 	
else&& 
{'' 	
var(( 
serviceUnavailable(( "
=((# $
new((% (
ObjectResult(() 5
(((5 6
data((6 :
)((: ;
{)) 

StatusCode** 
=** 
(** 
int** !
)**! "
HttpStatusCode**" 0
.**0 1
ServiceUnavailable**1 C
}++ 
;++ 
return-- 
serviceUnavailable-- %
;--% &
}.. 	
}// 
}00 ◊?
YC:\Users\patrick.amorim\source\repos\Library\src\Library.Api\Filter\NotificationFilter.cs
	namespace 	
Library
 
. 
Api 
. 
Filter 
; 
public		 
class		 
NotificationFilter		 
:		  !
IAsyncResultFilter		" 4
{

 
private 
readonly 
NotificationContext ( 
_notificationContext) =
;= >
public 

NotificationFilter 
( 
NotificationContext 1
notificationContext2 E
)E F
{  
_notificationContext 
= 
notificationContext 2
;2 3
} 
public 

async 
Task "
OnResultExecutionAsync ,
(, -"
ResultExecutingContext- C
contextD K
,K L#
ResultExecutionDelegateM d
nexte i
)i j
{ 
if 

( 
! 
context 
. 

ModelState 
.  
IsValid  '
)' (
{ 	
var 
ErrorsTuple 
= 
new !
List" &
<& '
Tuple' ,
<, -
string- 3
,3 4
string5 ;
>; <
>< =
(= >
)> ?
;? @
foreach 
( 
var 
key 
in 
context  '
.' (

ModelState( 2
.2 3
Keys3 7
)7 8
{ 
var 

modelState 
=  
context! (
.( )

ModelState) 3
[3 4
key4 7
]7 8
;8 9
if 
( 

modelState 
is !
not" %
null& *
)* +
{ 
ErrorsTuple 
.  
Add  #
(# $
new$ '
(' (
key( +
,+ ,
string- 3
.3 4
Join4 8
(8 9
$char9 <
,< =

modelState> H
.H I
ErrorsI O
.O P
SelectP V
(V W
cW X
=>Y [
c\ ]
.] ^
ErrorMessage^ j
)j k
)k l
)l m
)m n
;n o
} 
}   
var"" 
errors"" 
="" 
ErrorsTuple"" $
.""$ %
Select""% +
(""+ ,
c"", -
=>"". 0
new""1 4
{## 
Title$$ 
=$$ 
c$$ 
.$$ 
Item1$$ 
,$$  
Detail%% 
=%% 
c%% 
.%% 
Item2%%  
}&& 
)&& 
.&& 
ToList&& 
(&& 
)&& 
;&& 
var(( 
result(( 
=(( 
BuildResponseObject(( ,
(((, -
context((- 4
.((4 5
HttpContext((5 @
.((@ A
Request((A H
?((H I
.((I J
Path((J N
.((N O
Value((O T
??((U W
$str((X Z
,((Z [
context((\ c
.((c d
HttpContext((d o
.((o p
TraceIdentifier((p 
,	(( Ä
errors
((Å á
)
((á à
;
((à â
var** 
content** 
=** 
SerializeResponse** +
(**+ ,
result**, 2
)**2 3
;**3 4
await,,  
BuildResponseContext,, &
(,,& '
context,,' .
,,,. /
content,,0 7
),,7 8
;,,8 9
return.. 
;.. 
}// 	
if11 

(11  
_notificationContext11  
.11  !
HasNotifications11! 1
)111 2
{22 	
var33 
errors33 
=33  
_notificationContext33 -
.33- .
Notifications33. ;
.33; <
Select33< B
(33B C
c33C D
=>33E G
new33H K
{44 
Title55 
=55 
c55 
.55 
Key55 
,55 
Detail66 
=66 
c66 
.66 
Message66 "
}77 
)77 
.77 
ToList77 
(77 
)77 
;77 
var99 
result99 
=99 
BuildResponseObject99 ,
(99, -
context99- 4
.994 5
HttpContext995 @
.99@ A
Request99A H
?99H I
.99I J
Path99J N
.99N O
Value99O T
??99U W
$str99X Z
,99Z [
context99\ c
.99c d
HttpContext99d o
.99o p
TraceIdentifier99p 
,	99 Ä
errors
99Å á
)
99á à
;
99à â
var;; 
content;; 
=;; 
SerializeResponse;; +
(;;+ ,
result;;, 2
);;2 3
;;;3 4
await==  
BuildResponseContext== &
(==& '
context==' .
,==. /
content==0 7
)==7 8
;==8 9
return?? 
;?? 
}@@ 	
awaitBB 
nextBB 
(BB 
)BB 
;BB 
}CC 
privateEE 
staticEE 
stringEE 
SerializeResponseEE +
(EE+ ,
objectEE, 2
resultEE3 9
)EE9 :
{FF 
varGG 
optionsGG 
=GG 
newGG !
JsonSerializerOptionsGG /
{HH 	"
DefaultIgnoreConditionII "
=II# $
JsonIgnoreConditionII% 8
.II8 9
WhenWritingNullII9 H
,IIH I 
PropertyNamingPolicyJJ  
=JJ! "
JsonNamingPolicyJJ# 3
.JJ3 4
	CamelCaseJJ4 =
}KK 	
;KK	 

returnMM 
JsonSerializerMM 
.MM 
	SerializeMM '
(MM' (
resultMM( .
,MM. /
optionsMM0 7
)MM7 8
;MM8 9
}NN 
privatePP 
staticPP 
asyncPP 
TaskPP  
BuildResponseContextPP 2
(PP2 3"
ResultExecutingContextPP3 I
contextPPJ Q
,PPQ R
stringPPS Y
contentPPZ a
)PPa b
{QQ 
contextRR 
.RR 
HttpContextRR 
.RR 
ResponseRR $
.RR$ %

StatusCodeRR% /
=RR0 1
(RR2 3
intRR3 6
)RR6 7
HttpStatusCodeRR7 E
.RRE F

BadRequestRRF P
;RRP Q
contextSS 
.SS 
HttpContextSS 
.SS 
ResponseSS $
.SS$ %
ContentTypeSS% 0
=SS1 2
$strSS3 M
;SSM N
awaitTT 
contextTT 
.TT 
HttpContextTT !
.TT! "
ResponseTT" *
.TT* +

WriteAsyncTT+ 5
(TT5 6
contentTT6 =
)TT= >
;TT> ?
}UU 
privateWW 
staticWW 
objectWW 
BuildResponseObjectWW -
(WW- .
stringWW. 4
instanceWW5 =
,WW= >
stringWW? E
traceIdentifierWWF U
,WWU V
IEnumerableWWW b
<WWb c
objectWWc i
>WWi j
errorsWWk q
)WWq r
{XX 
returnYY 
newYY 
{ZZ 	
Status[[ 
=[[ 
([[ 
int[[ 
)[[ 
HttpStatusCode[[ (
.[[( )

BadRequest[[) 3
,[[3 4
Type\\ 
=\\ 
$str\\ @
,\\@ A
Instance]] 
=]] 
instance]] 
,]]  
TraceId^^ 
=^^ 
traceIdentifier^^ %
,^^% &
Errors__ 
=__ 
errors__ 
}`` 	
;``	 

}aa 
}bb ™!
GC:\Users\patrick.amorim\source\repos\Library\src\Library.Api\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1

AppContext

 

.


 
	SetSwitch

 
(

 
$str

 ;
,

; <
true

= A
)

A B
;

B C
builder 
. 
Services 
. 
AddControllers 
(  
)  !
;! "
builder 
. 
Services 
. #
AddEndpointsApiExplorer (
(( )
)) *
;* +
builder 
. 
Services 
. 
AddSwaggerGen 
( 
)  
;  !
builder 
. 
Services 
. 
AddApiVersioning !
(! "
opt" %
=>& (
{ 
opt 
. 
DefaultApiVersion 
= 
new 

ApiVersion  *
(* +
$num+ ,
,, -
$num. /
)/ 0
;0 1
opt 
. /
#AssumeDefaultVersionWhenUnspecified +
=, -
true. 2
;2 3
opt 
. 
ReportApiVersions 
= 
true  
;  !
} 
) 
; 
builder 
. 
Services 
. #
AddVersionedApiExplorer (
(( )
setup) .
=>/ 1
{ 
setup 	
.	 

GroupNameFormat
 
= 
$str $
;$ %
setup 	
.	 
%
SubstituteApiVersionInUrl
 #
=$ %
true& *
;* +
} 
) 
; 
builder   
.   
Services   
.    
ConfigureApplication   %
(  % &
)  & '
;  ' (
builder!! 
.!! 
Services!! 
.!! 
ConfigureData!! 
(!! 
builder!! &
.!!& '
Configuration!!' 4
)!!4 5
;!!5 6
builder"" 
."" 
Services"" 
."" #
ConfigureInfrastructure"" (
(""( )
)"") *
;""* +
builder## 
.## 
Services## 
.## )
ConfigureInfrastructureWorker## .
(##. /
builder##/ 6
.##6 7
Configuration##7 D
)##D E
;##E F
builder%% 
.%% 
Services%% 
.%% 
AddMvc%% 
(%% 
options%% 
=>%%  "
options%%# *
.%%* +
Filters%%+ 2
.%%2 3
Add%%3 6
<%%6 7
NotificationFilter%%7 I
>%%I J
(%%J K
)%%K L
)%%L M
;%%M N
builder'' 
.'' 
Services'' 
.'' 
	Configure'' 
<'' 
RouteOptions'' '
>''' (
(''( )
options'') 0
=>''1 3
{(( 
options)) 
.)) 
LowercaseUrls)) 
=)) 
true))  
;))  !
}** 
)** 
;** 
var,, 
app,, 
=,, 	
builder,,
 
.,, 
Build,, 
(,, 
),, 
;,, 
if// 
(// 
app// 
.// 
Environment// 
.// 
IsDevelopment// !
(//! "
)//" #
)//# $
{00 
app11 
.11 

UseSwagger11 
(11 
)11 
;11 
app22 
.22 
UseSwaggerUI22 
(22 
)22 
;22 
}33 
app55 
.55 
MapControllers55 
(55 
)55 
;55 
app77 
.77 
UseHttpsRedirection77 
(77 
)77 
;77 
app99 
.99 
Run99 
(99 
)99 	
;99	 
