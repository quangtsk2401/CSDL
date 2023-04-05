/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Mai Thanh Lâm
   MSSV: 1911162
   Ngày: 
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab02_QuanLySanXuat
go
use Lab02_QuanLySanXuat
go
create table ToSanXuat
(MaTSX char(4) primary key,
TenTSX nvarchar(5) not null
)
go
create table CongNhan
(MACN char(5) primary key,
Ho nvarchar(30) not null,
Ten nvarchar(10) not null,
Phai nvarchar(5) not null,
NgaySinh datetime,
MaTSX char(4) references ToSanXuat(MaTSX)
)
go
create table SanPham
(MASP char(5) primary key,
TenSP nvarchar(20) not null,
DVT nchar(5) not null,
TienCong int check(TienCong > 1000 and TienCong < 30000)
)
go 
create table ThanhPham
(
MACN char(5) references CongNhan(MACN),
MaSP char(5) references SanPham(MaSP),
Ngay datetime,
SoLuong tinyint check(SoLuong >= 5 and SoLuong <=100),
primary key(MACN,MaSP,Ngay)
)
go
----------NHẬP DỮ LIỆU CHO CÁC BẢNG----------
insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values('TS02',N'Tổ 2')
--xem bảnh ToSanXuat
select * from ToSanXuat
--Nhập bảng CongNhan
set dateformat dmy
insert into CongNhan values('CN001',N'Nguyễn Trường',N'An',N'Nam','12/05/1981','TS01')
insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')
insert into CongNhan values('CN003',N'Nguyễn Công',N'Thành',N'Nam','04/05/1981','TS02')
insert into CongNhan values('CN004',N'Võ Hữu',N'Hạnh',N'Nam','15/02/1980','TS02')
insert into CongNhan values('CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981','TS01')
--xem bảng CongNhan
select * from CongNhan
--Nhập bảng SanPham
insert into SanPham values('SP001',N'Nồi đất',N'cái','10000')
insert into SanPham values('SP002',N'Chén',N'cái','2000')
insert into SanPham values('SP003',N'Bình gốm nhỏ',N'cái','20000')
insert into SanPham values('SP004',N'Bình gốm lớn',N'cái','25000')
--xem bảng SanPham
SELECT * FROM SanPham
--Nhập bảng ThanhPham
insert into ThanhPham values('CN001','SP001','01/02/2007','10')
insert into ThanhPham values('CN002','SP001','01/02/2007','5')
insert into ThanhPham values('CN003','SP002','10/01/2007','50')
insert into ThanhPham values('CN004','SP003','12/01/2007','10')
insert into ThanhPham values('CN005','SP002','12/01/2007','100')
insert into ThanhPham values('CN002','SP004','13/02/2007','10')
insert into ThanhPham values('CN001','SP003','14/02/2007','15')
insert into ThanhPham values('CN003','SP001','15/01/2007','20')
insert into ThanhPham values('CN003','SP004','14/02/2007','15')
insert into ThanhPham values('CN004','SP002','30/01/2007','100')
insert into ThanhPham values('CN005','SP003','01/02/2007','50')
insert into ThanhPham values('CN001','SP001','20/02/2007','30')
--xem bảng ThanhPham
select * from ThanhPham
--------------------------------------------------------------------------------
select * from ToSanXuat
select * from CongNhan
select * from SanPham
select * from ThanhPham
--------------------------------------------------------------------------------
--Yêu cầu I
----1) Tạo các table và thiết lập mói quan hệ giữa các table. 
--Dựa vào dữ liệu mẫu, sinh viên tự chọn kiểu dữ liệu phù hợp cho các field của các bảng
--2) Cài đặt các ràng buộc toàn vẹn
--a) Tên Tổ sản xuất phải phân biệt(Không được giống nhau)
--b) Tên sản phẩm phải khác nhau
--c) Tiền công >0
--d) Số lượng phải là số nguyên dương
-- Có RBTV theo yêu cầu:

