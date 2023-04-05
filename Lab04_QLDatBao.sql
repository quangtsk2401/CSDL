/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab04_QLDatBao
go

use Lab04_QLDatBao
go

create table KhachHang(
MaKH char(5),
TeNKH nvarchar(10) not null,
DiaChi nvarchar(10)
primary key (MaKH)
)
go

create table Bao_TChi(
MaBaoTC char(5),
Ten nvarchar(30),
DinhKy nvarchar(20),
SoLuong int,
GiaBan integer,
primary key (MaBaoTC)
)
go

create table PhatHanh(
MaBaoTC char(5) references dbo.Bao_TChi(MaBaoTC),
SoBaoTC int,
NgayPH datetime,
primary key(MaBaoTC, SoBaoTC)
)
go

create table DatBao(
MaKH char(5) references dbo.KhachHang(MaKH),
MaBaoTC char(5) references dbo.Bao_TChi(MaBaoTC),
SLMua int,
NgayDM datetime,
primary key(MaKH, MaBaoTC)
)
go
-------------NHAP DU LIEU CHO CAC BANG-----------
insert into Bao_TChi values ('TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500);
insert into Bao_TChi values ('KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000);
insert into Bao_TChi values ('TN01', N'Thanh niên', N'Nhật báo', 1000, 2000);
insert into Bao_TChi values ('PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000);
insert into Bao_TChi values ('PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000);
select * from Bao_TChi;

set dateformat dmy
go
insert into PhatHanh values ('TT01', 123, '15/12/2005');
insert into PhatHanh values ('KT01', 70, '15/12/2005');
insert into PhatHanh values ('TT01', 124, '16/12/2005');
insert into PhatHanh values ('TN01', 256, '17/12/2005');
insert into PhatHanh values ('PN01', 45, '23/12/2005');
insert into PhatHanh values ('PN02', 111, '18/12/2005');
insert into PhatHanh values ('PN02', 112, '19/12/2005');
insert into PhatHanh values ('TT01', 125, '17/12/2005');
insert into PhatHanh values ('PN01', 46, '30/12/2005');
select * from PhatHanh;

insert into KhachHang values ('KH01', N'LAN', N'2 NCT');
insert into KhachHang values ('KH02', N'NAM', N'32 THĐ');
insert into KhachHang values ('KH03', N'NGỌC', N'16 LHP');
select * from KhachHang;

insert into DatBao values ('KH01', 'TT01', 100, '12/01/2000');
insert into DatBao values ('KH02', 'TN01', 150, '01/05/2001');
insert into DatBao values ('KH01', 'PN01', 200, '25/06/2001');
insert into Datbao values ('KH03', 'KT01', 50, '17/03/2002');
insert into DatBao values ('KH03', 'PN02', 200, '26/08/2003');
insert into DatBao values ('KH02', 'TT01', 250, '15/01/2004');
insert into Datbao values ('KH01', 'KT01', 300, '14/10/2004');
select * from DatBao;

select * from Bao_TChi
select * from PhatHanh
select * from KhachHang
select * from DatBao
---------------------------TRUY VẤN DỮ LIỆU---------------------------
-- 1) Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo).
select MaBaoTC, Ten, GiaBan
from dbo.Bao_TChi
where DinhKy = N'Tuần báo'

-- 2) Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
select *
from dbo.Bao_TChi
where MaBaoTC like 'PN%'

-- 3) Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
select KH.TenKH
from dbo.Bao_TChi BC, dbo.DatBao DB, dbo.KhachHang KH
where BC.MaBaoTC like 'PN%' and DB.MaKH = KH.MaKH and BC.MaBaoTC = DB.MaBaoTC

-- 4) Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
select distinct DB.MaKH
from dbo.DatBao DB
where not exists ( select
                          * from dbo.Bao_TChi BC
						    where BC.MaBaoTC like 'PN%' and
							not exists ( select *
							                      from dbo.DatBao DB2
												  where BC.MaBaoTC = DB2.MaBaoTC and DB2.MaKH = DB.MaKH))

-- 5) Cho biết các khách hàng không đặt mua báo thanh niên.
select KH.TenKH
from dbo.KhachHang KH
where KH.MaKH not in ( select dbo.KhachHang.MaKH
                                                 from dbo.DatBao, dbo.KhachHang
												 where MaBaoTC like 'TN%' and DatBao.MaKH = KhachHang.MaKH)

-- 6) Cho biết số tờ báo mà mỗi khách hàng đã đặt mua.
select KH.TenKH, DB.MaKH, sum(DB.SLMua)
from dbo.DatBao DB, dbo.KhachHang KH
where KH.MaKH = DB.MaKH
group by KH.TenKH, DB.MaKH

-- 7) Cho biết số khách hàng đặt mua báo trong năm 2004.
select DB.MaKH
from dbo.DatBao DB
where year(DB.NgayDM) = 2004

