/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab03_QLNhapXuatHangHoa
go
use Lab03_QLNhapXuatHangHoa
go

create table HangHoa(
	MaHH varchar(5) primary key,
	TenHH varchar(30),
	DVT nvarchar(3),
	SoLuongTon int
)
go
create table DoiTac(
	MaDT varchar(5)	primary key,
	TenDT nvarchar(25),
	DiaChi nvarchar(40),
	DienThoai char(10))
go
create table KhaNangCC(
	MaDT varchar(5) references dbo.DoiTac(MaDT),
	MaHH varchar(5) references dbo.HangHoa(MaHH))
go
create table HoaDon(
	SoHD varchar(5) primary key,
	NgayLapHD datetime,
	MaDT varchar(5) references dbo.DoiTac(MaDT),
	TongTG float)
go
create table CT_HoaDon(
	SoHD varchar(5) references dbo.HoaDon(SoHD),
	MaHH varchar(5) references dbo.HangHoa(MaHH),
	DonGia int,
	SoLuong int)
-------------NHAP DU LIEU CHO CAC BANG-----------
insert into HangHoa values ('CPU01', 'CPU INTEL,CELERON 600 BOX', 'CÁI', 5)
insert into HangHoa values ('CPU02', 'CPU INTEL,PIII 700', 'CÁI', 10)
insert into HangHoa values ('CPU03', 'CPU AMD K7 ATHL,ON 600', 'CÁI', 8)
insert into HangHoa values ('HDD01', 'HDD 10.2 GB QUANTUM', 'CÁI', 10)
insert into HangHoa values ('HDD02', 'HDD 13.6 GB SEAGATE', 'CÁI', 15)
insert into HangHoa values ('HDD03', 'HDD 20 GB QUANTUM', 'CÁI', 6)
insert into HangHoa values ('KB01', 'KB GENIUS', 'CÁI', 12)
insert into HangHoa values ('KB02', 'KB MITSUMIMI', 'CÁI', 5)
insert into HangHoa values ('MB01', 'GIGABYTE CHIPSET INTEL', 'CÁI', 10)
insert into HangHoa values ('MB02', 'ACOPR BX CHIPSET VIA', 'CÁI', 10)
insert into HangHoa values ('MB03', 'INTEL PHI CHIPSET INTEL', 'CÁI', 10)
insert into HangHoa values ('MB04', 'ECS CHIPSET SIS', 'CÁI', 10)
insert into HangHoa values ('MB05', 'ECS CHIPSET VIA', 'CÁI', 10)
insert into HangHoa values ('MNT01', 'SAMSUNG 14" SYNCMASTER', 'CÁI', 5)
insert into HangHoa values ('MNT02', 'LG 14"', 'CÁI', 5)
insert into HangHoa values ('MNT03', 'ACER 14"', 'CÁI', 8)
insert into HangHoa values ('MNT04', 'PHILIPS 14"', 'CÁI', 6)
insert into HangHoa values ('MNT05', 'VIEWSONIC 14"', 'CÁI', 7)

