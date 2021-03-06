//this change is in test
USE [master]
GO
/****** Object:  Database [ERS_LMT]    Script Date: 04/15/2013 12:21:08 ******/
CREATE DATABASE [ERS_LMT] ON  PRIMARY 
( NAME = N'ERS_LMT', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\ERS_LMT.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'ERS_LMT_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\ERS_LMT_1.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ERS_LMT] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ERS_LMT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ERS_LMT] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [ERS_LMT] SET ANSI_NULLS OFF
GO
ALTER DATABASE [ERS_LMT] SET ANSI_PADDING OFF
GO
ALTER DATABASE [ERS_LMT] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [ERS_LMT] SET ARITHABORT OFF
GO
ALTER DATABASE [ERS_LMT] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [ERS_LMT] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [ERS_LMT] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [ERS_LMT] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [ERS_LMT] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [ERS_LMT] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [ERS_LMT] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [ERS_LMT] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [ERS_LMT] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [ERS_LMT] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [ERS_LMT] SET  DISABLE_BROKER
GO
ALTER DATABASE [ERS_LMT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [ERS_LMT] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [ERS_LMT] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [ERS_LMT] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [ERS_LMT] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [ERS_LMT] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [ERS_LMT] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [ERS_LMT] SET  READ_WRITE
GO
ALTER DATABASE [ERS_LMT] SET RECOVERY SIMPLE
GO
ALTER DATABASE [ERS_LMT] SET  MULTI_USER
GO
ALTER DATABASE [ERS_LMT] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [ERS_LMT] SET DB_CHAINING OFF
GO
USE [ERS_LMT]
GO
/****** Object:  Table [dbo].[aspnet_WebEvent_Events]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[aspnet_WebEvent_Events](
	[EventId] [char](32) NOT NULL,
	[EventTimeUtc] [datetime] NOT NULL,
	[EventTime] [datetime] NOT NULL,
	[EventType] [nvarchar](256) NOT NULL,
	[EventSequence] [decimal](19, 0) NOT NULL,
	[EventOccurrence] [decimal](19, 0) NOT NULL,
	[EventCode] [int] NOT NULL,
	[EventDetailCode] [int] NOT NULL,
	[Message] [nvarchar](1024) NULL,
	[ApplicationPath] [nvarchar](256) NULL,
	[ApplicationVirtualPath] [nvarchar](256) NULL,
	[MachineName] [nvarchar](256) NOT NULL,
	[RequestUrl] [nvarchar](1024) NULL,
	[ExceptionType] [nvarchar](256) NULL,
	[Details] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](150) NOT NULL,
	[DepartmentDetails] [nvarchar](max) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Department] ON
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [DepartmentDetails]) VALUES (1, N'Game', N'Too Much Gaming is done in this department')
SET IDENTITY_INSERT [dbo].[Department] OFF
/****** Object:  Table [dbo].[aspnet_Applications]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Applications](
	[ApplicationName] [nvarchar](256) NOT NULL,
	[LoweredApplicationName] [nvarchar](256) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ApplicationName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AllocationType]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllocationType](
	[AllocationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[AllocationTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_AllocationType1] PRIMARY KEY CLUSTERED 
(
	[AllocationTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AllocationActivity]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllocationActivity](
	[AllocationActivityID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[EmpID] [int] NOT NULL,
	[PercentAlloc] [float] NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[AllocationTypeId] [int] NULL,
	[Status] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[RequestID] [int] NULL,
	[Billed] [int] NULL,
	[Notify] [int] NULL,
	[ActivityDate] [smalldatetime] NULL,
	[ActivityBy] [nvarchar](100) NULL,
	[AllocationId] [int] NULL,
	[PercentBilling] [int] NULL,
 CONSTRAINT [PK_AllocationActivity] PRIMARY KEY CLUSTERED 
(
	[AllocationActivityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_SchemaVersions]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_SchemaVersions](
	[Feature] [nvarchar](128) NOT NULL,
	[CompatibleSchemaVersion] [nvarchar](128) NOT NULL,
	[IsCurrentVersion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Feature] ASC,
	[CompatibleSchemaVersion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResourceAllocationChron]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResourceAllocationChron](
	[ChronId] [int] NOT NULL,
	[LastExecutedOn] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestStatus](
	[RequestStatusID] [int] IDENTITY(1,1) NOT NULL,
	[RequestStatusName] [nvarchar](200) NOT NULL,
	[RequestStatusDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_requestStatus] PRIMARY KEY CLUSTERED 
(
	[RequestStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewCategories]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewCategories](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ReviewCategories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Final and calculated Rating could also be a category.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReviewCategories'
GO
INSERT [dbo].[ReviewCategories] ([CategoryID], [CategoryName]) VALUES (1, N'Quality')
INSERT [dbo].[ReviewCategories] ([CategoryID], [CategoryName]) VALUES (2, N'Communication')
INSERT [dbo].[ReviewCategories] ([CategoryID], [CategoryName]) VALUES (3, N'Teamwork')
INSERT [dbo].[ReviewCategories] ([CategoryID], [CategoryName]) VALUES (4, N'LineManager')
INSERT [dbo].[ReviewCategories] ([CategoryID], [CategoryName]) VALUES (5, N'Director')
/****** Object:  Table [dbo].[Level]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Level](
	[LevelID] [int] IDENTITY(1,1) NOT NULL,
	[LevelName] [nvarchar](100) NOT NULL,
	[LevelDetail] [nvarchar](max) NULL,
 CONSTRAINT [PK_Level] PRIMARY KEY CLUSTERED 
(
	[LevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Features]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Features] ON
INSERT [dbo].[Features] ([ID], [Description]) VALUES (1, N'LMEntry')
INSERT [dbo].[Features] ([ID], [Description]) VALUES (2, N'DirectorEntry')
INSERT [dbo].[Features] ([ID], [Description]) VALUES (3, N'Peer review list')
SET IDENTITY_INSERT [dbo].[Features] OFF
/****** Object:  Table [dbo].[MeetingTemplate]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MeetingTemplate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[Created] [datetime] NOT NULL,
 CONSTRAINT [pk_MeetingTemplate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectStatus](
	[ProjectStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectStatusName] [nvarchar](50) NOT NULL,
	[ProjectStatusDesc] [nvarchar](max) NULL,
 CONSTRAINT [PK_ProjectStatusDescription] PRIMARY KEY CLUSTERED 
(
	[ProjectStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](150) NULL,
	[SuggestedPM] [nvarchar](100) NULL,
	[SuggestedTeam] [nvarchar](255) NULL,
	[ProjectDetail] [nvarchar](255) NULL,
	[Status] [nvarchar](100) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[Director] [nvarchar](150) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ProjectName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Priority]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Priority](
	[PriorityID] [int] IDENTITY(1,1) NOT NULL,
	[PriorityName] [nvarchar](200) NOT NULL,
	[PriorityDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_priority] PRIMARY KEY CLUSTERED 
(
	[PriorityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [nvarchar](150) NOT NULL,
	[PositionDetails] [nvarchar](max) NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Position] ON
INSERT [dbo].[Position] ([PositionID], [PositionName], [PositionDetails]) VALUES (1, N'LSE', N'Lead Software Engineer')
INSERT [dbo].[Position] ([PositionID], [PositionName], [PositionDetails]) VALUES (2, N'SE', N'Software Engineer')
INSERT [dbo].[Position] ([PositionID], [PositionName], [PositionDetails]) VALUES (3, N'MD', N'Managing Director')
SET IDENTITY_INSERT [dbo].[Position] OFF
/****** Object:  Table [dbo].[TempHRList2]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempHRList2](
	[ID] [int] NULL,
	[Name ] [nvarchar](255) NULL,
	[Desgination] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempAlloc]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempAlloc](
	[Name] [nvarchar](255) NULL,
	[Role] [nvarchar](255) NULL,
	[Project] [nvarchar](255) NULL,
	[AllocPerProject] [float] NULL,
	[TotalAllocation] [float] NULL,
	[Status] [nvarchar](255) NULL,
	[FreeingOn] [datetime] NULL,
	[Director] [nvarchar](255) NULL,
	[ProjectType] [nvarchar](255) NULL,
	[RLManager] [nvarchar](255) NULL,
	[Projectid] [int] NULL,
	[EmpId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](20) NULL,
 CONSTRAINT [pk_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON
INSERT [dbo].[Roles] ([ID], [RoleName]) VALUES (1, N'Director')
INSERT [dbo].[Roles] ([ID], [RoleName]) VALUES (2, N'Line Manager')
INSERT [dbo].[Roles] ([ID], [RoleName]) VALUES (3, N'Line Managee')
SET IDENTITY_INSERT [dbo].[Roles] OFF
/****** Object:  Table [dbo].[Role]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[RoleDetails] [nvarchar](max) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewType]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewType](
	[ReviewTypeID] [int] NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ReviewType] PRIMARY KEY CLUSTERED 
(
	[ReviewTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ReviewType] ([ReviewTypeID], [TypeName]) VALUES (0, N'soli')
/****** Object:  Table [dbo].[Status]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (1, N'Completed')
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (2, N'Pending')
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (3, N'Drafted')
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (4, N'Consolidated')
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (5, N'Rejected')
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (6, N'NotAsked')
SET IDENTITY_INSERT [dbo].[Status] OFF
/****** Object:  Table [dbo].[TempProjList]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempProjList](
	[Projects] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TemplateSection]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TemplateSection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NOT NULL,
	[Caption] [varchar](100) NULL,
	[Type] [tinyint] NOT NULL,
	[Order] [tinyint] NOT NULL,
	[HasComments] [bit] NOT NULL,
	[LMRights] [tinyint] NOT NULL,
	[DirectorRights] [tinyint] NOT NULL,
	[ManageeRights] [tinyint] NOT NULL,
 CONSTRAINT [pk_TemplateSection] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Skill]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skill](
	[SkillID] [int] IDENTITY(1,1) NOT NULL,
	[SkillName] [nvarchar](100) NOT NULL,
	[SkillDetail] [nvarchar](max) NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_Skill] PRIMARY KEY CLUSTERED 
(
	[SkillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryWeightage]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryWeightage](
	[CategoryID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[Weightage] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FeatureID] [int] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Permissions] ON
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (1, 1, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (2, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (3, 2, 2)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (4, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (5, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (6, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (7, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (8, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (9, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (10, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (11, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (12, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (13, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (14, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (15, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (16, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (17, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (18, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (19, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (20, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (21, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (22, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (23, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (24, 2, 1)
INSERT [dbo].[Permissions] ([ID], [FeatureID], [RoleID]) VALUES (25, 2, 1)
SET IDENTITY_INSERT [dbo].[Permissions] OFF
/****** Object:  Table [dbo].[Questions]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionID] [int] NOT NULL,
	[Text] [nvarchar](50) NULL,
	[PositionID] [int] NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Paths]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Paths](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NOT NULL,
	[Path] [nvarchar](256) NOT NULL,
	[LoweredPath] [nvarchar](256) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Roles]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[LoweredRoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Users]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[MobileAlias] [nvarchar](16) NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[PositionID] [int] NULL,
	[DOJ] [datetime] NULL,
	[Email] [nvarchar](255) NULL,
	[YahooId] [nvarchar](255) NULL,
	[EmployeeStatus] [bit] NULL,
 CONSTRAINT [PK__Employee__AF2DBA7965370702] PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Employee__AF2DBA78681373AD] UNIQUE NONCLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (1, N'Tanveer', 2, CAST(0x0000902C00000000 AS DateTime), N'trk_1.6@hotmail.com', N'kuchbhee@yahoo.com', 1)
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (2, N'Imab', 1, CAST(0x000091B800000000 AS DateTime), N'imabasghar@hotmail.com', N'imabasghar@yahoo.com', 1)
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (3, N'Saad', 3, CAST(0x0000902800000000 AS DateTime), N'saadzmz@gmail.com', N'saadzaman@yahoo.com', 1)
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (4, N'Musa', 2, CAST(0x0000902400000000 AS DateTime), N'musaali@hotmail.com', N'musa@yahoo.com', 1)
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (5, N'John', 2, CAST(0x0000902000000000 AS DateTime), N'john', NULL, 1)
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (6, N'Sona', 2, CAST(0x0000902100000000 AS DateTime), N'sona', NULL, 1)
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (7, N'Jayce', 2, CAST(0x0000902200000000 AS DateTime), N'jayce', NULL, 1)
INSERT [dbo].[Employee] ([EmpID], [Name], [PositionID], [DOJ], [Email], [YahooId], [EmployeeStatus]) VALUES (8, NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Employee] OFF
/****** Object:  Table [dbo].[DirectorAllocation]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectorAllocation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DirectorID] [int] NOT NULL,
	[LMId] [int] NOT NULL,
	[DateOfAllocation] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [pk_DirectorAllocation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DirectorAllocation] ON
INSERT [dbo].[DirectorAllocation] ([ID], [DirectorID], [LMId], [DateOfAllocation], [IsActive]) VALUES (1, 2, 6, CAST(0x0000912B00000000 AS DateTime), 1)
INSERT [dbo].[DirectorAllocation] ([ID], [DirectorID], [LMId], [DateOfAllocation], [IsActive]) VALUES (2, 2, 1, CAST(0x00009A9300000000 AS DateTime), 1)
INSERT [dbo].[DirectorAllocation] ([ID], [DirectorID], [LMId], [DateOfAllocation], [IsActive]) VALUES (3, 6, 3, CAST(0x00009A9300000000 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[DirectorAllocation] OFF
/****** Object:  Table [dbo].[Choices]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Choices](
	[ChoiceID] [int] NOT NULL,
	[QuestionID] [int] NULL,
	[Choice] [nvarchar](50) NULL,
 CONSTRAINT [PK_Choices] PRIMARY KEY CLUSTERED 
(
	[ChoiceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_UsersInRoles]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Profile]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Profile](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [ntext] NOT NULL,
	[PropertyValuesString] [ntext] NOT NULL,
	[PropertyValuesBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationPerUser]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser](
	[Id] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationAllUsers]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers](
	[PathId] [uniqueidentifier] NOT NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Membership]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Membership](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[MobilePIN] [nvarchar](16) NULL,
	[Email] [nvarchar](256) NULL,
	[LoweredEmail] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
	[Comment] [ntext] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Allocation]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Allocation](
	[ProjectID] [int] NOT NULL,
	[EmpID] [int] NOT NULL,
	[PercentAlloc] [float] NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[AllocationTypeId] [int] NULL,
	[Status] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[RequestID] [int] NULL,
	[Billed] [int] NULL,
	[Notify] [int] NULL,
	[AllocationId] [int] IDENTITY(1,1) NOT NULL,
	[PercentBilling] [int] NULL,
 CONSTRAINT [pk_AllocationId] PRIMARY KEY CLUSTERED 
(
	[AllocationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMAllocation]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMAllocation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LMID] [int] NOT NULL,
	[ManageeId] [int] NOT NULL,
	[DateOfAllocation] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [pk_LMAllocation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[LMAllocation] ON
INSERT [dbo].[LMAllocation] ([ID], [LMID], [ManageeId], [DateOfAllocation], [IsActive]) VALUES (6, 2, 6, CAST(0x00009A9300000000 AS DateTime), 1)
INSERT [dbo].[LMAllocation] ([ID], [LMID], [ManageeId], [DateOfAllocation], [IsActive]) VALUES (7, 2, 4, CAST(0x00009A9300000000 AS DateTime), 1)
INSERT [dbo].[LMAllocation] ([ID], [LMID], [ManageeId], [DateOfAllocation], [IsActive]) VALUES (8, 1, 7, CAST(0x00009A9300000000 AS DateTime), 1)
INSERT [dbo].[LMAllocation] ([ID], [LMID], [ManageeId], [DateOfAllocation], [IsActive]) VALUES (9, 3, 1, CAST(0x00009A9300000000 AS DateTime), 1)
INSERT [dbo].[LMAllocation] ([ID], [LMID], [ManageeId], [DateOfAllocation], [IsActive]) VALUES (10, 1, 5, CAST(0x00009A9300000000 AS DateTime), 1)
INSERT [dbo].[LMAllocation] ([ID], [LMID], [ManageeId], [DateOfAllocation], [IsActive]) VALUES (11, 6, 3, CAST(0x00009A9300000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[LMAllocation] OFF
/****** Object:  Table [dbo].[EmployeeRole]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeRole](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmpID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
 CONSTRAINT [pk_EmployeeRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[EmployeeRole] ON
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (1, 1, 2, 1)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (2, 2, 1, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (3, 3, 2, 1)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (4, 4, 3, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (5, 1, 3, 1)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (6, 5, 3, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (7, 6, 2, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (8, 6, 1, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (9, 6, 3, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (10, 7, 3, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (11, 2, 2, 0)
INSERT [dbo].[EmployeeRole] ([ID], [EmpID], [RoleID], [IsAdmin]) VALUES (13, 3, 3, 1)
SET IDENTITY_INSERT [dbo].[EmployeeRole] OFF
/****** Object:  Table [dbo].[Review]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewId] [int] NOT NULL,
	[LMID] [int] NULL,
	[EmpID] [int] NULL,
	[ReviewerID] [int] NULL,
	[Date] [datetime] NULL,
	[Status] [int] NOT NULL,
	[ReviewTypeID] [int] NULL,
	[version] [int] NULL,
	[IsActive] [int] NULL,
	[feedback] [varchar](100) NOT NULL,
	[AReviewID] [int] NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (0, 1, 7, 7, CAST(0x0000A1A100533048 AS DateTime), 1, 0, 1, 0, N'Self', 0)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (1, 1, 7, 5, CAST(0x0000A1A100534503 AS DateTime), 5, 0, 1, 0, N'None', 1)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (2, 1, 7, 5, CAST(0x0000A1A10053B278 AS DateTime), 5, 0, 2, 0, N'Rejected', 1)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (3, 1, 7, 4, CAST(0x0000A1A1005581D0 AS DateTime), 5, 0, 1, 0, N'None', 3)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (4, 1, 7, 4, CAST(0x0000A1A10055BD9A AS DateTime), 1, 0, 2, 0, N'Rejected', 3)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (5, 1, 7, 5, CAST(0x0000A1A1005D37CD AS DateTime), 5, 0, 3, 0, N'Rejected', 1)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (6, 1, 7, 3, CAST(0x0000A1A1005DBAA9 AS DateTime), 5, 0, 1, 0, N'None', 6)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (8, 1, 5, 5, CAST(0x0000A1A1006390E6 AS DateTime), 2, 0, 1, 0, N'Self', 8)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (9, 1, 7, 5, CAST(0x0000A1A100695557 AS DateTime), 5, 0, 4, 0, N'Rejected', 1)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (10, 1, 7, 1, CAST(0x0000A1A1007ACB1F AS DateTime), 5, 0, 1, 0, N'Consolidation (LM)', 10)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (11, 1, 7, 1, CAST(0x0000A1A1007B19E0 AS DateTime), 5, 0, 2, 0, N'Rejected', 10)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (12, 1, 7, 1, CAST(0x0000A1A1007CD8B6 AS DateTime), 4, 0, 3, 0, N'Rejected', 10)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (13, 1, 7, 5, CAST(0x0000A1A100AB1D94 AS DateTime), 3, 0, 5, 0, N'Rejected', 1)
INSERT [dbo].[Review] ([ReviewId], [LMID], [EmpID], [ReviewerID], [Date], [Status], [ReviewTypeID], [version], [IsActive], [feedback], [AReviewID]) VALUES (14, 1, 7, 3, CAST(0x0000A1A100C945ED AS DateTime), 2, 0, 2, 0, N'Rejected', 6)
/****** Object:  Table [dbo].[RequestAllocation]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestAllocation](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[RequestorID] [int] NULL,
	[ProjectID] [int] NULL,
	[RequestTypeID] [int] NULL,
	[PercentAlloc] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[DateOfRequest] [datetime] NULL,
	[PriorityID] [int] NULL,
	[RequestStatusID] [int] NULL,
	[Comments] [nvarchar](max) NULL,
	[Billable] [int] NULL,
	[PercentBilling] [int] NULL,
 CONSTRAINT [PK_requestAllocation] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peers]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peers](
	[EmpID] [int] NOT NULL,
	[PeerID] [int] NOT NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Peers] ([EmpID], [PeerID], [IsActive]) VALUES (5, 4, 1)
INSERT [dbo].[Peers] ([EmpID], [PeerID], [IsActive]) VALUES (5, 7, 1)
INSERT [dbo].[Peers] ([EmpID], [PeerID], [IsActive]) VALUES (7, 3, 1)
INSERT [dbo].[Peers] ([EmpID], [PeerID], [IsActive]) VALUES (7, 4, 1)
INSERT [dbo].[Peers] ([EmpID], [PeerID], [IsActive]) VALUES (1, 4, NULL)
INSERT [dbo].[Peers] ([EmpID], [PeerID], [IsActive]) VALUES (1, 6, NULL)
/****** Object:  Table [dbo].[TechSkills]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TechSkills](
	[TechSkillID] [int] IDENTITY(1,1) NOT NULL,
	[EmpID] [int] NOT NULL,
	[SkillID] [int] NULL,
	[LevelID] [int] NULL,
	[Experience] [int] NULL,
	[Priority] [int] NULL,
 CONSTRAINT [PK_TechSkills] PRIMARY KEY CLUSTERED 
(
	[TechSkillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SectionOption]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SectionOption](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SectionId] [int] NOT NULL,
	[Caption] [varchar](100) NULL,
	[Order] [tinyint] NOT NULL,
 CONSTRAINT [pk_SectionOption] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReviewInfo]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewInfo](
	[ReviewId] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Rating] [decimal](18, 0) NULL,
	[Comments] [nvarchar](200) NULL,
 CONSTRAINT [PK_ReviewInfo] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (0, 1, CAST(2 AS Decimal(18, 0)), N'111')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (0, 2, CAST(2 AS Decimal(18, 0)), N'2222')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (0, 3, CAST(3 AS Decimal(18, 0)), N'4444')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (1, 1, CAST(1 AS Decimal(18, 0)), N'2sasad')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (1, 2, CAST(3 AS Decimal(18, 0)), N'4')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (1, 3, CAST(5 AS Decimal(18, 0)), N'6666666666')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (3, 1, CAST(1 AS Decimal(18, 0)), N'2')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (3, 2, CAST(2 AS Decimal(18, 0)), N'3')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (3, 3, CAST(3 AS Decimal(18, 0)), N'4')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (6, 1, CAST(2 AS Decimal(18, 0)), N'fff')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (6, 2, CAST(2 AS Decimal(18, 0)), N'ffs')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (6, 3, CAST(4 AS Decimal(18, 0)), N'ww')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (10, 1, CAST(1 AS Decimal(18, 0)), N'2')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (10, 2, CAST(2 AS Decimal(18, 0)), N'3')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (10, 3, CAST(4 AS Decimal(18, 0)), N'3')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (10, 4, CAST(1 AS Decimal(18, 0)), N'11212312')
INSERT [dbo].[ReviewInfo] ([ReviewId], [CategoryID], [Rating], [Comments]) VALUES (10, 5, CAST(4 AS Decimal(18, 0)), N'gdgsgdsefsdsddd@$@$$@$$@$@$#@$@$@@ :D')
/****** Object:  Table [dbo].[MeetingSchedule]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeetingSchedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LMAllocationId] [int] NOT NULL,
	[MDate] [datetime] NULL,
	[LastUpdated] [datetime] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Revision] [int] NOT NULL,
	[TemplateId] [int] NOT NULL,
	[IsHeld] [bit] NOT NULL,
 CONSTRAINT [pk_MeetingSchedule] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RedFlags]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RedFlags](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MSID] [int] NOT NULL,
	[LMNotes] [varchar](500) NULL,
	[DirectorNotes] [varchar](1000) NULL,
	[Severity] [varchar](30) NULL,
	[Tags] [varchar](50) NULL,
	[LastUpdated] [datetime] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Revision] [int] NOT NULL,
	[IsActive] [int] NULL,
	[Notify] [int] NULL,
	[DrAllocationId] [int] NOT NULL,
 CONSTRAINT [pk_RedFlags] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MeetingNotifications]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeetingNotifications](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MSID] [int] NOT NULL,
	[NotificationDate] [datetime] NOT NULL,
	[NotificationNo] [smallint] NOT NULL,
	[Created] [datetime] NOT NULL,
 CONSTRAINT [pk_MeetingNotifications] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MeetingNotes]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MeetingNotes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MSID] [int] NOT NULL,
	[LMNotes] [varchar](max) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Revision] [int] NOT NULL,
	[TemplateSectionId] [int] NOT NULL,
	[Comments] [varchar](max) NULL,
 CONSTRAINT [pk_MeetingNotes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 04/15/2013 12:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answers](
	[QuestionID] [int] NOT NULL,
	[MSID] [int] NOT NULL,
	[AnswerText] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC,
	[MSID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF__aspnet_Ap__Appli__20C1E124]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Applications] ADD  DEFAULT (newid()) FOR [ApplicationId]
GO
/****** Object:  Default [DF__TemplateS__LMRig__2C3393D0]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[TemplateSection] ADD  DEFAULT ((0)) FOR [LMRights]
GO
/****** Object:  Default [DF__TemplateS__Direc__2D27B809]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[TemplateSection] ADD  DEFAULT ((0)) FOR [DirectorRights]
GO
/****** Object:  Default [DF__TemplateS__Manag__2E1BDC42]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[TemplateSection] ADD  DEFAULT ((0)) FOR [ManageeRights]
GO
/****** Object:  Default [DF__aspnet_Pa__PathI__5535A963]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Paths] ADD  DEFAULT (newid()) FOR [PathId]
GO
/****** Object:  Default [DF__aspnet_Ro__RoleI__5812160E]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Roles] ADD  DEFAULT (newid()) FOR [RoleId]
GO
/****** Object:  Default [DF__aspnet_Us__UserI__5AEE82B9]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (newid()) FOR [UserId]
GO
/****** Object:  Default [DF__aspnet_Us__Mobil__5BE2A6F2]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (NULL) FOR [MobileAlias]
GO
/****** Object:  Default [DF__aspnet_Us__IsAno__5CD6CB2B]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT ((0)) FOR [IsAnonymous]
GO
/****** Object:  Default [DF__aspnet_Perso__Id__403A8C7D]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] ADD  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF__aspnet_Me__Passw__48CFD27E]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Membership] ADD  DEFAULT ((0)) FOR [PasswordFormat]
GO
/****** Object:  Default [DF__EmployeeR__IsAdm__35BCFE0A]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[EmployeeRole] ADD  DEFAULT ((0)) FOR [IsAdmin]
GO
/****** Object:  Default [DF__MeetingSc__Revis__30F848ED]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingSchedule] ADD  DEFAULT ((0)) FOR [Revision]
GO
/****** Object:  Default [DF__MeetingSc__Templ__31EC6D26]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingSchedule] ADD  DEFAULT ((1)) FOR [TemplateId]
GO
/****** Object:  Default [DF__MeetingSc__IsHel__32E0915F]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingSchedule] ADD  DEFAULT ((0)) FOR [IsHeld]
GO
/****** Object:  Check [chk_MeetingNotes]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingNotes]  WITH CHECK ADD  CONSTRAINT [chk_MeetingNotes] CHECK  (([Revision]>=(0)))
GO
ALTER TABLE [dbo].[MeetingNotes] CHECK CONSTRAINT [chk_MeetingNotes]
GO
/****** Object:  ForeignKey [FK_AllocationType_AllocationType]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[AllocationType]  WITH CHECK ADD  CONSTRAINT [FK_AllocationType_AllocationType] FOREIGN KEY([AllocationTypeID])
REFERENCES [dbo].[AllocationType] ([AllocationTypeID])
GO
ALTER TABLE [dbo].[AllocationType] CHECK CONSTRAINT [FK_AllocationType_AllocationType]
GO
/****** Object:  ForeignKey [fk_TemplateSection]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[TemplateSection]  WITH CHECK ADD  CONSTRAINT [fk_TemplateSection] FOREIGN KEY([TemplateId])
REFERENCES [dbo].[MeetingTemplate] ([ID])
GO
ALTER TABLE [dbo].[TemplateSection] CHECK CONSTRAINT [fk_TemplateSection]
GO
/****** Object:  ForeignKey [FK_Skill_Role]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Skill]  WITH CHECK ADD  CONSTRAINT [FK_Skill_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Skill] CHECK CONSTRAINT [FK_Skill_Role]
GO
/****** Object:  ForeignKey [FK_Category]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[CategoryWeightage]  WITH CHECK ADD  CONSTRAINT [FK_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ReviewCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[CategoryWeightage] CHECK CONSTRAINT [FK_Category]
GO
/****** Object:  ForeignKey [FK_Position]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[CategoryWeightage]  WITH CHECK ADD  CONSTRAINT [FK_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Position] ([PositionID])
GO
ALTER TABLE [dbo].[CategoryWeightage] CHECK CONSTRAINT [FK_Position]
GO
/****** Object:  ForeignKey [FK_Permissions_Features]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Features] FOREIGN KEY([FeatureID])
REFERENCES [dbo].[Features] ([ID])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Features]
GO
/****** Object:  ForeignKey [FK_Permissions_Role]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Role]
GO
/****** Object:  ForeignKey [FK_Questions_Position]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Position] ([PositionID])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Position]
GO
/****** Object:  ForeignKey [FK__aspnet_Pa__Appli__07C12930]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Paths]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK__aspnet_Ro__Appli__08B54D69]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Roles]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK__aspnet_Us__Appli__09A971A2]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK_Employee_Position]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Position] ([PositionID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Position]
GO
/****** Object:  ForeignKey [fk1_DirectorAllocation]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[DirectorAllocation]  WITH CHECK ADD  CONSTRAINT [fk1_DirectorAllocation] FOREIGN KEY([LMId])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[DirectorAllocation] CHECK CONSTRAINT [fk1_DirectorAllocation]
GO
/****** Object:  ForeignKey [fk2_DirectorAllocation]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[DirectorAllocation]  WITH CHECK ADD  CONSTRAINT [fk2_DirectorAllocation] FOREIGN KEY([DirectorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[DirectorAllocation] CHECK CONSTRAINT [fk2_DirectorAllocation]
GO
/****** Object:  ForeignKey [FK_Choices_Question]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Choices]  WITH CHECK ADD  CONSTRAINT [FK_Choices_Question] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[Choices] CHECK CONSTRAINT [FK_Choices_Question]
GO
/****** Object:  ForeignKey [FK__aspnet_Us__RoleI__797309D9]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[aspnet_Roles] ([RoleId])
GO
/****** Object:  ForeignKey [FK__aspnet_Us__UserI__7A672E12]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pr__UserI__7B5B524B]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Profile]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pe__PathI__76969D2E]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pe__UserI__778AC167]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pe__PathI__787EE5A0]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
/****** Object:  ForeignKey [FK__aspnet_Me__Appli__7C4F7684]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK__aspnet_Me__UserI__7D439ABD]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK_Allocation_AllocationType]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Allocation]  WITH CHECK ADD  CONSTRAINT [FK_Allocation_AllocationType] FOREIGN KEY([AllocationTypeId])
REFERENCES [dbo].[AllocationType] ([AllocationTypeID])
GO
ALTER TABLE [dbo].[Allocation] CHECK CONSTRAINT [FK_Allocation_AllocationType]
GO
/****** Object:  ForeignKey [fk1_Allocation]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Allocation]  WITH CHECK ADD  CONSTRAINT [fk1_Allocation] FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Allocation] CHECK CONSTRAINT [fk1_Allocation]
GO
/****** Object:  ForeignKey [fk2_Allocation]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Allocation]  WITH CHECK ADD  CONSTRAINT [fk2_Allocation] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[Allocation] CHECK CONSTRAINT [fk2_Allocation]
GO
/****** Object:  ForeignKey [fk1_LMAllocation]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[LMAllocation]  WITH CHECK ADD  CONSTRAINT [fk1_LMAllocation] FOREIGN KEY([LMID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[LMAllocation] CHECK CONSTRAINT [fk1_LMAllocation]
GO
/****** Object:  ForeignKey [fk2_LMAllocation]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[LMAllocation]  WITH CHECK ADD  CONSTRAINT [fk2_LMAllocation] FOREIGN KEY([ManageeId])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[LMAllocation] CHECK CONSTRAINT [fk2_LMAllocation]
GO
/****** Object:  ForeignKey [fk1_EmployeeRole]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[EmployeeRole]  WITH CHECK ADD  CONSTRAINT [fk1_EmployeeRole] FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[EmployeeRole] CHECK CONSTRAINT [fk1_EmployeeRole]
GO
/****** Object:  ForeignKey [fk2_EmployeeRole]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[EmployeeRole]  WITH CHECK ADD  CONSTRAINT [fk2_EmployeeRole] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[EmployeeRole] CHECK CONSTRAINT [fk2_EmployeeRole]
GO
/****** Object:  ForeignKey [FK_Review_Emp]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Emp] FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Emp]
GO
/****** Object:  ForeignKey [FK_Review_LM]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_LM] FOREIGN KEY([LMID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_LM]
GO
/****** Object:  ForeignKey [FK_Review_Reviewer]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Reviewer] FOREIGN KEY([ReviewerID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Reviewer]
GO
/****** Object:  ForeignKey [FK_Review_ReviewType]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_ReviewType] FOREIGN KEY([ReviewTypeID])
REFERENCES [dbo].[ReviewType] ([ReviewTypeID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_ReviewType]
GO
/****** Object:  ForeignKey [FK_Review_Status]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[Status] ([ID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Status]
GO
/****** Object:  ForeignKey [FK_requestAllocation_Employee]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[RequestAllocation]  WITH CHECK ADD  CONSTRAINT [FK_requestAllocation_Employee] FOREIGN KEY([RequestorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[RequestAllocation] CHECK CONSTRAINT [FK_requestAllocation_Employee]
GO
/****** Object:  ForeignKey [FK_requestAllocation_Position]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[RequestAllocation]  WITH CHECK ADD  CONSTRAINT [FK_requestAllocation_Position] FOREIGN KEY([RequestTypeID])
REFERENCES [dbo].[Position] ([PositionID])
GO
ALTER TABLE [dbo].[RequestAllocation] CHECK CONSTRAINT [FK_requestAllocation_Position]
GO
/****** Object:  ForeignKey [FK_requestAllocation_priority]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[RequestAllocation]  WITH CHECK ADD  CONSTRAINT [FK_requestAllocation_priority] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[Priority] ([PriorityID])
GO
ALTER TABLE [dbo].[RequestAllocation] CHECK CONSTRAINT [FK_requestAllocation_priority]
GO
/****** Object:  ForeignKey [FK_requestAllocation_Project]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[RequestAllocation]  WITH CHECK ADD  CONSTRAINT [FK_requestAllocation_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[RequestAllocation] CHECK CONSTRAINT [FK_requestAllocation_Project]
GO
/****** Object:  ForeignKey [FK_requestAllocation_requestStatus]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[RequestAllocation]  WITH CHECK ADD  CONSTRAINT [FK_requestAllocation_requestStatus] FOREIGN KEY([RequestStatusID])
REFERENCES [dbo].[RequestStatus] ([RequestStatusID])
GO
ALTER TABLE [dbo].[RequestAllocation] CHECK CONSTRAINT [FK_requestAllocation_requestStatus]
GO
/****** Object:  ForeignKey [FK_Peers_Employee]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Peers]  WITH CHECK ADD  CONSTRAINT [FK_Peers_Employee] FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Peers] CHECK CONSTRAINT [FK_Peers_Employee]
GO
/****** Object:  ForeignKey [FK_Peers_Employee1]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Peers]  WITH CHECK ADD  CONSTRAINT [FK_Peers_Employee1] FOREIGN KEY([PeerID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Peers] CHECK CONSTRAINT [FK_Peers_Employee1]
GO
/****** Object:  ForeignKey [FK_TechSkills_Level]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[TechSkills]  WITH CHECK ADD  CONSTRAINT [FK_TechSkills_Level] FOREIGN KEY([LevelID])
REFERENCES [dbo].[Level] ([LevelID])
GO
ALTER TABLE [dbo].[TechSkills] CHECK CONSTRAINT [FK_TechSkills_Level]
GO
/****** Object:  ForeignKey [FK_TechSkills_Skill]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[TechSkills]  WITH CHECK ADD  CONSTRAINT [FK_TechSkills_Skill] FOREIGN KEY([SkillID])
REFERENCES [dbo].[Skill] ([SkillID])
GO
ALTER TABLE [dbo].[TechSkills] CHECK CONSTRAINT [FK_TechSkills_Skill]
GO
/****** Object:  ForeignKey [fk_SectionOption]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[SectionOption]  WITH CHECK ADD  CONSTRAINT [fk_SectionOption] FOREIGN KEY([SectionId])
REFERENCES [dbo].[TemplateSection] ([ID])
GO
ALTER TABLE [dbo].[SectionOption] CHECK CONSTRAINT [fk_SectionOption]
GO
/****** Object:  ForeignKey [FK_ReviewInfo_Review]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[ReviewInfo]  WITH CHECK ADD  CONSTRAINT [FK_ReviewInfo_Review] FOREIGN KEY([ReviewId])
REFERENCES [dbo].[Review] ([ReviewId])
GO
ALTER TABLE [dbo].[ReviewInfo] CHECK CONSTRAINT [FK_ReviewInfo_Review]
GO
/****** Object:  ForeignKey [FK_ReviewInfo_ReviewCategories]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[ReviewInfo]  WITH CHECK ADD  CONSTRAINT [FK_ReviewInfo_ReviewCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ReviewCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ReviewInfo] CHECK CONSTRAINT [FK_ReviewInfo_ReviewCategories]
GO
/****** Object:  ForeignKey [fk_MeetingSchedule]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingSchedule]  WITH CHECK ADD  CONSTRAINT [fk_MeetingSchedule] FOREIGN KEY([LMAllocationId])
REFERENCES [dbo].[LMAllocation] ([ID])
GO
ALTER TABLE [dbo].[MeetingSchedule] CHECK CONSTRAINT [fk_MeetingSchedule]
GO
/****** Object:  ForeignKey [fk_MeetingTemplate]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingSchedule]  WITH CHECK ADD  CONSTRAINT [fk_MeetingTemplate] FOREIGN KEY([TemplateId])
REFERENCES [dbo].[MeetingTemplate] ([ID])
GO
ALTER TABLE [dbo].[MeetingSchedule] CHECK CONSTRAINT [fk_MeetingTemplate]
GO
/****** Object:  ForeignKey [fk_Red_DirectorAllocation]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[RedFlags]  WITH CHECK ADD  CONSTRAINT [fk_Red_DirectorAllocation] FOREIGN KEY([DrAllocationId])
REFERENCES [dbo].[DirectorAllocation] ([ID])
GO
ALTER TABLE [dbo].[RedFlags] CHECK CONSTRAINT [fk_Red_DirectorAllocation]
GO
/****** Object:  ForeignKey [fk_RedFlags]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[RedFlags]  WITH CHECK ADD  CONSTRAINT [fk_RedFlags] FOREIGN KEY([MSID])
REFERENCES [dbo].[MeetingSchedule] ([ID])
GO
ALTER TABLE [dbo].[RedFlags] CHECK CONSTRAINT [fk_RedFlags]
GO
/****** Object:  ForeignKey [fk_MeetingNotifications]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingNotifications]  WITH CHECK ADD  CONSTRAINT [fk_MeetingNotifications] FOREIGN KEY([MSID])
REFERENCES [dbo].[MeetingSchedule] ([ID])
GO
ALTER TABLE [dbo].[MeetingNotifications] CHECK CONSTRAINT [fk_MeetingNotifications]
GO
/****** Object:  ForeignKey [fk_MeetingNotes]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingNotes]  WITH CHECK ADD  CONSTRAINT [fk_MeetingNotes] FOREIGN KEY([MSID])
REFERENCES [dbo].[MeetingSchedule] ([ID])
GO
ALTER TABLE [dbo].[MeetingNotes] CHECK CONSTRAINT [fk_MeetingNotes]
GO
/****** Object:  ForeignKey [fk_MeetingNotes_TemplateSection]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[MeetingNotes]  WITH CHECK ADD  CONSTRAINT [fk_MeetingNotes_TemplateSection] FOREIGN KEY([TemplateSectionId])
REFERENCES [dbo].[TemplateSection] ([ID])
GO
ALTER TABLE [dbo].[MeetingNotes] CHECK CONSTRAINT [fk_MeetingNotes_TemplateSection]
GO
/****** Object:  ForeignKey [FK_Answers_Meeting]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_Meeting] FOREIGN KEY([MSID])
REFERENCES [dbo].[MeetingSchedule] ([ID])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Meeting]
GO
/****** Object:  ForeignKey [FK_Answers_Question]    Script Date: 04/15/2013 12:21:11 ******/
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_Question] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Question]
GO
