/*create on the central server*/ 

CREATE DATABASE [Auditing]

USE [Auditing]
GO

/****** Object:  Table [dbo].[AuditChanges]    Script Date: 10/29/2019 10:34:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'AuditChanges')
BEGIN

CREATE TABLE [dbo].[AuditChanges](
	[event_time] [datetime2](7) NOT NULL,
	[statement] [nvarchar](4000) NULL,
	[server_instance_name] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[schema_name] [nvarchar](128) NULL,
	[session_server_principal_name] [nvarchar](128) NULL,
	[server_principal_name] [nvarchar](128) NULL,
	[object_Name] [nvarchar](128) NULL,
	[file_name] [nvarchar](260) NOT NULL,
	[client_ip] [nvarchar](128) NULL,
	[application_name] [nvarchar](128) NULL
) ON [PRIMARY]


SET ANSI_PADDING ON


/****** Object:  Index [CIX_EventTime_User_Server_DB]    Script Date: 10/29/2019 10:34:49 AM ******/
CREATE CLUSTERED INDEX [CIX_EventTime_User_Server_DB] ON [dbo].[AuditChanges]
(
	[event_time] ASC,
	[session_server_principal_name] ASC,
	[server_instance_name] ASC,
	[database_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END 


