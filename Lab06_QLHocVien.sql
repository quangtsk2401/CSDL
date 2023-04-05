/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày:
*/
---------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab06_QLHocVien
go
use Lab06_QLHocVien
go
--lệnh tạo các bảng
create table CaHoc
(Ca			tinyint primary key,
GioBatDau	datetime,
GioKetThuc	datetime
)
go
create table GiaoVien
(MSGV		char(4) primary key,
HoGV		nvarchar(20),
TenGV		nvarchar(10),
DienThoai	varchar(11)
)
go
create table Lop
(MaLop	char(4) primary key,
TenLop	nvarchar(30),
NgayKG	datetime,
HocPhi	int,
Ca		tinyint references CaHoc(Ca),
SoTiet	int,
SoHV	int,
MSGV	char(4) references GiaoVien(MSGV)
)
go
create table HocVien
(MSHV		char(4) primary key,
Ho			nvarchar(20),
Ten			nvarchar(10),
NgaySinh	datetime,
Phai		nvarchar(4),
MaLop		char(4) references Lop(MaLop)
)
go
create table HocPhi
(
SoBL	char(6) primary key,
MSHV	char(4) references HocVien(MSHV),
NgayThu datetime,
SoTien	int,
NoiDung	nvarchar(50),
NguoiThu nvarchar(30)
)
go
-------------------
select * from CaHoc
select * from GiaoVien
select * from Lop
select * from HocVien
select * from HocPhi

--Cài đặt ràng buộc toàn vẹn
--a.giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó (giờ bắt đầu - giờ kết thúc <0)
create trigger UTG_CaHoc
on dbo.CaHoc
for insert 
as
begin
     declare @Count int = 0
	 select @Count = count(*) from inserted
	 where datepart(hour, inserted.GioBatDau) - datepart(hour, inserted.GioKetThuc) > 0

	 if(@Count > 0)
	 begin
	     print N'giờ kết thúc của một ca học không được trước giờ của ca học đó'
		     rollback tran
	end
end

--drop trigger UTG_CaHoc
--b.Sĩ số của một lớp học không quá 30 học viên và đúng bằng số học viên của lớp đó
create trigger UTG_siSo
on dbo.Lop
for insert
as
if update(MaLop) or update(SoHV)
begin
     declare @Count int = 0;
	      select @Count = count(*) from inserted
		  where inserted.SoHV > 30 and inserted.SoHV<>(select count(MSHV)
		                                                                    from dbo.HocVien
																			where MaLop = inserted.MaLop)
     if(@Count > 0)
	 begin
	       print N'Sĩ số của một lớp học không quá 30 học viên và đúng bằng số học viên'
		   rollback tran
	end
end

--drop trigger UTG_siSo

--c.Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học
create trigger UTG_hocPhi
on dbo.HocPhi
for insert 
as 
begin
   declare @Count int = 0;
       select @Count = count(*) from inserted
	   where inserted.SoTien > (select HocPhi
	                                         from dbo.Lop, dbo.HocVien
											 where MSHV = inserted.MSHV)
  if(@Count > 0)
  begin  
         print N'Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học'
		 rollback tran
  end
end

--drop.trigger UTG_hocPhi

