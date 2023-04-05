/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 
*/	

create database Lab07_QLSinhVien
go

use Lab07_QLSinhVien
go

create table Khoa
(MSKhoa int primary key,
TenKhoa nvarchar(30),
TenTat varchar(5)
)

insert into Khoa values (01,N'Công nghệ thông tin','CNTT')
insert into Khoa values (02,N'Điện Tử viễn thông','DTVT')
insert into Khoa values (03,N'Quản trị kinh doanh','QTKD')
insert into Khoa values (04,N'Công nghệ sinh học','CNSH')

create table Lop
(MSLop varchar(5) primary key,
TenLop varchar(30),
MSKhoa int references dbo.Khoa(MSKhoa),
NienKhoa int check (NienKhoa > 0)
)

insert into Lop values ('98TH','Tin hoc khoa 1998',01,1998)
insert into Lop values ('98VT','Vien Thong khoa 1998',02,1998)
insert into Lop values ('99TH','Tin hoc khoa 1999',01,1999)
insert into Lop values ('99VT','Vien thong khoa 1999',02,1999)
insert into Lop values ('99QT','Quan tri khoa 1999',03,1999)

create table Tinh
(MSTinh int primary key,
TenTinh varchar(10),
)

insert into Tinh values (01,'An Giang')
insert into Tinh values (02,'TPHCM')
insert into Tinh values (03,'Dong Nai')
insert into Tinh values (04,'Long An')
insert into Tinh values (05,'Hue')
insert into Tinh values (06,'Ca Mau')

create table MonHoc
(MSMH varchar(5) primary key,
TenMH varchar(25),
HeSo int not null,
)

insert into MonHoc values ('TA01','Nhap mon tin hoc',2)
insert into MonHoc values ('TA02','Lap trinh co ban',3)
insert into MonHoc values ('TB01','Cau truc du lieu',2)
insert into MonHoc values ('TB02','Co so du lieu',2)
insert into MonHoc values ('QA01','Kinh te vi mo',2)
insert into MonHoc values ('QA02','Quan tri chat luong',3)
insert into MonHoc values ('VA01','Dien tu co ban',2)
insert into MonHoc values ('VA02','Mach so',3)
insert into MonHoc values ('VB01','Truyen so lieu',3)
insert into MonHoc values ('XA01','Vat ly dai cuong',2)

create table SinhVien
(MSSV varchar(10) primary key,
Ho varchar(15),
Ten varchar(10),
NgaySinh datetime,
MSTinh int references dbo.TINH(MSTinh),
NgayNhapHoc datetime,
MSLop varchar(5) references dbo.LOP(MSLop),
Phai varchar(3),
DiaChi varchar(30),
DienThoai int check (DienThoai > 0),
)

set dateformat dmy
insert into SinhVien values ('98TH001', 'Nguyen Van',  'An',   '06/08/80', 01, '03/09/98', '98TH', 'Yes', '12 Tran Hung Dao, Q.1',	8234512)
insert into SinhVien values ('98TH002', 'Le Thi',	   'An',	  '17/10/79', 01, '03/09/98', '98TH', 'No',  '23 CMT8, Q. Tan Binh',	0303234342)
insert into SinhVien values ('98VT001', 'Nguyen Duc',  'Binh', '25/11/81', 02, '03/09/98', '98VT', 'Yes', '245 Lac Long Quan, Q.11', 8654323)
insert into SinhVien values ('98VT002', 'Tran Ngoc',   'Anh', '19/08/80', 02, '03/09/98', '98VT', 'No',  '242 Tran Hung Dao, Q.1' ,NULL)
insert into SinhVien values ('99TH001', 'Ly Van Hung', 'Dung', '27/09/81', 03, '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', 7563213)
insert into SinhVien values ('99TH002', 'Van Minh', 'Hoang', '01/01/81', 04, '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', 8341234)
insert into SinhVien values ('99TH003', 'Nguyen', 'Tuan', '12/01/80', 03, '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5',NULL)
insert into SinhVien values ('99TH004', 'Tran Van', 'Minh', '25/06/81', 04, '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', 7236754)
insert into SinhVien values ('99TH005', 'Nguyen Thai', 'Minh', '01/01/80', 04, '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', NULL)
insert into SinhVien values ('99VT001', 'Le Ngoc', 'Mai', '21/06/82', 01, '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', 0903124534)
insert into SinhVien values ('99QT001', 'Nguyen Thi', 'Oanh', '19/08/73', 04, '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', 0901656324)
insert into SinhVien values ('99QT002', 'Le My', 'Hanh', '20/05/76', 04, '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', NULL)