--II. Tạo các Query sau, đặt tên Query theo thứ tự câu hỏi
-- 1) Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen, 
-- NgaySinh, Phai (xếp thứ tự tăng dần của tên tổ sản xuất, Tên của công nhân).
select TenTSX, Ho + ' ' + Ten as HoTen, NgaySinh, Phai
from CongNhan A, ToSanXuat B
where A.MaTSX = B.MaTSX
order by TenTSX, Ten ASC
-- 2) Liệt kê các thành phẩm mà công nhân ‘Nguyễn Trường An’ đã làm được gồm 
-- các thông tin: TenSP, Ngay, SoLuong, ThanhTien (xếp theo thứ tự tăng dần của ngày). 
select Ho + ' ' + Ten as HoTen, TenSP, Ngay, SoLuong, SoLuong * TienCong as ThanhTien
from CongNhan A, SanPham B, ThanhPham C
where A.MACN = C.MACN and B.MASP = C.MASP and Ho = N'Nguyễn Trường' and Ten = N'An'
-- 3) Liệt kê các nhân viên không sản xuất sản phẩm ‘Bình gốm lớn’.
select Distinct Ho + ' ' + Ten as HoTen, NgaySinh, Phai
from CongNhan A, ThanhPham B, SanPham C
where A.MACN = B.MACN and B.MASP = C.MASP and TenSP <> N'Bình gốm lớn'
-- 4) Liệt kê thông tin các công nhân có sản xuất cả ‘Nồi đất’ và ‘Bình gốm nhỏ’.
select distinct Ho + ' ' + Ten as HoTen, NgaySinh , Phai
from CongNhan A, ThanhPham B, SanPham C
where A.MACN = B.MACN and B.MaSP = C.MASP and TenSP = N'Nồi đất' and TenSP = N'Bình gốm nhỏ'
-- 5) Thống kê Số luợng công nhân theo từng tổ sản xuất.
select TenTSX, count(MACN) as SoCN
from CongNhan A, ToSanXuat B
where A.MaTSX = B.MaTSX
group by TenTSX 
-- 6)  Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được (Ho, 
-- Ten, TenSP, TongSLThanhPham, TongThanhTien).
select Ho + ' ' + Ten as HoTen, TenSP, Sum(SoLuong) as TongSLThanhPham, Sum(SoLuong * TienCong) as TongThanhTien
from CongNhan A, ThanhPham B, SanPham C
where A.MACN = B.MACN and B.MASP = C.MASP
group by Ho + ' ' + Ten, TenSP
-- 7) Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007
select sum(SoLuong * TienCong) as TongTienCong
from ThanhPham A, SanPham B
where A.MASP = B.MASP and month(Ngay) = '1' and year(Ngay) = '2007'
-- 10) Tiền công tháng 2/2006 của công nhân viên có mã số ‘CN002’
select Ho + ' ' + Ten as HoTen, sum(SoLuong * TienCong) as TienCong
from CongNhan A, SanPham B, ThanhPham C
where A.MACN = C.MACN and B.MASP = C.MASP and C.MACN = 'CN002' and month(Ngay) = '2' and year(Ngay) = (2007)
group by Ho + ' ' + Ten;
-- 11) Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên.
select Ho + ' ' + Ten as HoTen, NgaySinh, Phai, count(distinct MASP) as SoLoaiSP
from CongNhan A, ThanhPham B
where A.MACN = B.MACN
group by Ho + ' ' + Ten, NgaySinh, Phai
having count(distinct MASP) >= 3;
-- 12) Cập nhật giá tiền công của các loại bình gốm thêm 1000.
select * from SanPham
update SanPham set TienCong = TienCong + 1000
where TenSP like N'Bình gốm%'
select * from SanPham
-- 13) Thêm bộ <’CN006’>, ‘Lê Thị’, ‘Lan’, ‘Nữ’,’TS02’ > vào bảng CongNhan.
insert into CongNhan values ('CN006', N'Lê Thị', N'Lan', N'Nữ', '1/1/1981', 'TS02')
select * from CongNhan

