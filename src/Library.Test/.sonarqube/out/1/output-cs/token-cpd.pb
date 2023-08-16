Å
TC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Configure.cs
	namespace 	
Library
 
. 
Infrastructure  
;  !
public 
static 
class 
	Configure 
{ 
public		 

static		 
void		 #
ConfigureInfrastructure		 .
(		. /
this		/ 3
IServiceCollection		4 F
services		G O
)		O P
{

 
services 
. 
	AddScoped 
< 
DomainHandler (
>( )
() *
)* +
;+ ,
services 
. 

AddMediatR 
( 
cfg 
=>  "
cfg# &
.& '(
RegisterServicesFromAssembly' C
(C D
AssemblyD L
.L M 
GetExecutingAssemblyM a
(a b
)b c
)c d
)d e
;e f
} 
} 
wC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\EventHandler\Author\CreateAuthorEventHandler.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
EventHandler! -
.- .
Author. 4
;4 5
public

 
class

 $
CreateAuthorEventHandler

 %
:

& ' 
INotificationHandler

( <
<

< =
CreatedAuthorEvent

= O
>

O P
{ 
private 
readonly 
IBus 
_bus 
; 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
public 
$
CreateAuthorEventHandler #
(# $
IBus$ (
bus) ,
,, -
IConfiguration. <
configuration= J
)J K
{ 
_bus 
= 
bus 
; 
_configuration 
= 
configuration &
;& '
} 
public 

async 
Task 
Handle 
( 
CreatedAuthorEvent /
notification0 <
,< =
CancellationToken> O
cancellationTokenP a
)a b
{ 
var 
message 
= 
notification "
." #
Author# )
.) *
Adapt* /
</ 0
CreateAuthorMessage0 C
>C D
(D E
)E F
;F G
var 
queue 
= 
$" 
$str 
{ 
_configuration +
[+ ,
$str, H
]H I
}I J
"J K
;K L
var 
endpoint 
= 
await 
_bus !
.! "
GetSendEndpoint" 1
(1 2
new2 5
Uri6 9
(9 :
queue: ?
)? @
)@ A
;A B
await 
endpoint 
. 
Send 
( 
message #
,# $
cancellationToken% 6
)6 7
;7 8
} 
} ª
wC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\EventHandler\Author\RemoveAuthorEventHandler.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
EventHandler! -
.- .
Author. 4
;4 5
public		 
class		 $
RemoveAuthorEventHandler		 %
:		& ' 
INotificationHandler		( <
<		< =
RemoveAuthorEvent		= N
>		N O
{

 
private 
readonly 
IBus 
_bus 
; 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
public 
$
RemoveAuthorEventHandler #
(# $
IBus$ (
bus) ,
,, -
IConfiguration. <
configuration= J
)J K
{ 
_bus 
= 
bus 
; 
_configuration 
= 
configuration &
;& '
} 
public 

async 
Task 
Handle 
( 
RemoveAuthorEvent .
notification/ ;
,; <
CancellationToken= N
cancellationTokenO `
)` a
{ 
var 
message 
= 
new 
RemoveAuthorMessage -
(- .
notification. :
.: ;
Id; =
)= >
;> ?
var 
queue 
= 
$" 
$str 
{ 
_configuration +
[+ ,
$str, H
]H I
}I J
"J K
;K L
var 
endpoint 
= 
await 
_bus !
.! "
GetSendEndpoint" 1
(1 2
new2 5
Uri6 9
(9 :
queue: ?
)? @
)@ A
;A B
await 
endpoint 
. 
Send 
( 
message #
,# $
cancellationToken% 6
)6 7
;7 8
} 
} Ó
wC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\EventHandler\Author\UpdateAuthorEventHandler.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
EventHandler! -
.- .
Author. 4
;4 5
public

 
class

 $
UpdateAuthorEventHandler

 %
:

& ' 
INotificationHandler

( <
<

< =
UpdateAuthorEvent

= N
>

N O
{ 
private 
readonly 
IBus 
_bus 
; 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
public 
$
UpdateAuthorEventHandler #
(# $
IBus$ (
bus) ,
,, -
IConfiguration. <
configuration= J
)J K
{ 
_bus 
= 
bus 
; 
_configuration 
= 
configuration &
;& '
} 
public 

async 
Task 
Handle 
( 
UpdateAuthorEvent .
notification/ ;
,; <
CancellationToken= N
cancellationTokenO `
)` a
{ 
var 
message 
= 
notification "
." #
Author# )
.) *
Adapt* /
</ 0
UpdateAuthorMessage0 C
>C D
(D E
)E F
;F G
var 
queue 
= 
$" 
$str 
{ 
_configuration +
[+ ,
$str, H
]H I
}I J
"J K
;K L
var 
endpoint 
= 
await 
_bus !
.! "
GetSendEndpoint" 1
(1 2
new2 5
Uri6 9
(9 :
queue: ?
)? @
)@ A
;A B
await 
endpoint 
. 
Send 
( 
message #
,# $
cancellationToken% 6
)6 7
;7 8
} 
} ﬁ
sC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\EventHandler\Book\CreateBookEventHandler.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
EventHandler! -
.- .
Book. 2
;2 3
public

 
class

 "
CreateBookEventHandler

 #
:

$ % 
INotificationHandler

& :
<

: ;
CreatedBookEvent

; K
>

K L
{ 
private 
readonly 
IBus 
_bus 
; 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
public 
"
CreateBookEventHandler !
(! "
IBus" &
bus' *
,* +
IConfiguration, :
configuration; H
)H I
{ 
_bus 
= 
bus 
; 
_configuration 
= 
configuration &
;& '
} 
public 

async 
Task 
Handle 
( 
CreatedBookEvent -
notification. :
,: ;
CancellationToken< M
cancellationTokenN _
)_ `
{ 
var 
message 
= 
notification "
." #
Book# '
.' (
Adapt( -
<- .
CreateBookMessage. ?
>? @
(@ A
)A B
;B C
var 
queue 
= 
$" 
$str 
{ 
_configuration +
[+ ,
$str, F
]F G
}G H
"H I
;I J
var 
endpoint 
= 
await 
_bus !
.! "
GetSendEndpoint" 1
(1 2
new2 5
Uri6 9
(9 :
queue: ?
)? @
)@ A
;A B
await 
endpoint 
. 
Send 
( 
message #
,# $
cancellationToken% 6
)6 7
;7 8
} 
} ´
sC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\EventHandler\Book\RemoveBookEventHandler.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
EventHandler! -
.- .
Book. 2
;2 3
public		 
class		 "
RemoveBookEventHandler		 #
:		$ % 
INotificationHandler		& :
<		: ;
RemoveBookEvent		; J
>		J K
{

 
private 
readonly 
IBus 
_bus 
; 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
public 
"
RemoveBookEventHandler !
(! "
IBus" &
bus' *
,* +
IConfiguration, :
configuration; H
)H I
{ 
_bus 
= 
bus 
; 
_configuration 
= 
configuration &
;& '
} 
public 

async 
Task 
Handle 
( 
RemoveBookEvent ,
notification- 9
,9 :
CancellationToken; L
cancellationTokenM ^
)^ _
{ 
var 
message 
= 
new 
RemoveBookMessage +
(+ ,
notification, 8
.8 9
Id9 ;
); <
;< =
var 
queue 
= 
$" 
$str 
{ 
_configuration +
[+ ,
$str, F
]F G
}G H
"H I
;I J
var 
endpoint 
= 
await 
_bus !
.! "
GetSendEndpoint" 1
(1 2
new2 5
Uri6 9
(9 :
queue: ?
)? @
)@ A
;A B
await 
endpoint 
. 
Send 
( 
message #
,# $
cancellationToken% 6
)6 7
;7 8
} 
} ‹
sC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\EventHandler\Book\UpdateBookEventHandler.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
EventHandler! -
.- .
Book. 2
;2 3
public

 
class

 "
UpdateBookEventHandler

 #
:

$ % 
INotificationHandler

& :
<

: ;
UpdateBookEvent

; J
>

J K
{ 
private 
readonly 
IBus 
_bus 
; 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
public 
"
UpdateBookEventHandler !
(! "
IBus" &
bus' *
,* +
IConfiguration, :
configuration; H
)H I
{ 
_bus 
= 
bus 
; 
_configuration 
= 
configuration &
;& '
} 
public 

async 
Task 
Handle 
( 
UpdateBookEvent ,
notification- 9
,9 :
CancellationToken; L
cancellationTokenM ^
)^ _
{ 
var 
message 
= 
notification "
." #
Book# '
.' (
Adapt( -
<- .
UpdateBookMessage. ?
>? @
(@ A
)A B
;B C
var 
queue 
= 
$" 
$str 
{ 
_configuration +
[+ ,
$str, F
]F G
}G H
"H I
;I J
var 
endpoint 
= 
await 
_bus !
.! "
GetSendEndpoint" 1
(1 2
new2 5
Uri6 9
(9 :
queue: ?
)? @
)@ A
;A B
await 
endpoint 
. 
Send 
( 
message #
,# $
cancellationToken% 6
)6 7
;7 8
} 
} Ø
jC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Author\CreatedAuthorEvent.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
CreatedAuthorEvent' 9
;9 :
public 
class 
CreatedAuthorEvent 
:  !
DomainEvent" -
{ 
public 

Domain 
. 
Model 
. 
Author 
Author %
{& '
get( +
;+ ,
private- 4
set5 8
;8 9
}: ;
public		 

CreatedAuthorEvent		 
(		 
Domain		 $
.		$ %
Model		% *
.		* +
Author		+ 1
author		2 8
)		8 9
{

 
Author 
= 
author 
; 
} 
public 

CreatedAuthorEvent 
( 
) 
{ 
} 
} Å
iC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Author\RemoveAuthorEvent.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
Author' -
;- .
public 
class 
RemoveAuthorEvent 
:  
DomainEvent! ,
{ 
public 

Guid 
Id 
{ 
get 
; 
private !
set" %
;% &
}' (
public		 

RemoveAuthorEvent		 
(		 
Guid		 !
id		" $
)		$ %
{

 
Id 

= 
id 
; 
} 
public 

RemoveAuthorEvent 
( 
) 
{ 
} 
} ü
iC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Author\UpdateAuthorEvent.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
Author' -
;- .
public 
class 
UpdateAuthorEvent 
:  
DomainEvent! ,
{ 
public 

Domain 
. 
Model 
. 
Author 
Author %
{& '
get( +
;+ ,
private- 4
set5 8
;8 9
}: ;
public		 

UpdateAuthorEvent		 
(		 
Domain		 #
.		# $
Model		$ )
.		) *
Author		* 0
author		1 7
)		7 8
{

 
Author 
= 
author 
; 
} 
public 

UpdateAuthorEvent 
( 
) 
{ 
} 
} ˜
aC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Base\DomainEvent.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
Base' +
;+ ,
public 
abstract 
class 
DomainEvent !
:" #
INotification$ 1
{ 
public 

DateTime 
	Timestamp 
{ 
get  #
;# $
private% ,
set- 0
;0 1
}2 3
public 

virtual 
Guid 
EventId 
{  !
get" %
;% &
private' .
set/ 2
;2 3
}4 5
	protected

 
DomainEvent

 
(

 
)

 
{ 
EventId 
= 
Guid 
. 
NewGuid 
( 
)  
;  !
	Timestamp 
= 
DateTime 
. 
Now  
;  !
} 
} ‰
cC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Base\DomainHandler.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
Base' +
;+ ,
public 
class 
DomainHandler 
{ 
private 
readonly 
List 
< 
DomainEvent %
>% &
_domainEvents' 4
;4 5
public 

IReadOnlyCollection 
< 
DomainEvent *
>* +
DomainEvents, 8
=>9 ;
_domainEvents< I
.I J

AsReadOnlyJ T
(T U
)U V
;V W
public		 

DomainHandler		 
(		 
)		 
{

 
_domainEvents 
= 
_domainEvents %
??& (
new) ,
List- 1
<1 2
DomainEvent2 =
>= >
(> ?
)? @
;@ A
} 
public 

virtual 
void 
AddEvent  
(  !
DomainEvent! ,
@event- 3
)3 4
{ 
if 

( 
@event 
!= 
null 
) 
_domainEvents 
. 
Add 
( 
@event $
)$ %
;% &
} 
public 

virtual 
void 
ClearEvents #
(# $
)$ %
{ 
_domainEvents 
. 
Clear 
( 
) 
; 
} 
} ù
fC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Book\CreatedBookEvent.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
Book' +
;+ ,
public 
class 
CreatedBookEvent 
: 
DomainEvent  +
{ 
public 

Domain 
. 
Model 
. 
Book 
Book !
{" #
get$ '
;' (
private) 0
set1 4
;4 5
}6 7
public		 

CreatedBookEvent		 
(		 
Domain		 "
.		" #
Model		# (
.		( )
Book		) -
book		. 2
)		2 3
{

 
Book 
= 
book 
; 
} 
} ı
eC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Book\RemoveBookEvent.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
Book' +
;+ ,
public 
class 
RemoveBookEvent 
: 
DomainEvent *
{ 
public 

Guid 
Id 
{ 
get 
; 
private !
set" %
;% &
}' (
public 

RemoveBookEvent 
( 
Guid 
id  "
)" #
{		 
Id

 

=

 
id

 
;

 
} 
public 

RemoveBookEvent 
( 
) 
{ 
} 
} ö
eC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Event\Book\UpdateBookEvent.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Event! &
.& '
Book' +
;+ ,
public 
class 
UpdateBookEvent 
: 
DomainEvent *
{ 
public 

Domain 
. 
Model 
. 
Book 
Book !
{" #
get$ '
;' (
private) 0
set1 4
;4 5
}6 7
public		 

UpdateBookEvent		 
(		 
Domain		 !
.		! "
Model		" '
.		' (
Book		( ,
book		- 1
)		1 2
{

 
Book 
= 
book 
; 
} 
} ã	
cC:\Users\patrick.amorim\source\repos\Library\src\Library.Infrastructure\Helper\MediatorExtension.cs
	namespace 	
Library
 
. 
Infrastructure  
.  !
Helper! '
;' (
public 
static 
class 
MediatorExtension %
{ 
public 

static 
async 
Task  
DispatchDomainEvents 1
(1 2
this2 6
	IMediator7 @
	_mediatorA J
,J K
IEnumerableL W
<W X
DomainEventX c
>c d
eventse k
,k l
CancellationTokenm ~
cancellationToken	 ê
=
ë í
default
ì ö
)
ö õ
{		 
foreach

 
(

 
var

 
@event

 
in

 
events

 %
)

% &
{ 	
await 
	_mediator 
. 
Publish #
(# $
@event$ *
,* +
cancellationToken, =
)= >
;> ?
} 	
} 
} 