create table BangDiem 
(MSSV varchar(10)foreign key references dbo.SinhVien(MSSV),
MSMH varchar(5)foreign key references dbo.MonHoc(MSMH),
LanThi tinyint not null,
Diem float not null
primary key (MSSV,MSMH,LanThi)
)

insert into BangDiem values ('98TH001', 'TA01', 1, 8.5)
insert into BangDiem values ('98TH001', 'TA02', 1, 8)
insert into BangDiem values ('98TH002', 'TA01', 1, 4)
insert into BangDiem values ('98TH002', 'TA01',2,5.5)
insert into BangDiem values ('98TH001', 'TB01',1,7.5)
insert into BangDiem values ('98TH002', 'TB01' ,1, 8)
insert into BangDiem values ('98VT001', 'VA01', 1, 4)
insert into BangDiem values ('98VT001', 'VA01' ,2, 5)
insert into BangDiem values ('98VT002', 'VA02', 1, 7.5)
insert into BangDiem values ('99TH001', 'TA01', 1, 4)
insert into BangDiem values ('99TH001', 'TA01', 2, 6)
insert into BangDiem values ('99TH001', 'TB01', 1, 6.5)
insert into BangDiem values ('99TH002', 'TB01', 1, 10)
insert into BangDiem values ('99TH002', 'TB02', 1, 9)
insert into BangDiem values ('99TH003', 'TA02', 1, 7.5)
insert into BangDiem values ('99TH003', 'TB01', 1, 3)
insert into BangDiem values ('99TH003', 'TB01', 2, 6)
insert into BangDiem values ('99TH003', 'TB02', 1, 8)
insert into BangDiem values ('99TH004', 'TB02', 1, 2)
insert into BangDiem values ('99TH004', 'TB02', 2, 4)
insert into BangDiem values ('99TH004', 'TB02', 3, 3)
insert into BangDiem values ('99QT001', 'QA01', 1, 7)
insert into BangDiem values ('99QT001', 'QA02', 1, 6.5)
insert into BangDiem values ('99QT002', 'QA01', 1, 8.5)
insert into BangDiem values ('99QT002', 'QA02', 1, 9)

select * from dbo.SinhVien
select * from dbo.BangDiem
select * from dbo.Khoa
select * from dbo.Lop
select * from dbo.MonHoc
select * from dbo.Tinh

----------------------------------
--TRUY VẤN CƠ BẢN
----------------------------------
--1.liệt kê mssv, họ, tên, địa chỉ chỉ của tất cả các sinh viên
select MSSV, Ho, Ten, DiaChi
from dbo.SinhVien

--2.Liệt kê mssv, họ, tên, ms tỉnh của tất cả các sinh viên. Sắp xếp kết quả theo MS tỉnh, trong cùng tỉnh sắp xếp theo họ tên của sinh viên
select sv.MSSV, sv.Ho, sv.Ten, sv.MSTinh
from dbo.SinhVien sv
order by sv.MSTinh, sv.Ten

--3.Liệt kê các sinh viên nữ của tỉnh Long An
select sv.MSSV, sv.Ho, sv.Ten, sv.NgaySinh, t.MSTinh, t.TenTinh
from dbo.SinhVien sv, dbo.Tinh t
where sv.MSTinh = t.MSTinh and t.TenTinh = 'Long An' and sv.Phai = 'No'

--4.Liệt kê các sinh viên có sinh nhật trọng tháng giêng
select *
from dbo.SinhVien
where month(NgaySinh) = 1

--5.Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1
select *
from dbo.SinhVien
where month(NgaySinh) = 1 and day(NgaySinh) = 1

--6.Liệt kê các sinh viên có số điện thoại
select *
from dbo.SinhVien
where DienThoai = ' '

--7.Liệt kê các sinh viên có số điện thoại di động
select *
from dbo.SinhVien
where len(DienThoai) > 7

--8.Liệt kê các sinh viên tên 'Minh' học lớp '99TH'
select *
from dbo.SinhVien
where Ten = 'Minh' and MSLop = '99TH'

--9.Liệt kê các sih viên có địa chỉ ở đường 'Tran Hung Dao'
select *
from dbo.SinhVien
where DiaChi like '%TranHungDao%'

--10.Liệt kê các sinh viên có tên lót 'Van'
select *
from dbo.SinhVien
where Ho like '%Van%'

--11.Liệt kê MSSV, họ tên, tuổi của các sinh viên ở tỉnh Long An
select MSSV, Ho + ' ' + Ten as HoTen, 1999 - year(NgaySinh) as Tuoi
from dbo.SinhVien