insert into DoiTac values ('CC001', N'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
insert into DoiTac values ('CC002', N'Cty Hoàng Long', N'15A TTT Q1 – TP. HCM', '08.8250898')
insert into DoiTac values ('CC003', N'Cty Hợp Nhất', N'152 BTX Q1 – TP.HCM', '08.8252376')
insert into DoiTac values ('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi Tp. Đà Lạt', '063.831129')
insert into DoiTac values ('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ. N.Trang', '058.590270')
insert into DoiTac values ('K0003', N'Trần nhật Duật', N'Lê Lợi TP. Huế', '054.848376');
insert into DoiTac values ('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi nghĩa- TP. Đà lạt', '063.823409')

insert into KhaNangCC values ('CC001', 'CPU01')
insert into KhaNangCC values ('CC001', 'HDD03')
insert into KhaNangCC values ('CC001', 'KB01')
insert into KhaNangCC values ('CC001', 'MB02')
insert into KhaNangCC values ('CC001', 'MB04')
insert into KhaNangCC values ('CC001', 'MNT01')
insert into KhaNangCC values ('CC002', 'CPU01');
insert into KhaNangCC values ('CC002', 'CPU02');
insert into KhaNangCC values ('CC002', 'CPU03');
insert into KhaNangCC values ('CC002', 'KB02');
insert into KhaNangCC values ('CC002', 'MB01');
insert into KhaNangCC values ('CC002', 'MB05');
insert into KhaNangCC values ('CC002', 'MNT03');
insert into KhaNangCC values ('CC003', 'HDD01');
insert into KhaNangCC values ('CC003', 'HDD02');
insert into KhaNangCC values ('CC003', 'HDD03');
insert into KhaNangCC values ('CC003', 'MB03');

set dateformat dmy;
insert into HoaDon values('N0001', '25/01/2006', 'CC001',null)
insert into HoaDon values('N0002', '01/05/2006', 'CC002',null)
insert into HoaDon values('X0001', '12/05/2006', 'K0001',null)
insert into HoaDon values('X0002', '16/06/2006', 'K0002',null)
insert into HoaDon values('X0003', '20/04/2006', 'K0001',null)

insert into CT_HoaDon values ('N0001', 'CPU01', 63, 10);
insert into CT_HoaDon values ('N0001', 'HDD03', 97, 7);
insert into CT_HoaDon values ('N0001', 'KB01', 3, 5);
insert into CT_HoaDon values ('N0001', 'MB02', 57, 5);
insert into CT_HoaDon values ('N0001', 'MNT01', 112, 3);
insert into CT_HoaDon values ('N0002', 'CPU02', 115, 3);
insert into CT_HoaDon values ('N0002', 'KB02', 5, 7);
insert into CT_HoaDon values ('N0002', 'MNT03', 111, 5);
insert into CT_HoaDon values ('X0001', 'CPU01', 67, 2);
insert into CT_HoaDon values ('X0001', 'HDD03', 100, 2);
insert into CT_HoaDon values ('X0001', 'KB01', 5, 2);
insert into CT_HoaDon values ('X0001', 'MB02', 62, 1);
insert into CT_HoaDon values ('X0002', 'CPU01', 67, 1);
insert into CT_HoaDon values ('X0002', 'KB02', 7, 3);
insert into CT_HoaDon values ('X0002', 'MNT01', 115, 2);
insert into CT_HoaDon values ('X0003', 'CPU01', 67, 1);
insert into CT_HoaDon values ('X0003', 'MNT03', 115, 2)

select * from HangHoa
select * from DoiTac;
select * from CT_HoaDon
select * from KhaNangCC;
select * from HoaDon;
---------------------------TRUY VẤN DỮ LIỆU---------------------------
--1. Liệt kê các mặt hàng thuộc loại đĩa cứng
select *
from dbo.HangHoa
where MaHH like 'CPU%' or MaHH like 'HDD%'

--2) Liêt kê các mặt hàng có số lượng tồn trên 10
select MaHH, TenHH, SoLuongTon
from dbo.HangHoa
where SoLuongTon > 10

--3) Thông tin về các nhà cung cấp ở TPHCM
select * 
from dbo.DoiTac
where MaDT like 'CC%' and DiaChi like '%TP.HCM'

--4) Liệt kê hóa đơn nhập hàng trong tháng 5/2006 gồm sohd, ngaylaphd, ten, diachi va dienthoainhacc, so mat hang
select SoHD, NgayLapHD, TenDT, DiaChi, DienThoai, count(MaHH) as SoMatHang
from dbo.HoaDon, dbo.DoiTac, dbo.KhaNangCC
where month(NgayLapHD) = '5' and year(NgayLapHD) = '2006' and SoHD like ('N%') and DoiTac.MaDT = HoaDon.MaDT and
HoaDon.MaDT = KhaNangCC.MaDT
group by SoHD, NgayLapHD, TenDT, DiaChi, DienThoai

--5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng
select distinct DoiTac.MaDT, TenDT
from dbo.DoiTac, dbo.KhaNangCC
where KhaNangCC.MaDT= DoiTac.MaDT and MaHH like 'CPU%' or MaHH like 'HDD%' and DoiTac.MaDT like 'CC%'

