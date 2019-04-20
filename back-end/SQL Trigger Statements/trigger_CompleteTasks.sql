/****** Object:  Trigger [dbo].[trigger_CompleteTasks]    Script Date: 4/19/2019 11:29:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[trigger_CompleteTasks]
	ON [dbo].[Tasks]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @id int
	DECLARE @oldStatusId int, @newStatusId int
	DECLARE @oldDeleteFlagStatus int
	DECLARE @oldProjectId int
	DECLARE @oldTaskName nvarchar(50)
	DECLARE @oldDesiredEndDateTime datetime
	DECLARE @newDescription nvarchar(200)
	DECLARE @oldStatusNotes nvarchar(50)
	DECLARE @oldEmployeeId int
	DECLARE @oldStartDate datetime


	SELECT * INTO #tempTable from inserted
	SELECT * INTO #tempTable2 from deleted

	While(EXISTS(Select taskId from #tempTable))
	Begin

		SELECT Top 1 @id = taskId, @newStatusId = status,
		@newDescription = description
		from #tempTable

		SELECT Top 1 @oldDeleteFlagStatus = deleteFlagStatus,
		@oldProjectId = projectId, @oldTaskName = taskName,
		@oldStatusNotes = statusNotes, @oldEmployeeId = employeeId,
		@oldDesiredEndDateTime = desiredEndDateTime,
		@oldStartDate = startDate
		from #tempTable2

		Select @oldStatusId = status FROM deleted where taskId = @id

		if (@newStatusId = 5 AND @oldStatusId <= 4)
			insert into Tasks(actualEndDateTime, deleteFlagStatus, projectId, taskName, status, employeeId, description, statusNotes, desiredEndDateTime, startDate) VALUES (CURRENT_TIMESTAMP, @oldDeleteFlagStatus, @oldProjectId, @oldTaskName, 
			@newStatusId, @oldEmployeeId, @newDescription, @oldStatusNotes, @oldDesiredEndDateTime,@oldStartDate)

		DELETE FROM #tempTable where taskId = @id
		END
END
