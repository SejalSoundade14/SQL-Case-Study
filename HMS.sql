create database h_m_s;
use h_m_s;
Create Table Guests(
    GuestID int primary key,
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(100),
    Phone varchar(20));

Create Table Rooms(
    RoomID int primary key,
    RoomNumber varchar(10),
    RoomType varchar(50),
    PricePerNight decimal(10, 2));

Create Table Bookings(
    BookingID int primary key,
    GuestID int,
    RoomID int,
    CheckInDate date,
    CheckOutDate date,
    Foreign Key (GuestID) References Guests(GuestID),
    Foreign Key (RoomID) References Rooms(RoomID));

Create Table Services(
    ServiceID int primary Key,
    ServiceName varchar(100),
    Price decimal(10, 2));

Create Table BookingServices(
    BookingServiceID int primary key,
    BookingID int,
    ServiceID int,
    Quantity int,
    Foreign Key (BookingID) References Bookings(BookingID),
    Foreign Key (ServiceID) References Services(ServiceID));

Create Table Payments(
    PaymentID int primary Key,
    BookingID int,
    PaymentDate date,
    Amount decimal(10, 2),
    Foreign Key(BookingID) References Bookings(BookingID));
    insert into Guests(GuestID, FirstName, LastName, Email, Phone) 
    values(1, 'Daniel', 'Radcliffe', 'daniel.r@example.com', '555-1234'),
(2, 'Emma', 'Watson', 'emma.w@example.com', '222-5678'),
(3, 'Bonnie', 'Wright', 'bonnie.w@example.com', '555-8765'),
(4, 'Rupert', 'Grint', 'rupert.g@example.com', '555-4321'),
(5, 'Evanna', 'Lynch', 'evanna.l@example.com', '555-3456'),
(6, 'Tom', 'Felton', 'tom.f@example.com', '444-6543'),
(7, 'Maggie', 'Smith', 'maggie.s@example.com', '555-9876'),
(8, 'Matthew', 'Lewis', 'matthew.l@example.com', '555-5432'),
(9, 'Katie', 'Leung', 'katie.l@example.com', '555-2345'),
(10, 'Robert', 'Pattinson', 'robert.p@example.com', '555-6789');
select * from Guests;
insert into Rooms(RoomID, RoomNumber, RoomType, PricePerNight) 
values(1, '101', 'Single', 100),
(2, '102', 'Double', 150),
(3, '201', 'Suite', 250),
(4, '202', 'Suite', 275),
(5, '301', 'Single', 100),
(6, '302', 'Double', 160),
(7, '401', 'Suite', 300),
(8, '402', 'Single', 110),
(9, '501', 'Double', 140),
(10, '502', 'Suite', 320);
Select * from Rooms;
insert into Bookings(BookingID, GuestID, RoomID, CheckInDate, CheckOutDate) 
values(1, 1, 1, '2024-01-05', '2024-01-10'),
(2, 2, 2, '2024-02-01', '2024-02-05'),
(3, 3, 3, '2024-03-10', '2024-03-15'),
(4, 4, 4, '2024-04-01', '2024-04-10'),
(5, 5, 5, '2024-05-20', '2024-05-25'),
(6, 6, 6, '2024-06-15', '2024-06-20'),
(7, 7, 7, '2024-07-10', '2024-07-15'),
(8, 8, 8, '2024-08-01', '2024-08-07'),
(9, 9, 9, '2024-09-05', '2024-09-10'),
(10, 10, 10, '2024-10-10', '2024-10-15');
select * from Bookings;
insert into Services(ServiceID, ServiceName, Price) 
values(1, 'Room Service', 20),
(2, 'Spa', 100),
(3, 'Airport Pickup', 50),
(4, 'Laundry', 30),
(5, 'Breakfast', 15),
(6, 'Dinner', 40),
(7, 'Guided Tour', 75),
(8, 'Gym Access', 25),
(9, 'Massage', 60),
(10, 'Mini-Bar', 35);
Select * from Services;
insert into BookingServices(BookingServiceID, BookingID, ServiceID, Quantity) 
values(1, 1, 1, 2),
(2, 1, 5, 1),
(3, 2, 3, 1),
(4, 3, 2, 1),
(5, 4, 6, 1),
(6, 5, 4, 2),
(7, 6, 8, 1),
(8, 7, 7, 1),
(9, 8, 9, 1),
(10, 9, 10, 2);
select * from BookingServices;
insert into Payments(PaymentID, BookingID, PaymentDate, Amount) 
values(1, 1, '2024-01-10', 600),
(2, 2, '2024-02-05', 650),
(3, 3, '2024-03-15', 550),
(4, 4, '2024-04-10', 900),
(5, 5, '2024-05-25', 500),
(6, 6, '2024-06-20', 600),
(7, 7, '2024-07-15', 750),
(8, 8, '2024-08-07', 690),
(9, 9, '2024-09-10', 600),
(10, 10, '2024-10-15', 800);
select * from Payments;
select * from Bookings
where CheckOutDate > '2024-01-01';
select * from Guests
where phone like '555%' and email like '%example.com%';
select * from Rooms
where RoomType like '%Suite%';
select RoomNumber,
case
when PricePerNight > 200 then PricePerNight*0.8
else PricePerNight
end as DiscountedPrice
from Rooms;
select * from Guests
where GuestID in (Select GuestID from bookings
				 join Payments on Bookings.BookingID=Payments.BookingID
                 group by GuestID
                 Having sum(Amount)>500);
select RoomType, count(*) as TotalRoomsBooked
from Rooms
join Bookings on Rooms.RoomID = Bookings.RoomId
Group by RoomType;
select BookingID,sum(Amount) TotalAmount
from payments
group by BookingID
having sum(Amount) > 100;
select g.GuestID,sum(datediff(b.CheckOutDate,b.CheckInDate)) NumberOfNights
from Guests g
join Bookings b on g.GuestID = b.GuestID
group by g.GuestID
order by NumberOfNights desc
limit 5;
select Firstname,Lastname,CheckInDate,CheckOutDate
from Guests g join Bookings b
on (g.GuestID = b.GuestID);
select r.RoomID,r.RoomNumber,r.RoomType,r.PricePerNight,b.BookingID,b.GuestID,b.CheckInDate,b.CheckOutDate
from Rooms r left join Bookings b
on r.RoomID=b.RoomID
order by r.RoomID,b.BookingID;
select r.RoomType, SUM(r.PricePerNight * DATEDIFF(b.CheckOutDate, b.CheckInDate)) AS TotalRevenue
from Rooms r
inner join Bookings b on r.RoomID = b.RoomID
group by r.RoomType;
select b.BookingID,b.GuestID
from Bookings b
join BookingServices bs on b.BookingID=bs.BookingID
join Services s on bs.ServiceID=s.ServiceID
where (select sum(bs.Quantity*s.Price))>(select avg(price) from services);
select r.RoomNumber,CONCAT(g.Firstname,' ',g.Lastname) GuestName,s.ServiceName
from Rooms r
join Bookings b on r.RoomID = b.RoomID
join Guests g on b.GuestID = g.GuestID
join BookingServices bs on b.BookingID = bs.BookingID
left join services s on bs.ServiceID = s.ServiceID
where bs.Quantity>0;