--III.Thủ tục & Hàm
--A. Hàm
--a. Tính tổng số công nhân của một tổ sản xuất cho trước
create function sumNV(@maTSX char(5))
returns int
as 
begin
  declare @soCN int
    select @soCN = count(MACN)
	from dbo.CongNhan
	where @maTSX = MaTSX
	return @soCN
end
-------------------------
print(N'Số công nhân của chi nhánh là: ')
print dbo.sumNV('TS01')

--b.Tính tổng sản lượng sản xuất trong một tháng của một loại sản phẩm cho trước
create function sumSLng(@maSP char(5))
returns int
as
begin
    declare @soSL int 
	select @soSL = sum(SoLuong)
	from dbo.ThanhPham
	where @maSP = MaSP
	return @soSL
end

print(N'Sản lượng sản xuất trong một tháng của sản phẩm là:')
print dbo.sumSLng('SP001')

--c.Tính tổng tiền công tháng của một công nhân cho trước
create function TongCongThang(@maCN CHAR(5))
returns int
as
begin
    declare @tongCong INT
	select @tongCong = sum(sp.TienCong*tp.SoLuong)
	from dbo.SanPham sp, dbo.ThanhPham tp
	where @maCN = tp.MACN AND sp.MASP = tp.MASP
	return @tongCong
end

print dbo.TongCongThang('CN001')


--d.Tính tổng thu nhập trong năm của một tổ sản xuất cho trước
--Tìm số nhân viên thuộc tổ sản xuất cho trước
create function tong_Luong(@maTSX char(5))
returns int
as
begin
    declare @tongL int
	SELECT @tongL = sum(dbo.TongCongThang(tp.MACN))
	from dbo.SanPham sp,dbo.ThanhPham tp,dbo.CongNhan cn
	where tp.MASP=sp.MASP AND tp.MACN=cn.MACN AND @maTSX=cn.MATSX
		return @tongL
end

select dbo.tong_Luong('TS01')

--e.Tính tổng sản lượng sản xuất của một loại sản phẩm trong một khoảng thời gian cho trước
create function TongSL_Time_Cho_Truoc(@time datetime, @loaiSP char(5))
returns int
as
begin
    declare @tong int
	select @tong = sum(tp.SoLuong)
	from dbo.SanPham sp,dbo.ThanhPham tp
	where sp.MASP=@loaiSP AND tp.Ngay=@time AND sp.MASP=tp.MASP
	return @tong
end

select dbo.TongSL_Time_Cho_Truoc('02/01/2007','SP001')

--B.Thủ tục
--a.In danh sách các công nhân của một tổ sản xuất cho trước
create proc usp_InDS @maTSX char(5)
as
if exists(	select * 
			from dbo.CongNhan
			where MATSX=@maTSX)
			begin
			select * 
			from dbo.CongNhan
			where MATSX=@maTSX
			end
go

exec usp_InDS 'TS01'

--b.In bảng chấm công sản xuất trong tháng của một công nhân cho trước(bao gồm tên sản phẩm, đơn vị tính, số lượng sản xuất trong tháng, đơn giá, thành tiền)
create proc usp_BangChamCong @maCN char(5)
as
if exists(	select * 
			from dbo.ThanhPham
			where MACN=@maCN)
			begin
			    select sp.TenSP,sp.DVT,tp.SoLuong as SLSXThang,sp.TienCong,sp.TienCong * tp.SoLuong as ThanhTien
				from dbo.SanPham sp, dbo.ThanhPham tp
				where tp.MASP=sp.MASP AND tp.MACN = @maCN
			end
go

exec usp_BangChamCong 'CN001'
-----------------
drop proc usp_BangChamCong