/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 
*/
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab05_QLTour
go

use Lab05_QLTour
go

create table Tour
(MaTour char(4) primary key,
TongSoNgay int check(TongSoNgay > 0)
)
go
create table ThanhPho
(MaTP char(2) primary key,
TenTP nvarchar(30) not null unique
)
go
create table Tour_TP
(MaTour char(4) references Tour(MaTour),
MaTP char(2) references ThanhPho(MaTP),
SoNgay int check(SoNgay > 0)
primary key(MaTour, MaTP, SoNgay)
)
go
create table Lich_TourDL
(MaTour char(4) references Tour(MaTour),
NgayKH datetime,
TenHDV nvarchar(30) not null,
SoNguoi int check(SoNguoi > 0),
TenKH nvarchar(30) not null
primary key(MaTour, NgayKH)
)
-------------NHAP DU LIEU CHO CAC BANG-----------
insert into Tour values ('T001', 3);
insert into Tour values ('T002', 4);
insert into Tour values ('T003', 5);
insert into Tour values ('T004', 7);
select * from Tour;

insert into ThanhPho values ('01', N'Đà Lạt');
insert into ThanhPho values ('02', N'Nha Trang');
insert into ThanhPho values ('03', N'Phan Thiết');
insert into ThanhPho values ('04', N'Huế');
insert into ThanhPho values ('05', N'Đà Nẵng');
select * from ThanhPho;

insert into Tour_TP values ('T001', '01', 2);
insert into Tour_TP values ('T001', '03', 1);
insert into Tour_TP values ('T002', '01', 2);
insert into Tour_TP values ('T002', '02', 2);
insert into Tour_TP values ('T003', '02', 2);
insert into Tour_TP values ('T003', '01', 1);
insert into Tour_TP values ('T003', '04', 2);
insert into Tour_TP values ('T004', '02', 2);
insert into Tour_TP values ('T004', '05', 2);
insert into Tour_TP values ('T004', '04', 3);
select * from Tour_TP;

set dateformat dmy
go
insert into Lich_TourDL values ('T001', '14/02/2017', N'Vân', 20, N'Nguyễn Hoàng');
insert into Lich_TourDL values ('T002', '14/02/2017', N'Nam', 30, N'Lê Ngọc');
insert into Lich_TourDL values ('T002', '06/03/2017', N'Hùng', 20, N'Lý Dũng');
insert into Lich_TourDL values ('T003', '18/02/2017', N'Dũng', 20, N'Lý Dũng');
insert into Lich_TourDL values ('T004', '18/02/2017', N'Hùng', 30, N'Dũng Nam');
insert into Lich_TourDL values ('T003', '10/03/2017', N'Nam', 45, N'Nguyễn An');
insert into Lich_TourDL values ('T002', '28/04/2017', N'Vân', 25, N'Ngọc Dung');
insert into Lich_TourDL values ('T004', '29/04/2017', N'Dũng', 35, N'Lê Ngọc');
insert into Lich_TourDL values ('T001', '30/04/2017', N'Nam', 25, N'Trần Nam');
insert into Lich_TourDL values ('T003', '15/06/2017', N'Vân', 20, N'Trịnh Bá');
select * from Lich_TourDL;

select * from Tour
select * from ThanhPho
select * from Tour_TP
select * from Lich_TourDL
---------------------------HÀM & THỦ TỤC THÊM DỮ LIỆU VÀO BẢNG---------------------------
create proc usp_ThemTour @maTour char(5), @tongsongay tinyint
as
   if exists ( select * from dbo.Tour
                        where MaTour = @maTour)
						print N'Đã tồn tại trong danh sách Tour!'
   else
        begin
		      insert into dbo.Tour
			  values
			  (@maTour, -- MaTour - char(5)
			   @tongsongay -- TongSoNgay - tinyint
			   )
			     print N'Thêm tour thành công!'
		end

exec usp_ThemTour 'T001', 3

create proc usp_ThemTP @matp char(2), @tentp nvarchar(20)
as
   if exists ( select * from dbo.ThanhPho
                        where MaTP = @matp)
						print N'Đã tồn tại thành phố!'
	else
	    begin
		     insert into dbo.ThanhPho
			 values
			   (   @matp, -- MaTP - char(2)
		        @tentp -- TenTP - nvarchar(20)
		        )
				print N'Đã nhập thành công thành phố' + @matp
		end

exec usp_ThemTP '01',N'Đà Lạt'

