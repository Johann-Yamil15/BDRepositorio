--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE
create database escuelita;
go

use escuelita;
go

CREATE TABLE StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go

INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)
go

CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go

INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)
go

select * from StudentsC1
select * from StudentsC2

delete from StudentsC2

select * from
StudentsC1 as c1
left join StudentsC2 as c2
on  c1.StudentID = c2.StudentID
where c2.StudentID is null;

select * from
StudentsC1 as c1
inner join
StudentsC2 as c2
on c1.StudentID = c2.StudentID;

-- crear un sp que inserte y actualise la tabla studen2
-- medinate los datos de  studen 1 utilizando consultas
-- left oin y inner join
go

create or alter procedure spu_carga_incremental_studens
as
begin
	begin transaction
	begin try
	--se insertan los estudiantes nuevos
	insert into StudentsC2 (StudentID, StudentName, StudentStatus)
	select c1.StudentID, c1.StudentName, c1.StudentStatus
	from
	StudentsC1 as c1
	left join StudentsC2 as c2
	on  c1.StudentID = c2.StudentID
	where c2.StudentID is null;

	-- se actulizan los datos que hayan cambiado en studen1
	update c2
	set c2.StudentName = c1.StudentName,
	c2.StudentStatus = c1.StudentStatus
	from
	StudentsC1 as c1
	inner join
	StudentsC2 as c2
	on c1.StudentID = c2.StudentID;

	commit transaction
	end try
	begin catch
	rollback transaction
	declare @mensajeError nvarchar(max)
	set @mensajeError = ERROR_MESSAGE()
	print @mensajeError
	end catch;
end
go

exec spu_carga_incremental_studens

truncate table STUDENTsc1
truncate table STUDENTsc2
go

-- crear un sp que inserte y actualise la tabla studen2
-- medinate merge
create or alter procedure spu_carga_incremental_studens_merge
as
begin
	begin transaction
	begin try
	MERGE INTO StudentsC2 AS TGT
	using(
	select  StudentID, StudentName, StudentStatus
	from StudentsC1
	) as src
	on (tgt.StudentID = src.StudentID)
	when matched  then
	update
	set tgt.StudentName = src.StudentName,
		tgt.StudentStatus = src.StudentStatus
	-- For insert
	when not matched then
	insert(StudentID,StudentName, StudentStatus)
	values(src.StudentID, src.StudentName, src.StudentStatus);

	commit transaction
	end try
	begin catch
	rollback transaction
	declare @mensajeError nvarchar(max)
	set @mensajeError = ERROR_MESSAGE()
	print @mensajeError
	end catch;
end
go

exec spu_carga_incremental_studens_merge;

insert into StudentsC1
values(6, 'josep abram', 1)

update StudentsC1
set StudentName = 'josep'
where StudentID = 6