--6.Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng
--Hướng giải: Tìm tên các đối tác cung cấp/ mà không có hàng hóa thuộc loại đĩa cứng nào/ mà các đối tác đó không làm
select DT.TenDT
from dbo.DoiTac DT
where DT.MaDT in(
        select distinct KN.MaDT
		from dbo.KhaNangCC KN
		where KN.MaDT like 'CC%'
		and not exists (  select *
		                           from dbo.HangHoa HH
								   where HH.MaHH like 'CPU%' --OR HH.MaHH LIKE 'HDD%'
								   and not exists ( select *
								                             from dbo.KhaNangCC KN2
															 where KN2.MaHH = HH.MaHH and KN2.MaDT = KN.MaDT)))

--7.Cho biết tên các nhà cung cấp không cung cấp đĩa cứng
select DT.TenDT
from dbo.DoiTac DT
where DT.MaDT in(
       select distinct KN.MaDT
	   from dbo.KhaNangCC KN
	   where KN.MaDT like 'CC%'
	   and not exists (         select
	                                   * from dbo.HangHoa HH
									   where HH.MaHH like 'CPU%' --OR HH.MaHH LIKE 'HDD%'
									   and exists ( select   * 
									                            from dbo.KhaNangCC KN2
																where KN2.MaHH = HH.MaHH and KN2.MaDT = KN.MaDT)))

																
--8.Cho biết thông tin của mặt hàng chưa bán được
select HH1.MaHH, HH1.TenHH
from dbo.HangHoa HH1
where HH1.MaHH not in
                        ( select HH.MaHH
						  from dbo.CT_HoaDon CT, dbo.HangHoa HH
						  where CT.MaHH = HH.MaHH and CT.SoHD like 'X%')

--9.Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng)
select a.MaHH as N'Mã hàng hóa', TenHH as N'Tên hàng hóa', sum(c.SoLuong) as N'Số lượng'
from dbo.HangHoa a, dbo.HoaDon b, dbo.CT_HoaDon c
where a.MaHH = c.MaHH and b.SoHD = c.SoHD
group by a.MaHH, TenHH
having count(c.SoLuong) >= all(select count(SoLuong)
                                                    from dbo.CT_HoaDon
													group by MaHH)

--10) Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
select MaHH as N'Mã hàng hóa', TenHH as N'Tên hàng hóa', DVT as N'Đơn vị tính', SoLuongTon as N'Số lượng tồn'
from dbo.HangHoa
where SoLuongTon <= ALL(select SoLuongTon from dbo.HangHoa)

--11) Cho biết hóa đơn nhập nhiều mặt hàng nhiều nhất
select HD.SoHD
from dbo.HoaDon HD, dbo.CT_HoaDon CT1
where CT1.SoHD = HD.SoHD and HD.SoHD like N'%'
group by HD.SoHD
having count (CT1.MaHH) in
(                 select max(SHD.SoMH) as MaxHD
                  from (                          select count(CT.MaHH) as SoMH
				                                         from dbo.CT_HoaDon CT
														 where CT.SoHD like N'%'
														 group by CT.SoHD) as SHD)

--12.Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
select HH1.TenHH
from dbo.HangHoa as HH1
where HH1.MaHH not in
(                    select CT.MaHH
                     from dbo.HoaDon HD, dbo.CT_HoaDon CT
					 where HD.SoHD = CT.SoHD and month(HD.NgayLapHD) = 01 and year(HD.NgayLapHD) = 2006 and CT.SoHD like N'%')

--13.Cho biết tên các mặt hàng không bán được trong tháng 6/2006
select TenHH
from dbo.HangHoa
where MaHH not in 
(                 select CT.MaHH
                  from dbo.HoaDon HD, dbo.CT_HoaDon CT
				  where CT.SoHD = HD.SoHD and month(HD.NgayLapHD) = 06 and year(HD.NgayLapHD) = 2006 and CT.SoHD like 'X%')

--14.Cho biết cửa hàng bán bao nhiêu mặt hàng
select count(MaHH) as SoLuongMH
from dbo.HangHoa

--15.Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
select MaDT, count(MaHH) as SoMHCC
from dbo.KhaNangCC
group by MaDT