--4.Tạo các hàm thủ tục sau:
--a.Thêm dữ liệu vào các bảng
create proc usp_ThemCaHoc @ca tinyint, @giobd time, @giokt time
as 
  if exists ( select * from dbo.CaHoc
                       where Ca = @ca
					   print N'Đã có ca học trong CSDL'
  else
       begin
	        insert into dbo.CaHoc
			values
			(    @ca,          -- Ca - tinyint
		        @giobd, -- GioBatDau - time(7)
		        @giokt  -- GioKetThuc - time(7)
		        )
			print N'Thêm ca thành công!'
		end

---------------
exec usp_ThemCaHoc 1,'7:30','10:45'
---------------------------

create proc usp_ThemGiaoVien @msgv char(4), @hogv nvarchar(20), @ten nvarchar(10), @dt varchar(6)
as
   if exists ( select * from dbo.GiaoVien where MSGV = @msgv)
        print N'Đã có giáo viên trong CSDL'
   else
       begin
	        insert into dbo.GiaoVien
			values
		    (   @msgv,  -- MSGV - char(4)
		        @hogv, -- HoGV - nvarchar(20)
		        @ten, -- TenGV - nvarchar(10)
		        @dt -- DienThoai - varchar(6)
		        )
				print N'Thêm giáo viên thành công'
		end

------------------------------------
exec usp_ThemGiaoVien 'G001',N'Lê Hoàng',N'Anh', '858936'
exec usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan', '845623'
exec usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng', '823456'
exec usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung', '841256'

------------------------------------

create proc usp_ThemLop @malop char(4), @tenlop varchar(15), @ngaykg datetime, @hocphi int, @ca tinyint, @sotiet tinyint, @sohv tinyint, @magv char(4)
as
  if exists ( select * from dbo.CaHoc where Ca = @ca) and exists( select * from dbo.GiaoVien where MSGV = @magv)
         begin
		     if exists ( select * from dbo.Lop where MaLop = @malop)
			             print N'Đã có lớp trong CSDL'
				else
				    begin
					     insert into dbo.Lop
						 VALUES
				    (   @malop,        -- MaLop - char(4)
				        @tenlop,        -- TenLop - varchar(15)
				        @ngaykg, -- NgayKG - datetime
				        @hocphi,         -- HocPhi - int
				        @ca,         -- Ca - tinyint
				        @sotiet,         -- SoTiet - tinyint
				        @sohv,         -- SoHV - tinyint
				        @magv         -- MSGV - char(4)
				        )
				    end
		  end
	else
		begin
		    if not exists (select * from dbo.CaHoc where Ca=@ca)
				print N'Không tồn tại ca học trong CSDL'
			else
				print N'Không tồn tại giáo viên trong CSDL'
		 end

------------------------------------------
set dateformat dmy
go
exec usp_ThemLop 'A075',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003'
exec usp_ThemLop 'E114',N'Excel 3-5-7','02/01/2008', 120000,1,45,3,'G003'
exec usp_ThemLop 'A115',N'Excel 2-4-6','22/01/2008', 120000,3,45,0,'G001'
exec usp_ThemLop 'W123',N'Word 2-4-6','18/02/2008', 100000,3,30,1,'G001'
exec usp_ThemLop 'W124',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'

create proc usp_ThemHocVien @mshv char(10), @ho nvarchar(20), @ten nvarchar(10), @ns datetime, @phai nvarchar(3), @malop char(4)
as
	if exists (select * from dbo.Lop where MaLop = @malop)
		begin
		    if exists (select * from dbo.HocVien where MSHV = @mshv)
				print N'Đã tồn tại học viên trong CSDL'
			else
				begin
				    insert into dbo.HocVien
				    values
				    (   @mshv,        -- MSHV - char(10)
				        @ho,       -- Ho - nvarchar(20)
				        @ten,       -- Ten - nvarchar(10)
				        @ns, -- NgaySinh - datetime
				        @phai,        -- Phai - char(3)
				        @malop         -- MaLop - char(4)
				        )
						print N'Đã thêm dữ liệu vào bảng thành công'
				end
		end
	else
		print N'Không tồn tại lớp trong CSDL'

-------------------------
set dateformat dmy
go
exec usp_ThemHocVien 'A07501',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien 'A07502',N'Nguyễn Thị', N'Mai', '20/04/1988',N'Nữ', 'A075'
exec usp_ThemHocVien 'A07503',N'Lê Ngọc', N'Tuấn', '10/06/1984',N'Nam', 'A075'
exec usp_ThemHocVien 'E11401',N'Vương Tuấn', N'Vũ', '25/03/1979',N'Nam', 'E114'
exec usp_ThemHocVien 'E11402',N'Lý Ngọc', N'Hân', '01/12/1985',N'Nữ', 'E114'
exec usp_ThemHocVien 'E11403',N'Trần Mai', N'Linh', '04/06/1980',N'Nữ', 'E114'
exec usp_ThemHocVien 'W12301',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'
--------------------------------------

create proc usp_ThemHocPhi
@SoBL char(4),
@MSHV char(10),
@NgayThu datetime,
@SoTien int,
@NoiDung nvarchar(20),
@NguoiThu nvarchar(10)
as
   If exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có RBTV khóa ngoại
	  begin
		if exists(select * from HocPhi where SoBL = @SoBL) --kiểm tra có trùng khóa(SoBL) 
			print N'Đã có số biên lai học phí này trong CSDL!'
		else
		 begin
			insert into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
			print N'Thêm biên lai học phí thành công.'
		 end
	  end
	else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này!'
go
--------------------------
set dateformat dmy
go
exec usp_ThemHocPhi '0001','E11401','02/01/2008',120000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi '0002','E11402','02/01/2008',120000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi '0003','E11403','02/01/2008',80000,'HP Excel 3-5-7', N'Vân'
 
exec usp_ThemHocPhi '0005','A07501','16/12/2008',150000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0006','A07502','16/12/2008',100000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0007','A07503','18/12/2008',150000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi '0008','A07502','15/01/2009',50000,'HP Access 2-4-6', N'Vân'

delete from dbo.HocPhi

--b.Cập nhật thông tin của một học viên cho trước
create proc usp_UpdateHocVien @mshv char(10), @ho nvarchar(20), @ten nvarchar(10), @ns datetime, @phai nvarchar(3), @malop char(4)
as
	if exists (select * from dbo.HocVien where MSHV = @mshv) and exists (select * from dbo.Lop where MaLop = @malop)
		begin
		    update dbo.HocVien set Ho = @ho, Ten = @ten,NgaySinh = @ns, Phai = @phai, MaLop = @malop where MSHV = @mshv
			print N'Cập nhật dữ liệu của học viên ' + @mshv + N' thành công'
			select * from dbo.HocVien where MSHV = @mshv
		end
	else
		begin
			if not exists(select * from dbo.HocVien where MSHV = @mshv)
				print N'Không tìm thấy thông tin của học viên có mã số ' + @mshv + N' trong CSDL'
			else
				print N'Không tồn tại lớp' + @malop + N'Trong CSDL'
		end
go
---------------------------
drop proc dbo.usp_UpdateHocVien
exec usp_UpdateHocVien 'A07501',N'Lê Văn', N'Minh','06/10/1998','Nam','A075'

select * from dbo.HocVien

--c.Xóa một học viên cho trước
create proc usp_DeleteHocVien @mshv char(10)
as
	if exists(select * from dbo.HocVien where MSHV = @mshv)
		begin
			delete from dbo.HocPhi where MSHV = @mshv
		    delete from dbo.HocVien where MSHV = @mshv
			print N'Đã xóa thành công học viên ' + @mshv + N' ra khỏi CSDL'
		end
	else
		print N'Không tồn tại học viên ' + @mshv + N' Trong CSDL'
	
--------------------------
exec usp_DeleteHocVien 'W12301'

select * from dbo.HocVien

--d.Cập nhật thông tin của một lớp học cho trước
create proc usp_UpdateLop @malop char(4), @tenlop varchar(15), @ngaykg datetime, @hocphi int, @ca tinyint, @sotiet tinyint, @sohv tinyint, @magv char(4)
AS
	if exists (select * from dbo.Lop where MaLop = @malop)
		begin
		    if exists (select * from dbo.CaHoc where Ca = @ca) and exists(select * from dbo.GiaoVien where MSGV = @magv)
				begin
				    update dbo.Lop SET TenLop = @tenlop, NgayKG = @ngaykg, HocPhi = @hocphi, Ca  =@ca, SoTiet = @sotiet, SoHV = @sohv, MSGV = @magv where MaLop = @malop
					print N'Đã cập nhật thành công thông tin của lớp '+@malop
				end
			else
				begin
				    if not exists(select * from dbo.CaHoc where Ca = @ca)
						print N'Không tồn tại ca học trong CSDL'
					else 
						print N'Không tồn tại giáo viên trong CSDL'
				end
		 end
	else
		print N'Không tồn tại lớp ' + @malop + N' trong CSDL'
-------------------------
exec usp_UpdateLop 'W123', N'Word 4-6-8', '02/18/2008', 100000, 2, 30, 1, 'G004'

--e.Xóa một lớp học cho trước nếu lớp này không có học viên
create proc usp_DeleteLop @malop char(4)
as
	if exists (select * from dbo.Lop where MaLop = @malop and SoHV = 0)
		begin
			delete from dbo.HocVien where MaLop = @malop
		    delete from dbo.Lop where MaLop = @malop
			print N'Xóa thành công lớp ' + @malop
		end
	else
		begin
		    if not exists (select * from dbo.Lop where MaLop = @malop and SoHV = 0)
				print N'Không xóa được vì số học viên của lớp lớn hơn 0'
			else if not exists (select * from dbo.Lop where MaLop = @malop)
				print N'Không tồn tại mã lớp ' + @malop + N' trong CSDL' 
		end

----------------------------------------
exec usp_DeleteLop 'W124'
---------------------------------------

--f.Lập danh sách học viên của một lớp cho trước
create proc usp_LapDSLop @malop char(4)
as
	if exists(select * from dbo.Lop where MaLop = @malop)
		begin
		    select *
			from dbo.HocVien
			where MaLop = @malop
		end
	else
		print N'Không tồn tại lớp ' + @malop

--------------------------
exec usp_LapDSLop 'A075'
--------------------------

--g.Lập danh sách học viên chưa đóng đủ học phí của một lớp cho trước
create proc usp_DSHVChuaDuHP @malop char(4)
as 
	if exists (select * from dbo.Lop where MaLop = @malop)
		begin
		    select hv.MSHV, hv.Ho, hv.Ten, hv.MaLop
			from dbo.HocPhi hp, dbo.HocVien hv, dbo.Lop l
			where l.MaLop=hv.MaLop AND HV.MaLop=@malop AND l.MaLop=@malop AND HP.MSHV=HV.MSHV AND l.HocPhi-HP.SoTien>0
		end
	else
		begin
		    if not exists(select * from dbo.Lop where MaLop = @malop)
				print N'Không tồn tại lớp trong database!'
		end

exec usp_DSHVChuaDuHP 'A075'
--DROP PROC usp_DSHVChuaDuHP

------------------------------------
--Hàm 
------------------------------------
--Tính tổng số học phí đã thu được của một lớp khi biết mã lớp
create function tongHocPhiLop (@malop char(5))
returns int
as
begin
     declare @tongTien int
	        select @tongTien = sum(hp.SoTien)
			from dbo.HocPhi hp, dbo.HocVien hv, dbo.Lop l
			where hv.MaLop = l.MaLop and l.MaLop = @malop and hv.MSHV = hp.MSHV
			return @tongTien
end

print dbo.tongHocPhiLop('E114')
-----------------------------------------------------
--b.Tính tổng số học phí thu được trong một khoảng thời gian cho trước
create function tongHocPhiTime(@thoigian datetime)
returns int
as
begin
     declare @tongTien int
	 select @tongTien = sum(hp.SoTien)
	 from dbo.HocPhi hp
	 where hp.NgayThu = @thoigian
	 return @tongTien
end

PRINT dbo.tongHocPhiTime('02/01/2008')
--------------------------------------------------------
--c.Cho biết một học viên cho trước đã nộp đủ học phí hay chưa
create function nopHocPhi (@mshv char(10))
returns nvarchar(100)
as
begin
     if exists(select *from dbo.HocPhi where MSHV = @mshv)
	         begin
			      declare @count int = 0;
				select @count = count(*)
				  from dbo.HocVien hv, dbo.HocPhi hp, dbo.Lop l
				  where hv.MSHV = hp.MSHV and hp.MSHV = @mshv AND hv.MSHV = @mshv and l.HocPhi-hp.SoTien > 0 and l.MaLop = hv.MaLop

				  if(@count > 0)
				         return N'Học viên chưa nộp đủ học phí'
				  else
				         return N'Học viên đã nộp đủ học phí'
			  end

	 else
	          RETURN N'Không tồn tại học viên'

		      RETURN N'Không xác định'
end

SELECT dbo.nopHocPhi('E11401')
--DROP FUNCTION nopHocPhi

---------------------------------------------------