--12.Liệt kê các sinh viên nam từ 23 đến 28 tuổi
select MSSV, Ho + ' ' + Ten as HoTen, 1999 - year(NgaySinh) as Tuoi
from dbo.SinhVien
where 1999 - YEAR(NgaySinh) between 23 and 28

--13.Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh nữ từ 27 tuổi trở lên
select MSSV, Ho + ' ' + Ten as HoTen, year(getdate()) - year(NgaySinh) as Tuoi, Phai
from dbo.SinhVien
where year(getdate()) - year(NgaySinh) > 32 and Phai = 'Yes' or MSSV in( select sv.MSSV
                                                                                       from dbo.SinhVien sv
																					   where year(getdate()) - year(sv.NgaySinh) > 27 and sv.Phai = 'No')

--14.Liệt kê các sinh viên nhập học còn dưới 18 tuổi hoặc đã trên 25 tuổi
select MSSV, Ho + ' ' + Ten as HoTen, year(NgayNhapHoc) - year(NgaySinh) as Tuoi
from dbo.SinhVien
where year(NgayNhapHoc) - year(NgaySinh) < 18 or year(NgayNhapHoc) - year(NgaySinh) > 25

--15.Liệt kê các danh sách các sinh viên của khóa 99
select *
from dbo.SinhVien
where MSSV like '%99%'

--16.Liệt kê MSSV, điểm thi lần 1 môn 'co so du lieu' của lớp '99TH'
select sv.MSSV, bd.Diem
from dbo.BangDiem bd, dbo.MonHoc mh, dbo.SinhVien sv
where bd.MSSV = sv.MSSV and bd.MSMH = mh.MSMH and mh.TenMH = 'Co so du lieu' and bd.LanThi = 1 and sv.MSLop = '99TH'

--17.Liệt kê mssv, họ tên của các sinh viên lớp '99TH' thi không đạt lần 1 môn csdl
select distinct(sv.MSSV), sv.Ho + ' ' + sv.Ten as HoTen
from dbo.BangDiem bd, dbo.MonHoc mh, dbo.SinhVien sv
where bd.MSSV = sv.MSSV and bd.MSMH = mh.MSMH and mh.TenMH = 'Co so du lieu' and bd.LanThi > 1 and sv.MSLop = '99TH'

--18.Liệt kê tất cả các điểm thi của sinh viên có mã số '99TH001' theo mẫu sau:
select bd.MSMH, mh.TenMH, bd.LanThi, bd.Diem
from dbo.MonHoc mh, dbo.BangDiem bd
where mh.MSMH = bd.MSMH and bd.MSSV = '99TH001'

--19.Liệt kê MSSV, họ tên, mslop của các sinh viên có điểm thi lần 1 môn 'co so du lieu' từ 8 điểm trở lên
select sv.MSSV, sv.Ho + ' ' + sv.Ten as HoTen
from dbo.BangDiem bd, dbo.MonHoc mh, dbo.SinhVien sv
where bd.MSSV = sv.MSSV and bd.MSMH = mh.MSMH and mh.TenMH = 'Co so du lieu' and bd.LanThi = 1 and bd.Diem >= 8

--20.Liệt kê các tỉnh không có sinh viên theo học
select * 
from dbo.Tinh t
where t.MSTinh not in ( select distinct(MSSV) from dbo.SinhVien)

--21.Liệt kê các sinh viên hiện chưa có điểm môn thi nào
select * 
from dbo.SinhVien
where MSSV not in ( select distinct(MSSV) from dbo.BangDiem)

------------------------------------------------------------
--Truy vấn gom nhóm
------------------------------------------------------------
--22.Thống kê số lượng sinh viên ở mỗi lớp theo mẫu.
select l.MSLop, l.TenLop, count(sv.MSSV) as SLSV
from dbo.SinhVien sv, dbo.Lop l
where sv.MSLop=l.MSLop
group by l.MSLop, l.TenLop
--23.Thống kê só lượng sinh viên ở mỗi tỉnh theo mẫu sau:
select A.MSTinh, A.TenTinh, SVNam.SoSVNam, SVNu.SoSVNu
from (select t.MSTinh, t.TenTinh, count(sv.Phai) as TongSV
		from dbo.Tinh t,dbo.SinhVien sv
		where sv.MSTinh=t.MSTinh
		group by t.MSTinh, t.TenTinh) as A full join (select t.MSTinh, t.TenTinh, count(sv.Phai) as SoSVNam 
													from dbo.Tinh t,dbo.SinhVien sv
													where t.MSTinh = sv.MSTinh and sv.Phai = 'Yes'
													group by t.MSTinh, t.TenTinh) as SVNam on (A.MSTinh = SVNam.MSTinh) full join(select t.MSTinh, t.TenTinh, count(sv.Phai) as SoSVNu
																																from dbo.Tinh t, dbo.SinhVien sv
																																where sv.MSTinh = t.MSTinh and sv.Phai = 'No'
																																group by t.MSTinh,t.TenTinh) as SVNu on(SVNam.MSTinh = SVNu.MSTinh) 