--16.Cho biết thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất
select HoaDon.MaDT, TenDT, DiaChi, DienThoai
from dbo.DoiTac, dbo.CT_HoaDon, dbo.HoaDon
where CT_HoaDon.SoHD = HoaDon.SoHD and DoiTac.MaDT = HoaDon.MaDT and DoiTac.MaDT LIKE 'K%'
group by HoaDon.MaDT, TenDT, DiaChi, DienThoai
having count(HoaDon.MaDT) in
					(	select max(SL.SLMua)
						from dbo.DoiTac,
										(	select count(HD.MaDT) as SLMua
											from dbo.HoaDon HD, dbo.CT_HoaDon CT
											where CT.SoHD = HD.SoHD and HD.SoHD like 'X%'
											group by HD.MaDT) as SL)

--17.Tính tổng doanh thu năm 2006
select sum (CT.DonGia * CT.SoLuong) as TongDoanhThu
from dbo.HoaDon HD, dbo.CT_HoaDon CT
where CT.SoHD like 'X%' and CT.SoHD = HD.SoHD and year(HD.NgayLapHD) = 2006

--18.Cho biết loại mặt hàng bán chạy nhất
select HH.TenHH
from dbo.HangHoa HH, dbo.CT_HoaDon CT
where HH.MaHH = CT.MaHH
group by CT.MaHH, HH.TenHH
having count(CT.MaHH) in
(       select max(SL.SLMua) 
        from ( select count(MaHH) SLMua
		          from dbo.CT_HoaDon
				  group by MaHH) as SL)

--19.Liệt kê thông tin bán hàng của tháng 5/2006
select HH.MaHH, HH.TenHH, HH.DVT, sum(CT.SoLuong) as TongSL, CT.DonGia * CT.SoLuong as TongTT
from dbo.HangHoa HH, dbo.CT_HoaDon CT, dbo.HoaDon HD
where CT.MaHH = HH.MaHH and HD.SoHD = CT.SoHD and CT.SoHD like 'X%' and month(HD.NgayLapHD) = 05 and year(HD.NgayLapHD) = 2006
group by HH.MaHH, HH.TenHH, HH.DVT, CT.DonGia, CT.SoLuong

--20.Liệt kê thông tin của mặt hàng có nhiều người mua nhất
select CT.MaHH
from dbo.CT_HoaDon CT, dbo.HangHoa HH
where CT.MaHH = HH.MaHH and CT.SoHD like 'X%'
group by CT.MaHH
having count(CT.SoHD) >= all
                             ( select count(MaHH)
							 from dbo.CT_HoaDon CT1
							 where CT1.SoHD like 'X%'
							 group by CT1.MaHH)

--21.Tính và cập nhật tổng trị giá của cá hóa đơn
update dbo.HoaDon set TongTG = (   select sum(DonGia * SoLuong)
                                                               from dbo.CT_HoaDon
															   where CT_HoaDon.SoHD = HoaDon.SoHD)

select * from dbo.HoaDon

------------------------------------
--hàm & thủ tục
------------------------------------
--a.Tính tổng số lượng nhập trong một khoảng thời gian của một mặt hàng cho trước
create function tongNhap(@maHH CHAR(5))
returns int
as
begin
   declare @soLuong int
     select @soLuong = sum(CT.SoLuong)
	 from dbo.CT_HoaDon CT
	 where @maHH = CT.MaHH and CT.SoHD like N'%'
	 return @soLuong
end
 --DROP FUNCTION dbo.tongNhap
 ----------------
print(N'Số lượng nhập trong một khoảng thời gian cho trước là:')
print dbo.tongNhap('CPU01')

--b.Tính tổng số lượng xuất trong một khoảng thơi gian của một mặt hàng cho trước
create function tongXuat(@maHH char(5))
returns int
as
begin
    declare @soLuong int
	   select @soLuong = sum(ct.SoLuong)
	   from dbo.CT_HoaDon ct
	   where @maHH = ct.MaHH and ct.SoHD like 'X%'
	   return @soLuong
end
 -------------------
print(N'Số lượng hàng hóa xuất là:')
print dbo.tongXuat('CPU01')

 --c.Tính tổng doanh thu trong một tháng cho trước
