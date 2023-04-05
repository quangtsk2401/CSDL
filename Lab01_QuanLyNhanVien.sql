/* Học phần: Cơ sở dữ liệu
   Người thực hiện: ....
   MSSV: .....
   Ngày: .....
*/
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab01_QuanLyNhanVien
go
--lenh su dung CSDL
use Lab01_QuanLyNhanVien
go
--lenh tao cac bang
create table ChiNhanh
(MSCN	char(2) primary key,		 --khai bao MSCN la khoa chinh cua ChiNhanh
TenCN	nvarchar(30) not null unique --khai bao TenCN không được để trống và không được nhập trùng
)
go
create table KyNang
(MSKN	char(2) primary key,
TenKN	nvarchar(30) not null
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
Ngaysinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN)--khai báo MSCN là khóa ngoại của bảng NhanVien
)
go
create table NhanVienKyNang
(
MANV char(4) references NhanVien(MANV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=1)
primary key(MANV,MSKN)--Khai báo NhanVienKyNang có khóa chính gồm 2 thuộc tính (MaNV, MSKN)

)
-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhap du lieu cho cac bang
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình thạnh')
--xem bảng Chi nhanh
select * from ChiNhanh
--Nhap bang Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--Nhap bang NhanVien
set dateformat dmy
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn'	,'25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bang nhanvien
select * from NhanVien
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)

select * from NhanVienKyNang
----------------------------------------------------------------------
select * from ChiNhanh
select * from KyNang
select * from NhanVien
select * from NhanVienKyNang
----------------------------------------------------------------------
--------------------TRUY VẤN DỮ LIỆU---------------
--1.Truy vấn lựa chọn trên nhiều bảng
--a.Hiển thị MSNV, HoTen, Số năm làm việc
select MANV, Ho + ' ' + Ten as HoTen, year(getdate()) - year(NgayVaoLam) as SoNamLamViec
from dbo.NhanVien

--b.Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam,TenCN
select Ho + ' ' + Ten as HoTen, NgaySinh, NgayVaoLam, TenCN
from dbo.NhanVien as NV,dbo.ChiNhanh as CN
where NV.MSCN = CN.MSCN
order by CN.TenCN

--c.Liệt kê các nhân viên (HoTen,TenKN, MucDo) của những nhân viên biết sử dụng 'word'
select NV.Ho + ' ' + NV.Ten as HoTen, KN.TenKN, NVKN.MucDo
from dbo.NhanVien as NV, dbo.KyNang as KN, dbo.NhanVienKyNang as NVKN
where NV.MANV = NVKN.MANV and KN.MSKN = NVKN.MSKN and KN.TenKN = N'Word'

--d.Liệt kê các kỹ năng (TenKN, MucDo) mà nhân viên 'Lê Anh Tuấn' biết sử dụng
select KN.TenKN, NVKN.MucDo
from dbo.NhanVien as NV, dbo.KyNang as KN, dbo.NhanVienKyNang as NVKN
where NV.MANV = NVKN.MANV and KN.MSKN = NVKN.MSKN and NV.Ho + ' ' + NV.Ten = N'Lê Anh Tuấn'

--2.Truy vấn lồng
--a.Liệt kê MANV, HoTen,MSCN, TenCN của các nhân viên có mức độ thành thạo về 'Excel' cao nhất trong công ti
select a.MANV, Ho + ' ' + Ten as HoTen,b.MSCN,b.TenCN
from dbo.NhanVien a,dbo.ChiNhanh b,dbo.KyNang c,dbo.NhanVienKyNang d
where a.MANV = d.MANV and a.MSCN = b.MSCN and c.MSKN = d.MSKN and c.TenKN ='Excel'
	and d.MucDo = (select max(MucDo)
				   from dbo.NhanVienKyNang e , dbo.KyNang f
				   where e.MSKN=f.MSKN AND f.TenKN = 'Excel')

--b.Liệt kê MANV, HoTen, TenCN của các nhân viên vừa biết 'word' vừa biết 'excel'
select a.MANV, Ho + ' ' + Ten as HoTen, d.TenCN
from dbo.NhanVien a, dbo.KyNang c, dbo.NhanVienKyNang b, dbo.ChiNhanh d
where a.MANV = b.MANV and b.MSKN = c.MSKN and a.MSCN = d.MSCN and TenKN = 'Word'
	and a.MANV in (select e.MANV
				   from dbo.NhanVienKyNang e , dbo.KyNang f
				   where e.MSKN = f.MSKN and TenKN = 'Excel')
--c.Với từng kỹ năng, hãy liệt kê các thông tin (MANV, HoTen, TenCN, TenKN, MucDo) của những nhân viên thành thạo kỹ năng đó nhất
select a.MANV, Ho + ' ' + Ten as HoTen, d.TenCN, c.TenKN, b.MucDo
from dbo.NhanVien a, dbo.KyNang c, dbo.NhanVienKyNang b, dbo.ChiNhanh d
where a.MANV = b.MANV and b.MSKN = c.MSKN and a.MSCN = d.MSCN
	and b.MucDo = (select max(e.MucDo)
				   from dbo.NhanVienKyNang e
				   where e.MSKN = b.MSKN )
