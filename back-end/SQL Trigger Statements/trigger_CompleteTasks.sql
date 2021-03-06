/****** Object:  Trigger [dbo].[trigger_CompleteTasks]    Script Date: 4/21/2019 12:06:29 AM ******/
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
		IF UPDATE(status)
		BEGIN
		UPDATE Tasks
		SET actualEndDateTime= CURRENT_TIMESTAMP
		FROM Tasks T INNER JOIN Inserted I
		ON T.taskId = I.taskId
		WHERE I.status = 5
		END
END