create function tongDoanhThu(@thang int)
returns int
as
begin
    declare @doanhThu int
	   select @doanhThu = sum(ct.DonGia * ct.SoLuong)
	   from dbo.HoaDon, dbo.CT_HoaDon ct
	   where @thang = month(NgayLapHD) and ct.SoHD like 'X%' and HoaDon.SoHD = ct.SoHD
	   return @doanhThu
end
 -------------
print dbo.tongDoanhThu(06)
 ---------------------------------
 --d.Tính tổng doanh tu của một mặt hàng trong một khoảng thời gian cho trước
create function tongDTHH(@maHH char(5), @thang datetime)
returns int
as
begin
  declare @doanhThu int
    select @doanhThu = sum(ct.DonGia * ct.SoLuong)
	from dbo.HoaDon, dbo.CT_HoaDon ct
	where @thang = NgayLapHD and ct.SoHD like 'X%' and HoaDon.SoHD = ct.SoHD and @maHH = ct.MaHH
	return @doanhThu
end

drop function tongDTHH
 ---------------------------
print dbo.tongDTHH('CPU01','05/12/2006')

--e.Tính tổng số tiền nhập hàng trong một khoảng thời gian cho trước
create function tongNhapHang(@time datetime)
returns int
as
begin 
   declare @tongTien int
      select @tongTien = sum(ct.DonGia * ct.SoLuong)
	  from dbo.HoaDon hd, dbo.CT_HoaDon ct
	  where @time = hd.NgayLapHD and ct.SoHD like 'N%' and ct.SoHD = hd.SoHD
	  return @tongTien
end
--DROP FUNCTION tongNhapHang
print dbo.tongNhapHang('05/01/2006')

--f.Tính tổng số tiền của một hóa đơn cho trước
create function tongTienHD(@soHD char(5))
returns int
as
begin
    declare @tongTien int
	select @tongTien = sum(DonGia*SoLuong) 
	from dbo.CT_HoaDon
	where @soHD=SoHD
	return @tongTien
end

print dbo.tongTienHD('N0001')
---------------------------------------
--Thủ tục
--a.Cập nhật số lượng tồn của một mặt hàng khi nhập hàng hoặc xuất hàng
create proc usp_CapNhatTon @maHH char(5)
as
	if exists(select * from dbo.HangHoa where MaHH = @maHH)
	begin
			    update dbo.HangHoa set SoLuongTon = (	select ct.SoLuong+SoLuongTon 
														from dbo.CT_HoaDon ct
														where ct.SoHD LIKE 'N%' AND MaHH=ct.MaHH AND @maHH=ct.MaHH
														) where HangHoa.MaHH=@maHH
	end
	else
		print(N'Không tồn tại hàng hóa!')
	go
	-----

    --DROP PROC usp_CapNhatTon
	-----------------------------------
	exec usp_CapNhatTon 'CPU01'
	select * from dbo.HangHoa

--b.Cập nhật tổng trị giá của một hóa đơn
create proc usp_TongTriGia @soHD char(5)
as
	if exists(	select *
				from dbo.HoaDon
				where SoHD=@soHD)
				begin
					update dbo.HoaDon set TongTG = (	select sum(ct.DonGia*ct.SoLuong)
														from dbo.CT_HoaDon ct
														where ct.SoHD=SoHD AND @soHD=ct.SoHD)
														where HoaDon.SoHD=@soHD
				end
	else 
		print(N'Không tồn tại hóa đơn')
	go
	drop proc usp_TongTriGia
    ------------------------
exec usp_TongTriGia 'N0001'
select * from dbo.HoaDon

update dbo.HoaDon set TongTG = NULL

--c.In đầy đủ thông tin của một hóa đơn
create proc usp_InHD @soHD char(5)
as
	if exists(	select *
				from dbo.HoaDon 
				where SoHD=@soHD)
				begin
				    select ct.SoHD, hd.NgayLapHD, hd.MaDT, sum(ct.SoLuong*ct.DonGia) as TONGTG, count(ct.SoHD) as SLHD
					from dbo.HoaDon hd,dbo.CT_HoaDon ct
					where hd.SoHD=@soHD AND hd.SoHD=ct.SoHD
					group by ct.SoHD,hd.NgayLapHD,hd.MaDT
				end
	else
		print(N'Hóa đơn không tồn tại')
go
---------------
exec usp_InHD 'N0002'