-- 8) Cho biết thông tin đặt mua báo của các khách hàng (TenKH, TeN, DinhKy, SLMua, SoTien), trong đó SoTien = SLMua x DonGia.
select KH.TenKH, BC.Ten, BC.DinhKy, DB.SLMua, DB.SLMua * BC.GiaBan as SoTien
from dbo.Bao_TChi BC, dbo.DatBao DB, dbo.KhachHang KH
where DB.MaKH = KH.MaKH and BC.MaBaoTC = DB.MaBaoTC

-- 9) Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
select BC.Ten, BC.DinhKy, sum(DB.SLMua)
from dbo.Bao_TChi BC, dbo.DatBao DB
where DB.MaBaoTC = BC.MaBaoTC
group by BC.MaBaoTC, BC.Ten, BC.DinhKy

-- 10) Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS).
select *
from dbo.Bao_TChi
where MaBaoTC like 'HS%'

-- 11) Cho biết những tờ báo không có người đặt mua.
select MaBaoTC, Ten
from dbo.Bao_TChi BC
where MaBaoTC not in ( select MaBaoTC 
                                     from dbo.DatBao)

-- 12) Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
select BC.Ten, BC.DinhKy, count(DB.SLMua)
from dbo.DatBao DB, dbo.Bao_TChi BC
where BC.MaBaoTC = DB.MaBaoTC
group by BC.Ten, BC.DinhKy
having count(DB.SLMua) in
                     ( select max(SL.SLM)
					   from (select count(SLMua) as SLM
					               from dbo.DatBao
								   group by MaBaoTC) as SL)

-- 13) Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
select KH.TenKH
from dbo.KhachHang KH, dbo.DatBao DB
where KH.MaKH = DB.MaKH
group by KH.MaKH, DB.MaKH
having sum(DB.SLMua) >= all (select sum(SLMua)
                                               from dbo.DatBao
											   group by KH.MaKH)

-- 14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
select *
from dbo.Bao_TChi
where DinhKy = N'Nhật báo'

-- 15) Cho biết các tờ báo, tạp chi có từ 3 khách hàng đặt mua trở lên.
select Bao_TChi.MaBaoTC, Ten
from dbo.Bao_TChi, dbo.DatBao
where DatBao.MaBaoTC = Bao_TChi.MaBaoTC
group by Ten, Bao_TChi.MaBaoTC
having count(SLMua) >= 3

---------------------------HÀM & THỦ TỤC---------------------------

--A.HÀM
--a) Tính tổng số tiền mua báo/tạp chí của một khách hàng cho trước
create function tongTienMuaBao(@maKH char(5))
returns int
as
begin
     declare @tongTien int
	        select @tongTien = sum(db.SLMua * bc.GiaBan)
			from dbo.DatBao DB, dbo.Bao_TChi bc
			where @maKH = db.MaKH and db.MaBaoTC = bc.MaBaoTC
			return @tongTien
end

print dbo.tongTienMuaBao ('KH01')

--b.Tính tổng số tiền thu được của một tờ báo/tạp chí cho trước.
create function tongTienBaoTapChi(@maBao char(5))
returns int
as
begin
    declare @tongTien int
	       select @tongTien = sum(db.SLMua * bc.GiaBan)
		   from dbo.Bao_TChi bc, dbo.DatBao db
		   where @maBao = db.MaBaoTC and db.MaBaoTC = bc.MaBaoTC
		   return @tongTien
end

print dbo.tongTienBaoTapChi('TT01')

 --B.THỦ TỤC
  --a.In danh mục báo, tạp chí phải giao cho một khách hàng cho trước
create proc usp_DanhMucBTC @maKH char(5)
as
   if exists (select * from dbo.KhachHang where MaKH = @maKH)
   begin
        select db.MaKH, kh.TenKH, kh.DiaChi, db.MaBaoTC, db.SLMua
		from dbo.DatBao db, dbo.KhachHang kh
		where db.MaKH = kh.MaKH and db.MaKH = @maKH
	end
	else
	print (N'Mã khách hàng không tồn tại')
	go
exec usp_DanhMucBTC 'KH01'

--b.In danh sách khách hàng đặt mua báo/tạp chí cho trước.
create proc usp_DanhSachKHMua @maBao char(5)
as
   if exists (select * from dbo.Bao_TChi where MaBaoTC = @maBao)
   begin
          select kh.MaKH, kh.TenKH, db.SLMua, kh.DiaChi, db.NgayDM
		  from dbo.KhachHang kh, dbo.DatBao db
		  where db.MaKH = kh.MaKH and db.MaBaoTC = @maBao
	end
	else
	print (N'Không tồn tại mã báo/tạp chí')
	go

	exec usp_DanhSachKHMua 'TT01'