CREATE PROCEDURE print_procedure_definitions
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @proc_name sysname;
  DECLARE @cmd NVARCHAR(MAX);

  DECLARE proc_cursor CURSOR FOR
  SELECT name FROM sys.procedures;

  OPEN proc_cursor;

  FETCH NEXT FROM proc_cursor INTO @proc_name;

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @cmd = N'PRINT N''Procedure: ' + @proc_name + '''';
    EXEC sp_executesql @cmd;

    SET @cmd = N'sp_helptext ' + @proc_name;
    EXEC sp_executesql @cmd;

    FETCH NEXT FROM proc_cursor INTO @proc_name;
  END

  CLOSE proc_cursor;
  DEALLOCATE proc_cursor;
END
go
EXEC print_procedure_definitions;
go