--25.Lọc ra điểm cao nhất trong các lần thi cho các sinh viên tho mẫu sau:
select bd.MSSV, mh.MSMH, mh.TenMH, mh.HeSo, max(bd.Diem) as N'Điểm', max(bd.Diem) * mh.HeSo as N'Điểm x hệ số'
from dbo.SinhVien sv, dbo.BangDiem bd, dbo.MonHoc mh
where sv.MSSV = bd.MSSV and bd.MSMH = mh.MSMH
group by bd.MSSV, mh.MSMH, mh.TenMH, mh.HeSo
--26.Lập bảng tổng kết theo mẫu
select bd.MSSV, sv.Ho, sv.Ten, sum(bd.Diem * mh.HeSo)/sum(mh.HeSo) as N'ĐTB'
from dbo.SinhVien sv, dbo.BangDiem bd, dbo.MonHoc mh
where sv.MSSV = bd.MSSV and bd.MSMH = mh.MSMH
group by bd.MSSV, sv.Ho, sv.Ten
--27.Thống kê số lượng sinh viên tỉnh 'Long An' đang theo học ở các khoa, theo mẫu sau:
select l.NienKhoa, l.MSKhoa, k.TenKhoa, count(sv.MSSV) as SLSV
from dbo.SinhVien sv, dbo.Khoa k, dbo.Tinh t,dbo.Lop l
where sv.MSTinh = t.MSTinh and l.MSLop = sv.MSLop and k.MSKhoa = l.MSKhoa and t.TenTinh = 'Long An'
group by l.NienKhoa, l.MSKhoa, k.TenKhoa

----------------------------------------------------
--Hàm & thủ tục
----------------------------------------------------
--28.Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau
create proc usp_InThongTinSV @mssv char(10)
as
	if exists(SELECT * FROM dbo.SinhVien WHERE MSSV=@mssv)
		begin
		    select mh.MSMH, mh.TenMH, mh.HeSo, max(bd.Diem) as N'Điểm'
			from dbo.SinhVien sv, dbo.BangDiem bd, dbo.MonHoc mh
			where sv.MSSV = bd.MSSV AND bd.MSMH = mh.MSMH AND sv.MSSV = @mssv
			group by mh.MSMH, mh.TenMH, mh.HeSo
		end
	else
		print N'Không tồn tại sinh viên!'

------------
exec usp_InThongTinSV '98TH001'

--29.Nhập vào MS lớp, in ra bảng tổng kết của lớp đó
create proc usp_InBTK @mslop char(5)
as
	if exists(select * from dbo.Lop where MSLop = @mslop)
		begin
			select bd.MSSV, sv.Ho, sv.Ten, sum(bd.Diem * mh.HeSo)/sum(mh.HeSo) as N'ĐTB',N'Xếp Loại' = case
				when sum(bd.Diem * mh.HeSo)/sum(mh.HeSo) >=8 THEN N'Giỏi'
				when SUM(bd.Diem * mh.HeSo)/sum(mh.HeSo)>=6 THEN N'Khá'
				when sum(bd.Diem * mh.HeSo)/sum(mh.HeSo) >=5 then N'Trung bình'
				else N'Yếu' end
			from dbo.SinhVien sv, dbo.BangDiem bd,dbo.MonHoc mh
			where sv.MSSV=bd.MSSV AND bd.MSMH=mh.MSMH AND sv.MSLop=@mslop
			group by bd.MSSV,sv.Ho,sv.Ten
		end
	else 
		print N'Không tồn tại lớp'
        
-------------------------
exec usp_InBTK '98TH'

---------------------------------------------------------
--Cập nhật dữ liệu
---------------------------------------------------------
--30,31,32 Tạo bảng SinhVienTinh trong đó chứa hồ sơ của các sinh viên có quên quán không phải ở TPHCM. Thêm thuộc tính HBONG cho tất cả các sinh viên
--Cập nhật thuộc tính HBONG trong table SinhVienThanh 10000 cho tất cả các sinh viên
create view SinhVienTinh as 
select *, 'HBONG' = case
when MSSV like '%%' then 10000
end
from dbo.SinhVien
where MSSV not in (	select sv.MSSV from dbo.SinhVien sv, dbo.Tinh t where sv.MSTinh = t.MSTinh and t.TenTinh = 'TPHCM')

--select * from SinhVienTinh
--drop view dbo.SinhVienTinh