use master
go
drop  database ATM
go
Create database ATM
go
use ATM
go

create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null
)
create table [Transactiontype](
transtypeId int primary key,
transtypename varchar(25) ,
Descriptionn varchar(30) 

)

INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (1, N'Ali', N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (2, N'Ahmed', N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (3, N'Aqeel', N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (4, N'Usman', N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (5, N'Hafeez', N'03036061000', N'Lahore')
GO


INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1234')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1235')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'1236')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'1238')
GO
Insert  [dbo].[UserCard] ([userID], [cardNum]) VALUES (4, N'1237')

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO


Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
 

 create view userview
  as
 Select * from [User];

 select * from userview




 create view usersWHOownscard
  as
  select u.name,u.phoneNum,u.city,c.cardnum from [User] as u join [UserCard] as c on u.userId=c.userID;

  select * from usersWHOownscard

  create procedure dbo.usershow
  @nam varchar (25)
  as
  begin
   select * from [User]
   where name=@nam
  end
  execute
  dbo.usershow @nam='Ali'

   create view lilbal
  as select min(balance) as minimumbal from [card]

  drop procedure minini
  create procedure minini

  @ouputpara float output
  as
 
 begin
  select @ouputpara=min(balance)  from [card]
  end

  declare @minbal float
  exec minini
  @ouputpara=@minbal output

  select @minbal as minimumbalance


  drop procedure dbo.usrcards

   create procedure dbo.usrcards
 @cou int output,
  @nam varchar(25)
  as
  begin
  select @cou=count(c.[userid])  from [User] as u join [UserCard] as c on u.userId=c.userID
  where u.name=@nam
  end
  declare @outi int
  execute
  dbo.usrcards @nam='Ali',
  @cou=@outi output

  select @outi as NOofCARDS

 
  drop procedure statusret
  create procedure statusret
  @cardno varchar(20),
  @pincheck varchar(4),
  @status int output
  as
  begin
   if exists(
       select *  from [card]
       where cardNum=@cardno and pin=@pincheck
     )  
   begin

         set @status=1
return;
        end
       else
        begin

         set @status=0
return ;
        end
   end
 

 
  declare @outiu int
  execute
  dbo.statusret @cardno='1235',
  @pincheck='9234',
  @status=@outiu output

  select @outiu as active



  create procedure updatataion
   @cardno varchar(20),
  @pincheck varchar(4),
  @newpin varchar(4)
  as
  begin
    if exists(
     select *  from [card]
         where cardNum=@cardno and pin=@pincheck
     )
    begin
      update [card]
      set pin=@newpin
 where cardNum=@cardno and pin=@pincheck;
 print 'PIN HAS BEEN UPDATED';
end
else
begin
print 'NO USER FOUND'
end
  end

  execute
   dbo.updatataion @cardno='1235',
  @pincheck='9234',
  @newpin='2232'

  select * from [card]
  select * from [Transaction]
  select * from [Transactiontype]

  insert into [Transactiontype] values(1,'SUCCESSFULL','AMOUNT TRANSACTED SUCCESFULLY')

   drop procedure withdraw
   create procedure withdraw
  @cardno varchar(20),
  @pincheck varchar(4),
  @amount int,
  @treans int output,
  @trnsdate date,
  @typetans int output
  as
  begin
   if exists(
       select *  from [card]
       where cardNum=@cardno and pin=@pincheck
     )  
   begin
     select @treans=max(transId) from [Transaction];
	 set @treans=@treans+1;
     insert into [Transaction] values(@treans,@trnsdate,@cardno,@amount);
	 print 'TRANSACTION SUCCESSFULL';
	 select @typetans=max(transtypeid) from [Transactiontype];
	 insert into [Transactiontype] values (@typetans,'SUCCESSFULL','AMOUNT TRANSACTED SUCCESFULLY')
       
return;
        end
       else
        begin
		select @typetans=max(transtypeid) from [Transactiontype];
		 insert into [Transactiontype] values (@typetans,'FAILED','TRANSACTION FAILED')
		print 'TRANSACTION FAILED';
       
return ;
        end
   end
     declare @outiua int,@joini int
   execute 
  dbo.withdraw @cardno='1235',
  @pincheck='2232',
  @amount=300,
  @treans=@outiua output,
  @trnsdate= '07-12-2020',
  @typetans=@joini output;
   select @outiua,@joini AS pew