--d.Liệt kê các chi nhánh (MSCN, TenCN) mà mọi nhân viên trong chi nhánh đó đều biết 'Word'
select b.MSCN, b.TenCN
from dbo.NhanVien a, dbo.ChiNhanh b, dbo.KyNang c, dbo.NhanVienKyNang d
where a.MANV = d.MANV and a.MSCN = b.MSCN and c.MSKN = d.MSKN and TenKN = 'Word'
	and exists (select *
				   from dbo.NhanVienKyNang e , dbo.KyNang f
				   where e.MSKN = c.MSKN and f.TenKN = 'Word' and e.MANV = a.MANV and e.MSKN = c.MSKN)
				   group by b.MSCN, b.TenCN

--3.Truy vấn gom nhóm dữ liệu
--a.với mỗi chi nhánh, hãy cho biết các thông tin sau: TenCN, SoNV
select cn.TenCN, count(nv.MANV) as SoNV
from dbo.ChiNhanh as cn, dbo.NhanVien as nv
where cn.MSCN = nv.MSCN
group by cn.TenCN

--b.Với mỗi kỹ năng hãy cho biết TenKN, SoNguoiDung
select kn.TenKN, count(nvkn.MANV) as SoNguoiDung
from dbo.KyNang as kn, dbo.NhanVienKyNang as nvkn
where kn.MSKN = nvkn.MSKN
group by kn.TenKN

--c.Cho biết TenKN có từ 3 nhân viên trong công ty sử dụng trở lên
select kn.TenKN 
from dbo.KyNang as kn, dbo.NhanVienKyNang as nvkn
where kn.MSKN = nvkn.MSKN 
group by kn.TenKN
having count(nvkn.MANV) >=3

--d.Cho biết TenCN có nhiều nhân viên nhất
select TenCN 
from dbo.ChiNhanh, dbo.NhanVien
where NhanVien.MSCN = ChiNhanh.MSCN 
group by TenCN
having count(MANV) in
(select max(SLNV.SoLuong) as MaxSL
  from  dbo.ChiNhanh, dbo.NhanVien, (
										select count(MANV) as SoLuong
										from dbo.ChiNhanh, dbo.NhanVien
										where NhanVien.MSCN = ChiNhanh.MSCN  
										group by TenCN) as SLNV)

--e.Cho biết tên CN có ít nhân viên nhất
select TenCN 
from dbo.ChiNhanh, dbo.NhanVien
where NhanVien.MSCN = ChiNhanh.MSCN 
group by TenCN
having count(MANV) in
(select min(SLNV.SoLuong) as MaxSL
	from dbo.ChiNhanh, dbo.NhanVien, (
										select(MANV) as SoLuong
										from dbo.ChiNhanh, dbo.NhanVien
										where NhanVien.MSCN = ChiNhanh.MSCN  
										group by TenCN) as SLNV)

--f.Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được
select nvkn.MANV, nv.Ho + ' ' + nv.Ten as HoTen, count(nvkn.MSKN) as SLKN
from dbo.NhanVien as nv, dbo.NhanVienKyNang as nvkn
where nv.MANV = nvkn.MANV
group by nvkn.MANV, nv.Ho + ' ' + nv.Ten

--g.cho biết HoTen, TenCN của nhân viên sử dụng nhiều kỹ năng nhất
SELECT Ho+' '+Ten AS HoTen,TenCN
FROM dbo.NhanVien,dbo.ChiNhanh,dbo.NhanVienKyNang
WHERE NhanVien.MANV=NhanVienKyNang.MANV AND ChiNhanh.MSCN=NhanVien.MSCN
GROUP BY Ho+' '+Ten,TenCN
HAVING COUNT(MSKN) in
		(SELECT MAX(NVSL.SLKN)
		FROM (	SELECT COUNT(nvkn.MSKN) AS SLKN 
				FROM dbo.NhanVien nv,dbo.NhanVienKyNang nvkn
				WHERE nv.MANV=nvkn.MANV
				GROUP BY nvkn.MANV) AS NVSL)

--4.Cập nhật dữ liệu
--a.Thêm bộ <'06','photoshop'> vào bảng KyNang
insert into dbo.KyNang
values
(   '06', -- MSKN - char(2)
    N'PhotoShop' -- TenKN - nvarchar(30)
    )
select * from dbo.KyNang

--b.Thêm các bộ sau vào bảng NhanVienKyNang
insert into dbo.NhanVienKyNang
values
(   '0001', -- MANV - char(4)
    '06', -- MSKN - char(2)
    3   -- MucDo - tinyint
    )
insert into dbo.NhanVienKyNang
values
(   '0005', -- MANV - char(4)
    '06', -- MSKN - char(2)
    2   -- MucDo - tinyint
    )
select * from dbo.NhanVienKyNang

--c.Cập nhật cho các nhân viên có sử dụng kỹ anwng 'word' có mức độ tăng thêm một bậc
update dbo.NhanVienKyNang set MucDo = MucDo + 1
where MSKN = '01'
select * from dbo.NhanVienKyNang

--d.Tạo bảng mới NhanVienChiNhanh1
create table NhanVienChiNhanh1(
	MANV char(4) references dbo.NhanVien(MANV),
	HoTen nvarchar(30),
	SoKyNang tinyint,
	primary key(MANV)
)
drop table dbo.NhanVienChiNhanh1
--e.Thêm vào bảng trên các thông tin như đã liệt kê của các nhân viên thuộc chi nhánh 1
insert into dbo.NhanVienChiNhanh1
values
(   '0001',  -- MANV - char(4)
    N'Lê Văn Minh', -- HoTen - nvarchar(30)
    3    -- SoKyNang - tinyint
    )
	select * from dbo.NhanVienChiNhanh1