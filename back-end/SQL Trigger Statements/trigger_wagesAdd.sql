/****** Object:  Trigger [dbo].[wagesAdd]    Script Date: 4/22/2019 1:27:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[wagesAdd] ON [dbo].[Timesheet] 
FOR INSERT
AS
	declare @eId int;
	declare @role int;
	declare @pay decimal(5,2);
	declare @hours float;
	declare @pId int;

	select @eId=i.employeeId from inserted i;	
	select @role=e.role from Employees e where employeeId = @eId;	
	select @pay=r.roleBasePay from Lookup_Roles r where roleId=@role;	
	select @hours=i.hours from inserted i;
	select @pId=i.projectId from inserted i;

	update ProjectCosts
		set wagesCosts = wagesCosts + (@pay * @hours)
		where projectId = @pId;
           
