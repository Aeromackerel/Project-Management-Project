USE [master]
GO
/****** Object:  Database [Project_Management_DB]    Script Date: 3/24/2019 12:45:54 PM ******/
CREATE DATABASE [Project_Management_DB]
GO
ALTER DATABASE [Project_Management_DB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Project_Management_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Project_Management_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Project_Management_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Project_Management_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Project_Management_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Project_Management_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [Project_Management_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Project_Management_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Project_Management_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Project_Management_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Project_Management_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Project_Management_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Project_Management_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Project_Management_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Project_Management_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Project_Management_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Project_Management_DB] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [Project_Management_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Project_Management_DB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Project_Management_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Project_Management_DB] SET  MULTI_USER 
GO
ALTER DATABASE [Project_Management_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Project_Management_DB] SET ENCRYPTION ON
GO
ALTER DATABASE [Project_Management_DB] SET QUERY_STORE = ON
GO
ALTER DATABASE [Project_Management_DB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [Project_Management_DB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 3/24/2019 12:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 3/24/2019 12:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[departmentId] [int] IDENTITY(1,1) NOT NULL,
	[departmentName] [varchar](50) NOT NULL,
	[departmentHead_ID] [int] NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[departmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 3/24/2019 12:46:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[employeeId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](20) NOT NULL,
	[middleInitial] [char](1) NULL,
	[lastName] [varchar](20) NOT NULL,
	[phoneNumber] [varchar](13) NOT NULL,
	[email] [varchar](40) NOT NULL,
	[role] [int] NOT NULL,
	[departmentId] [int] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[employeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 3/24/2019 12:46:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[eventId] [int] NOT NULL,
	[eventName] [varchar](30) NOT NULL,
	[startDateTime] [smalldatetime] NOT NULL,
	[endDateTime] [smalldatetime] NOT NULL,
	[location] [varchar](30) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[createdBy] [int] NULL,
	[lastUpdated] [date] NOT NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[eventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventsUsers]    Script Date: 3/24/2019 12:46:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventsUsers](
	[eventId] [int] NOT NULL,
	[employeeId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 3/24/2019 12:46:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[groupId] [int] NOT NULL,
	[groupManagerId] [int] NOT NULL,
	[projectId] [int] NOT NULL,
	[groupName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[groupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupsUsers]    Script Date: 3/24/2019 12:46:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupsUsers](
	[groupId] [int] NOT NULL,
	[employeeId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookup_Roles]    Script Date: 3/24/2019 12:46:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lookup_Roles](
	[roleId] [int] NOT NULL,
	[roleName] [varchar](20) NOT NULL,
	[roleBasePay] [decimal](3, 2) NOT NULL,
 CONSTRAINT [PK_Lookup_Roles] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookup_Status]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lookup_Status](
	[statusId] [int] NOT NULL,
	[statusName] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Status_Lookup] PRIMARY KEY CLUSTERED 
(
	[statusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectCosts]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectCosts](
	[projectId] [int] NOT NULL,
	[totalBudget] [decimal](8, 2) NOT NULL,
	[maintainenceCosts] [decimal](7, 2) NOT NULL,
	[totalCosts] [decimal](7, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[projectId] [int] IDENTITY(1,1) NOT NULL,
	[status] [int] NOT NULL,
	[projectManagerId] [int] NOT NULL,
	[departmentId] [int] NOT NULL,
	[startDate] [smalldatetime] NOT NULL,
	[predictedEndDate] [smalldatetime] NOT NULL,
	[actualEndDate] [smalldatetime] NULL,
	[projectName] [varchar](25) NOT NULL,
	[projectClient] [varchar](30) NULL,
	[createdBy] [int] NOT NULL,
	[lastUpdatedBy] [int] NOT NULL,
	[dateUpdated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[projectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectUsers]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectUsers](
	[employeeId] [int] NOT NULL,
	[projectId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[taskId] [int] IDENTITY(1,1) NOT NULL,
	[projectId] [int] NOT NULL,
	[taskName] [varchar](50) NOT NULL,
	[status] [int] NOT NULL,
	[startDate] [date] NULL,
	[desiredEndDateTime] [datetimeoffset](7) NOT NULL,
	[actualEndDateTime] [datetimeoffset](7) NULL,
	[description] [varchar](70) NOT NULL,
	[statusNotes] [varchar](50) NULL,
	[employeeId] [int] NOT NULL,
	[createdBy] [int] NOT NULL,
	[lastUpdatedBy] [int] NOT NULL,
	[dateUpdated] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[taskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timesheet]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timesheet](
	[timeSheetId] [int] NOT NULL,
	[projectId] [int] NOT NULL,
	[employeeId] [int] NOT NULL,
	[weekStartDate] [date] NOT NULL,
	[weekEndDate] [date] NOT NULL,
	[weeklyHours] [float] NOT NULL,
	[updatedBy] [int] NOT NULL,
	[updated_at] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_Timesheet] PRIMARY KEY CLUSTERED 
(
	[timeSheetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/24/2019 12:46:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[email] [varchar](40) NOT NULL,
	[password] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_departmentName]    Script Date: 3/24/2019 12:46:04 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_departmentName] ON [dbo].[Departments]
(
	[departmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Login_unique_email]    Script Date: 3/24/2019 12:46:04 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Login_unique_email] ON [dbo].[Users]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_departmentHead_employeeID] FOREIGN KEY([departmentHead_ID])
REFERENCES [dbo].[Employees] ([employeeId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_departmentHead_employeeID]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_related_to_department] FOREIGN KEY([departmentId])
REFERENCES [dbo].[Departments] ([departmentId])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_related_to_department]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_roleId_lookup] FOREIGN KEY([employeeId])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_roleId_lookup]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [createdBy_employee] FOREIGN KEY([createdBy])
REFERENCES [dbo].[Employees] ([employeeId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [createdBy_employee]
GO
ALTER TABLE [dbo].[EventsUsers]  WITH CHECK ADD  CONSTRAINT [FK_eventCheck] FOREIGN KEY([eventId])
REFERENCES [dbo].[Events] ([eventId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventsUsers] CHECK CONSTRAINT [FK_eventCheck]
GO
ALTER TABLE [dbo].[EventsUsers]  WITH CHECK ADD  CONSTRAINT [userEmployeeCheck] FOREIGN KEY([employeeId])
REFERENCES [dbo].[Employees] ([employeeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventsUsers] CHECK CONSTRAINT [userEmployeeCheck]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_groupManager] FOREIGN KEY([groupManagerId])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_groupManager]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [projectExists] FOREIGN KEY([projectId])
REFERENCES [dbo].[Projects] ([projectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [projectExists]
GO
ALTER TABLE [dbo].[GroupsUsers]  WITH CHECK ADD  CONSTRAINT [employeeCheck] FOREIGN KEY([employeeId])
REFERENCES [dbo].[Employees] ([employeeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupsUsers] CHECK CONSTRAINT [employeeCheck]
GO
ALTER TABLE [dbo].[GroupsUsers]  WITH CHECK ADD  CONSTRAINT [groupCheck] FOREIGN KEY([groupId])
REFERENCES [dbo].[Groups] ([groupId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupsUsers] CHECK CONSTRAINT [groupCheck]
GO
ALTER TABLE [dbo].[ProjectCosts]  WITH CHECK ADD  CONSTRAINT [projectCheck] FOREIGN KEY([projectId])
REFERENCES [dbo].[Projects] ([projectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectCosts] CHECK CONSTRAINT [projectCheck]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_createdBy] FOREIGN KEY([createdBy])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_createdBy]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_belongs_to_Department] FOREIGN KEY([departmentId])
REFERENCES [dbo].[Departments] ([departmentId])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_belongs_to_Department]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_relates_to_status] FOREIGN KEY([status])
REFERENCES [dbo].[Lookup_Status] ([statusId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_relates_to_status]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_updatedBy] FOREIGN KEY([lastUpdatedBy])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_updatedBy]
GO
ALTER TABLE [dbo].[ProjectUsers]  WITH CHECK ADD  CONSTRAINT [FK_employeeCheck] FOREIGN KEY([employeeId])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[ProjectUsers] CHECK CONSTRAINT [FK_employeeCheck]
GO
ALTER TABLE [dbo].[ProjectUsers]  WITH CHECK ADD  CONSTRAINT [FK_projectCheck] FOREIGN KEY([projectId])
REFERENCES [dbo].[Projects] ([projectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectUsers] CHECK CONSTRAINT [FK_projectCheck]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_belongs_to_employee] FOREIGN KEY([employeeId])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_belongs_to_employee]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_created_by] FOREIGN KEY([createdBy])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_created_by]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_related_to_Project] FOREIGN KEY([projectId])
REFERENCES [dbo].[Projects] ([projectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_related_to_Project]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_updated_by] FOREIGN KEY([lastUpdatedBy])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_updated_by]
GO
ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD  CONSTRAINT [FK__Timesheet__belongs_to_project] FOREIGN KEY([projectId])
REFERENCES [dbo].[Projects] ([projectId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Timesheet] CHECK CONSTRAINT [FK__Timesheet__belongs_to_project]
GO
ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD  CONSTRAINT [FK_Timesheet_belongs_to_employee] FOREIGN KEY([employeeId])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Timesheet] CHECK CONSTRAINT [FK_Timesheet_belongs_to_employee]
GO
ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD  CONSTRAINT [FK_Timesheet_updated_by] FOREIGN KEY([updatedBy])
REFERENCES [dbo].[Employees] ([employeeId])
GO
ALTER TABLE [dbo].[Timesheet] CHECK CONSTRAINT [FK_Timesheet_updated_by]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_email] FOREIGN KEY([email])
REFERENCES [dbo].[Employees] ([email])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_email]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [check_nonNumeric_deptName] CHECK  ((NOT [departmentName] like '%[^A-Z]%'))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [check_nonNumeric_deptName]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [check_nonNumerics] CHECK  ((NOT [firstName] like '%[^A-Z]%' AND NOT [middleInitial] like '%[^A-Z]%' AND NOT [lastName] like '%[^A-Z]%'))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [check_nonNumerics]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [check_phone] CHECK  ((NOT [phoneNumber] like '%[^0-9]%'))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [check_phone]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [check_endDate_later_than_startDate] CHECK  (([endDateTime]>[startDateTime]))
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [check_endDate_later_than_startDate]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [check_lastUpdated_later_than_currentDate] CHECK  (([lastUpdated]<getdate()))
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [check_lastUpdated_later_than_currentDate]
GO
ALTER TABLE [dbo].[Lookup_Roles]  WITH CHECK ADD  CONSTRAINT [check_nonNegative_basePay] CHECK  (([roleBasePay]>(7.25)))
GO
ALTER TABLE [dbo].[Lookup_Roles] CHECK CONSTRAINT [check_nonNegative_basePay]
GO
ALTER TABLE [dbo].[Lookup_Roles]  WITH CHECK ADD  CONSTRAINT [check_roleName_nonNumerics] CHECK  ((NOT [roleName] like '%[0-9]%'))
GO
ALTER TABLE [dbo].[Lookup_Roles] CHECK CONSTRAINT [check_roleName_nonNumerics]
GO
ALTER TABLE [dbo].[Lookup_Status]  WITH CHECK ADD  CONSTRAINT [check_nonNumerics_statusName] CHECK  ((NOT [statusName] like '%[0-9]%'))
GO
ALTER TABLE [dbo].[Lookup_Status] CHECK CONSTRAINT [check_nonNumerics_statusName]
GO
ALTER TABLE [dbo].[ProjectCosts]  WITH CHECK ADD  CONSTRAINT [check_nonNegative_Costs] CHECK  (([totalBudget]>(0) AND [maintainenceCosts]>(0) AND [totalCosts]>(0)))
GO
ALTER TABLE [dbo].[ProjectCosts] CHECK CONSTRAINT [check_nonNegative_Costs]
GO
ALTER TABLE [dbo].[ProjectCosts]  WITH CHECK ADD  CONSTRAINT [check_postiveBudget] CHECK  (([totalBudget]>[totalCosts]))
GO
ALTER TABLE [dbo].[ProjectCosts] CHECK CONSTRAINT [check_postiveBudget]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [check_earlier_than_currentDate] CHECK  (([dateUpdated]>getdate()))
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [check_earlier_than_currentDate]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [check_start_later_than_end] CHECK  (([startDate]>[actualEndDate] AND [startDate]>[predictedEndDate]))
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [check_start_later_than_end]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [check_tasks_later_than_startDate] CHECK  (([startDate]>[desiredEndDateTime] AND [startDate]>[actualEndDateTime]))
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [check_tasks_later_than_startDate]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [check_tasks_Updated_earlier_than_current] CHECK  (([dateUpdated]>getdate()))
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [check_tasks_Updated_earlier_than_current]
GO
ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD  CONSTRAINT [check_starts_later_than_end] CHECK  (([weekStartDate]>[weekEndDate]))
GO
ALTER TABLE [dbo].[Timesheet] CHECK CONSTRAINT [check_starts_later_than_end]
GO
ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD  CONSTRAINT [check_timeSheet_updated_date] CHECK  (([updated_at]>getdate()))
GO
ALTER TABLE [dbo].[Timesheet] CHECK CONSTRAINT [check_timeSheet_updated_date]
GO
ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD  CONSTRAINT [check_timeSheet_weeklyHours] CHECK  (([weeklyHours]>(60.0) AND [weeklyHours]<(0.0)))
GO
ALTER TABLE [dbo].[Timesheet] CHECK CONSTRAINT [check_timeSheet_weeklyHours]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 3/24/2019 12:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 3/24/2019 12:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 3/24/2019 12:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 3/24/2019 12:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 3/24/2019 12:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 3/24/2019 12:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 3/24/2019 12:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
USE [master]
GO
ALTER DATABASE [Project_Management_DB] SET  READ_WRITE 
GO