create proc usp_ThemTourTP @matour char(5),@matp char(2),@songay tinyint
as
	if exists (select * from dbo.Tour where MaTour = @matour) and exists(select * from dbo.ThanhPho where MaTP = @matp)
		begin
		    insert into dbo.TOUR_TP
		    values
		    (   @matour, -- MaTour - char(5)
		        @matp, -- MaTP - char(2)
		        @songay   -- SoNgay - tinyint
		        )
				print N'Đã thêm thành công thông tin tour thành phố!'
		end
	else
		begin
		    if not exists (select * from dbo.Tour where MaTour = @matour)
				print N'Không tồn tại tour trong cơ sở dữ liệu!'
			else
				print N'Không tồn tại thành phố trong cơ sở dữ liệu!'
		end

exec usp_ThemTourTP 'T005',N'Bình Phước',3

create proc usp_ThemLichTour @matour char(5),@ngaykh datetime, @tenhdv nvarchar(10), @songuoi int, @tenkh nvarchar(20)
as
	if exists (select * from dbo.Tour where MaTour = @matour)
		begin
		    insert into dbo.Lich_TourDL
		    values
		    (   @matour,        -- MaTour - char(5)
		        @ngaykh, -- NgayKH - datetime
		        @tenhdv,       -- TenHDV - nvarchar(10)
		        @songuoi,         -- SoNguoi - int
		        @tenkh        -- TenKH - nvarchar(20)
		        )
				print N'Đã nhập nhành công dữ liệu của lịch tour vào bảng!'
		end
	else 
		begin
		    if not exists (select * from dbo.Tour where MaTour = @matour)
			print N'Mã tour không tồn tại!'
		end

exec usp_ThemLichTour 'T001', '02/14/2017', N'Vân' ,20, N'Nguyễn Hoàng'
select * from dbo.Lich_TourDL

---------------------------TRUY VẤN DỮ LIỆU---------------------------
-- (a) Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày.
select MaTour
from dbo.Tour_TP
group by MaTour
having sum(SoNgay) between 3 and 5

-- (b) Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017.
select *
from dbo.Lich_TourDL
where month(NgayKH) = 02 and year(NgayKH) = 2017

-- (c) Cho biết các tour không đi qua thành phố 'Nha Trang'.
select MaTour
from dbo.Tour
where MaTour not in
            ( select MaTour
			  from dbo.Tour_TP join dbo.ThanhPho on ThanhPho.MaTP = Tour_TP.MaTP
			  where TenTP = N'Nha Trang')

-- (d) Cho biết số lượng thành phố mà mỗi tour du lịch đi qua.
select MaTour, count(MaTP) as SLTP
from dbo.Tour_TP
group by MaTour

-- (e) Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn.
select TenHDV, count(MaTour) as SLTour
from dbo.Lich_TourDL
group by TenHDV

-- (f) Cho biết tên thành phố có nhiều tour du lịch đi qua nhất.
select TTP1.MaTP, TP.TenTP
from dbo.Tour_TP TTP1, dbo.ThanhPho TP
where TP.MaTP = TTP1.MaTP
group by TTP1.MaTP, TP.TenTP
having count(TTP1.MaTour) >= all
( select count(TTP.MaTour)
  from dbo.Tour_TP TTP
  group by TTP.MaTP)

-- (g) Cho biết thông tin của tour du lịch đi qua tất cả các thành phố.
select *
from dbo.Tour T
where not exists ( select * 
                            from dbo.ThanhPho TP
							where not exists (select *
							                           from dbo.Tour_TP TTP
													   where TTP.MaTour = T.MaTour and TTP.MaTP = TP.MaTP))

-- (h) Lập danh sách các tour đi qua thành phố 'Ðà Lạt', thông tin cần hiển thị bao gồm: Mã tour, Songay.
select TTP.MaTour, TTP.SoNgay
from dbo.Tour_TP TTP, dbo.ThanhPho TP
where TTP.MaTP = TP.MaTP and TP.TenTP = N'Đà Lạt'

-- (i) Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất.
select Tour.MaTour, TongSoNgay
from dbo.Lich_TourDL, dbo.Tour
where Lich_TourDL.MaTour = Tour.MaTour
group by Tour.MaTour, TongSoNgay
having sum(SoNguoi) >= all
       (  select sum(SoNguoi)
	      from dbo.Lich_TourDL
		  group by MaTour)
		  
-- (j) Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua.
select * 
from dbo.ThanhPho TP
where not exists (  select *
                            from dbo.Tour T
							where not exists ( select *
							                           from dbo.Tour_TP TTP
													   where TTP.MaTP = TP.MaTP and TTP.MaTour = T.MaTour))