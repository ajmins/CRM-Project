USE [master]
GO
/****** Object:  Database [chummaveruthe]    Script Date: 27-08-2022 16:07:51 ******/
CREATE DATABASE [chummaveruthe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'chummaveruthe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\chummaveruthe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'chummaveruthe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\chummaveruthe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [chummaveruthe] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [chummaveruthe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [chummaveruthe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [chummaveruthe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [chummaveruthe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [chummaveruthe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [chummaveruthe] SET ARITHABORT OFF 
GO
ALTER DATABASE [chummaveruthe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [chummaveruthe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [chummaveruthe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [chummaveruthe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [chummaveruthe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [chummaveruthe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [chummaveruthe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [chummaveruthe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [chummaveruthe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [chummaveruthe] SET  DISABLE_BROKER 
GO
ALTER DATABASE [chummaveruthe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [chummaveruthe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [chummaveruthe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [chummaveruthe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [chummaveruthe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [chummaveruthe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [chummaveruthe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [chummaveruthe] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [chummaveruthe] SET  MULTI_USER 
GO
ALTER DATABASE [chummaveruthe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [chummaveruthe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [chummaveruthe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [chummaveruthe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [chummaveruthe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [chummaveruthe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [chummaveruthe] SET QUERY_STORE = OFF
GO
USE [chummaveruthe]
GO
/****** Object:  Table [dbo].[activity_log]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activity_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[batches]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[batches](
	[batchId] [varchar](80) NOT NULL,
	[batchName] [varchar](80) NOT NULL,
	[batchCourseId] [varchar](80) NOT NULL,
	[batchStatus] [bit] NULL,
	[batchStrength] [int] NULL,
	[batchStartDate] [datetime] NOT NULL,
	[batchEndDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[batchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[categoryId] [varchar](80) NOT NULL,
	[categoryName] [varchar](80) NULL,
	[categoryStatus] [bit] NULL,
	[categoryComments] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_enrollment]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_enrollment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[courseId] [varchar](80) NULL,
	[batchId] [varchar](80) NULL,
	[enrollStatus] [varchar](80) NULL,
	[score] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
	[courseId] [varchar](80) NOT NULL,
	[courseName] [varchar](80) NOT NULL,
	[courseCategoryId] [varchar](80) NOT NULL,
	[courseDuration] [varchar](80) NULL,
	[courseDescription] [varchar](80) NULL,
	[courseInstructorID] [int] NULL,
	[courseMinQualificationId] [int] NULL,
	[courseBatchSize] [int] NULL,
	[courseVideoLink] [varchar](80) NULL,
	[courseSyllabus] [varbinary](max) NULL,
	[courseRating] [int] NULL,
	[courseStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[courseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enquiries]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enquiries](
	[enquiryId] [int] IDENTITY(1,1) NOT NULL,
	[enquiryUserId] [int] NULL,
	[enquiryCourseId] [varchar](80) NULL,
	[enquiryDescription] [varchar](250) NULL,
	[enquiryStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[enquiryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[instructor]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instructor](
	[instructorId] [int] IDENTITY(1,1) NOT NULL,
	[instructorName] [varchar](80) NOT NULL,
	[instructorEmail] [varchar](80) NULL,
	[instructorPhone] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[instructorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qualifications]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qualifications](
	[qualificationId] [int] IDENTITY(1,1) NOT NULL,
	[qualificationName] [varchar](80) NOT NULL,
	[qualificationStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[qualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[roleId] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [varchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_batch]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_batch](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[batchId] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_qualification]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_qualification](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[qualificationId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 27-08-2022 16:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](80) NOT NULL,
	[userPassword] [varchar](250) NOT NULL,
	[userRoleId] [int] NOT NULL,
	[userEmail] [varchar](80) NOT NULL,
	[userPhone] [varchar](80) NOT NULL,
	[userCountry] [varchar](80) NOT NULL,
	[userState] [varchar](80) NOT NULL,
	[userCity] [varchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[activity_log] ON 
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (1, 1, CAST(N'1970-01-01T00:00:01.000' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (2, 2, CAST(N'1970-01-02T00:00:01.510' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (3, 3, CAST(N'1970-01-03T00:00:01.930' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (4, 4, CAST(N'1970-01-04T00:00:01.930' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (5, 5, CAST(N'1970-01-05T00:00:01.410' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (6, 6, CAST(N'1970-01-06T00:00:01.910' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (7, 7, CAST(N'1970-01-07T00:00:01.430' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (8, 8, CAST(N'1970-01-08T00:00:01.130' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (9, 9, CAST(N'1970-01-09T00:00:01.150' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (10, 10, CAST(N'1970-01-10T00:00:01.670' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (11, 11, CAST(N'1970-01-11T00:00:01.920' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (12, 12, CAST(N'1970-01-12T00:00:01.810' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (13, 13, CAST(N'1970-01-13T00:00:01.670' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (14, 14, CAST(N'1970-01-14T00:00:01.080' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (15, 15, CAST(N'1970-01-15T00:00:01.040' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (16, 16, CAST(N'1970-01-16T00:00:01.150' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (17, 17, CAST(N'1970-01-17T00:00:01.540' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (18, 18, CAST(N'1970-01-18T00:00:01.940' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (19, 19, CAST(N'1970-01-19T00:00:01.910' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (20, 20, CAST(N'1970-01-20T00:00:01.180' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (21, 21, CAST(N'1970-01-21T00:00:01.710' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (22, 22, CAST(N'1970-01-22T00:00:01.810' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (23, 23, CAST(N'1970-01-23T00:00:01.110' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (24, 24, CAST(N'1970-01-24T00:00:01.700' AS DateTime))
GO
INSERT [dbo].[activity_log] ([id], [userId], [time]) VALUES (25, 25, CAST(N'1970-01-25T00:00:01.960' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[activity_log] OFF
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA000', N'Information Technology', N'CA000French00', 1, 20, CAST(N'1970-01-01T00:00:01.000' AS DateTime), CAST(N'1970-01-01T00:00:01.000' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA001', N'Research and Development', N'CA001Chinese01', 1, 20, CAST(N'1970-01-02T00:00:01.460' AS DateTime), CAST(N'1970-01-02T00:00:01.980' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA002', N'Manufacturing', N'CA002Afrikaans02', 1, 20, CAST(N'1970-01-03T00:00:01.340' AS DateTime), CAST(N'1970-01-03T00:00:01.630' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA003', N'Consulting', N'CA003Malayalam03', 1, 20, CAST(N'1970-01-04T00:00:01.540' AS DateTime), CAST(N'1970-01-04T00:00:01.240' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA004', N'Executive', N'CA004Polish04', 1, 20, CAST(N'1970-01-05T00:00:01.980' AS DateTime), CAST(N'1970-01-05T00:00:01.200' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA005', N'Operations', N'CA005Breton05', 1, 20, CAST(N'1970-01-06T00:00:01.010' AS DateTime), CAST(N'1970-01-06T00:00:01.460' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA006', N'Marketing', N'CA006Faroese06', 1, 20, CAST(N'1970-01-07T00:00:01.690' AS DateTime), CAST(N'1970-01-07T00:00:01.560' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA007', N'Human Resources', N'CA007Shona07', 1, 20, CAST(N'1970-01-08T00:00:01.230' AS DateTime), CAST(N'1970-01-08T00:00:01.680' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA008', N'Finance', N'CA008Tsonga08', 1, 20, CAST(N'1970-01-09T00:00:01.150' AS DateTime), CAST(N'1970-01-09T00:00:01.650' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA009', N'Facilities', N'CA009Kuanyama09', 1, 20, CAST(N'1970-01-10T00:00:01.420' AS DateTime), CAST(N'1970-01-10T00:00:01.550' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA010', N'Sales', N'CA010Kikuyu10', 1, 20, CAST(N'1970-01-11T00:00:01.180' AS DateTime), CAST(N'1970-01-11T00:00:01.550' AS DateTime))
GO
INSERT [dbo].[batches] ([batchId], [batchName], [batchCourseId], [batchStatus], [batchStrength], [batchStartDate], [batchEndDate]) VALUES (N'BA011', N'Customer Support', N'CA011Igbo11', 1, 20, CAST(N'1970-01-12T00:00:01.330' AS DateTime), CAST(N'1970-01-12T00:00:01.070' AS DateTime))
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA000', N'Crafts', 1, N'Office')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA001', N'Clothing', 1, N'Shoes')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA002', N'Games', 1, N'Baby')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA003', N'Movies', 1, N'Tools')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA004', N'Patio', 1, N'Home')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA005', N'Automotive', 1, N'Health')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA006', N'Toys', 1, N'Outdoors')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA007', N'Music', 1, N'Movies')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA008', N'Books', 1, N'Furniture')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA009', N'Outdoors', 1, N'Accessories')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA010', N'Audible', 1, N'Electronics')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA011', N'Jewelry', 1, N'Pets')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA012', N'Food', 1, N'Sports')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA013', N'Gifts', 1, N'Accessories')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA014', N'Baby', 1, N'Books')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA015', N'Computers', 1, N'Health')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA016', N'Home', 1, N'Crafts')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA017', N'Garden', 1, N'Clothing')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA018', N'Pets', 1, N'Pets')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA019', N'Pharmacy', 1, N'Movies')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA020', N'Sports', 1, N'Office')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA021', N'Furniture', 1, N'Audible')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA022', N'Office', 1, N'Sports')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA023', N'Beauty', 1, N'Sports')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryStatus], [categoryComments]) VALUES (N'CA024', N'Accessories', 1, N'Movies')
GO
SET IDENTITY_INSERT [dbo].[course_enrollment] ON 
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (1, 1, N'CA000French00', N'BA000', N'ENROLLED', 0)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (2, 2, N'CA001Chinese01', N'BA001', N'ENROLLED', 1)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (3, 3, N'CA002Afrikaans02', N'BA002', N'ENQUIRED', 2)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (4, 4, N'CA003Malayalam03', N'BA003', N'ENQUIRED', 3)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (5, 5, N'CA004Polish04', N'BA004', N'ENROLLED', 4)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (6, 6, N'CA005Breton05', N'BA005', N'ENROLLED', 5)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (7, 7, N'CA006Faroese06', N'BA006', N'ENQUIRED', 6)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (8, 8, N'CA007Shona07', N'BA007', N'ENQUIRED', 7)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (9, 9, N'CA008Tsonga08', N'BA008', N'REJECTED', 8)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (10, 10, N'CA009Kuanyama09', N'BA009', N'ENROLLED', 9)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (11, 11, N'CA010Kikuyu10', N'BA010', N'ENQUIRED', 10)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (12, 12, N'CA011Igbo11', N'BA011', N'ENQUIRED', 11)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (13, 13, N'CA012Kongo12', N'BA000', N'REJECTED', 12)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (14, 14, N'CA013Avestan13', N'BA001', N'ENQUIRED', 13)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (15, 15, N'CA014Gujarati14', N'BA002', N'COMPLETED', 14)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (16, 16, N'CA015Maltese15', N'BA003', N'ENROLLED', 15)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (17, 17, N'CA016Pali16', N'BA004', N'ENROLLED', 16)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (18, 18, N'CA017Slovak17', N'BA005', N'ENQUIRED', 17)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (19, 19, N'CA018Wolof18', N'BA006', N'ENROLLED', 18)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (20, 20, N'CA019Zulu19', N'BA007', N'ENROLLED', 19)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (21, 21, N'CA020Turkmen20', N'BA008', N'COMPLETED', 20)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (22, 22, N'CA021Persian21', N'BA009', N'ENROLLED', 21)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (23, 23, N'CA022Tigrinya22', N'BA010', N'COMPLETED', 22)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (24, 24, N'CA023Romansh23', N'BA011', N'ENROLLED', 23)
GO
INSERT [dbo].[course_enrollment] ([id], [userId], [courseId], [batchId], [enrollStatus], [score]) VALUES (25, 25, N'CA024Tajik24', N'BA000', N'ENROLLED', 24)
GO
SET IDENTITY_INSERT [dbo].[course_enrollment] OFF
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA000French00', N'French', N'CA000', N'6', N'Et velit.', 1, 1, 20, N'http://www.asntted.il/nehadall/oularan/ourtiobut/withis.asp', 0x4ED6509E3CB6847094893AD580F473E3DF241D92F6081AA8078ABE4E0689A0B620D2671B825F847763310203C1FBB2188E51CDF1DF390545BCA796B1F835690AE883B5AD8D576180A0A62EC50616E70CD7A5BFB4BCAFD7E6CD215FDAC8D27E2DC7F81B3D45048B36F04D51390B3F3FA5BF8ADA5375B54E38ACCEE06BF886B7CD2700FD0EFAAAC6D31989C46F5E9EDB8DE2B91A3EF82BB712A9E2907724203E699583120A4231AB15C3063AECF1DFDA0EF252883F, 5, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA001Chinese01', N'Chinese', N'CA001', N'6', N'Illo distinctio.', 2, 2, 20, N'http://www.henhen.cn/meeate/forit/alhathe/butarevernt.htm', 0x79D5FB48EB6418194FAEF84A5AD9DA8CD14BB10E057AF1F1CB21C9078284D298FEFD1BAD16C157CC93FB745741A2960500822106D73166FFE40A7DC99A1097CADC604B5CBD2D7510F4E47A090599AF288AC307FF62CBC0CD971CC80B438D318264AA7AE1563A47D30C1111F2B65CF94A5B553FD6099767109F7EC4A1646ACC67B3F8A55B1ECED24F7B34F351BACE173B227DAFEE4D5A79, 3, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA002Afrikaans02', N'Afrikaans', N'CA002', N'12', N'Fuga magni. Rerum facilis.', 3, 3, 20, N'https://www.enthisho.com/inon/but/ashetha/erewitheeve.asp', 0x426941D776A66EA144AA3FBEB69E2C8D82F05BD4A41656D16689, 2, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA003Malayalam03', N'Malayalam', N'CA003', N'6', N'Est architecto. Et optio.', 4, 4, 20, N'https://www.thameera.ar/tendme/thiwasuld/meterhe/hisitngis.php?t=79&p=5868', 0xE6BBDE19587ED919B48CFAD9D5C5510C0F8E59848451226C5DFFA4272B137071EC2888E66690E73FDC8577008716850F530A47420D04F9949872BC58D9B2EDA11C89ECAC3C6AA57FA719A7FFDA22, 0, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA004Polish04', N'Polish', N'CA004', N'6', N'Autem ut; corporis nesciunt.', 5, 5, 20, N'https://www.ithbutyouon.fi/lees/oulhathen/enomeoul/threteal.html', 0x467995D421CB2D63E82EF34DF4D48E652A97D5E3FD2AD8D2E864C89BF35CFABA768D75DE44DDCCD5EF25047E491CB1AA18B47D68043EE61CA0C3EBBC0391708B3439D7665EAF214CCBFFF4D7255A89CBB31D823FDF91B638A7583E80F10FD25DB579490F454A4B6992, 2, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA005Breton05', N'Breton', N'CA005', N'6', N'Exercitationem sit; optio?', 6, 1, 20, N'http://www.nearhadthi.fr/tiotiing/hahibut/notleti/reeraat.asp', 0x9C04490EF7463A2009E60F31ABA2839FBF0571A05ABB2D9622AC10798568D119ACAFF5B1EE9861F746D105EC4E84CEA78CA68B46F7F2D5E1D6B3EC4A, 5, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA006Faroese06', N'Faroese', N'CA006', N'6', N'Dolore voluptas recusandae.', 7, 2, 20, N'https://www.ionansthad.no/ar/me/st/showasingin.htm', 0xC09BA114F584FBADD1B026A4795A89B641489DDD69EDDFDC8B21B9DA14DA3BAC16C1853663D758FFD2F9BAF564A17D984C2A956A4F6DCCD3BBC489D4CB2199F7757A8DB7D453526AF09D0B6F33E978E9A3218DE945D05DA9F5B27A9F4E8334B160C37FE914C5C3F8D82B79B1615CA0D24C9F30A993B0B1A41DE3C221D8B31B6C68590F6F6A8ED4DD5E9510, 0, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA007Shona07', N'Shona', N'CA007', N'6', N'Exercitationem et sapiente.', 8, 3, 20, N'http://ouhinmeyou.us/areforour/buterame/henti/butshowit.asp', 0x57AB479812A852AE528B1DB011DACB3103A120240F0C48084D3068BDCA534AFE9F984D729B290F30606D19DD3B5E5E8FC2A3DABC75EB094A623F4AE24094E3FF401F10788D5996DA91EFC4A2F26BCCEED1D8FA27788E89B38E030F5BDE2DF0CB89199C1C4DE502690C002A85276757F7735B106799BC87B2965DEA89493AFB64FEF819D9CEB0A1EBD6911A7863, 2, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA008Tsonga08', N'Tsonga', N'CA008', N'3', N'Corrupti sint. Sed unde.', 9, 4, 20, N'http://witenth.net/evetioere/areerewaome.asp', 0x8B27AB18E8821D8931CD92EA86F0FB781FD204C6862F4D7E28C3BA249008A10E4E92D1C3DD3152784775C64C46E429B0F05D7248749C7C5CD92DF024C7F8F8292C849BF31E379AEE7F8C7F1168013844990A3432965899B11675EAB0402DB04E7C9C20C1483692, 5, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA009Kuanyama09', N'Kuanyama', N'CA009', N'12', N'Omnis ut. Doloremque et.', 10, 5, 20, N'https://www.isthi.ge/tederth/erthehad/lenese/wasrearth.html#3', 0xC383C9E81D6AF3D7F5AC8BBDC4C593D3EAE9DCA84DEAAD51DB3194CBE176FB62777B6F128EB194AB8112BB94A2F289B6094CD65E59E96BD8D6770CECD627F57EB0284649568144395531263A2F18AEE8A7DDC295A09D088D10973C17A4A8D55A1C3CE47AAC406088079D0928C330A9BDC92445F86560DE131FB839BE452D94AD5CCC1DF234343B667C3A8D0293E0CADFED7E4D8063DCF5BC5ED05A, 0, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA010Kikuyu10', N'Kikuyu', N'CA010', N'6', N'Et ducimus; doloribus fugit.', 11, 1, 20, N'https://www.thormeme.dk/erear/eaforon/ere/eveuldening.php', 0x07A142D9095CCBF612B78894E8DE7B2AD2DB7F3EED59D1C6DF13497FD7619363DA465EDAF7B4F93715D4CC36F5B9978461CAE983511B07ADD07CF9F5124B1FB02324B9A180A0331EE14829188C9AD0267BC51E0C781012BE3FB00A7ABA0324C9B51B12D1FFF604C097CBA108F1EE2135ACD3794C2C12381312FB62CF96B863DE2360637188FF2685C15E75AD6E0ACD508FD4CEE78AD7, 3, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA011Igbo11', N'Igbo', N'CA011', N'3', N'Et obcaecati. Sit molestias.', 12, 2, 20, N'http://www.atterngar.it/theallea/shoeraal/terteoul/meyouonse.htm', 0xA2E3FEBF0493342ADF67C3E4918BB0ADACACF48BCE9D8BA5072D113FC1E97B534BC3C18D894021F18C339645AB253BC5DF27213A954CCD045759B7D681F568F5EB6F98CEC922236C8B02FE9A0746F9E2F24C6099C741BEFFF5BC352F884A6F97CBA0593B8C6DFBBD03B5AF924E33FD115FD5E43595CF2EAAB1, 3, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA012Kongo12', N'Kongo', N'CA012', N'3', N'Minus est magnam sed.', 13, 3, 20, N'http://ntent.org/in/henou.asp?id=710', 0xD80DECF4E3409366CF66ECBE558450A29612912BB0C2BE24D0B3663902FC72AE8AF295EED10FD16EFFE7639624A17F5FE4F2381B1885E9164EC72430DA5964D3F43E3363EF62D18641222CC95E27FF2E34065510C3569505097F9F09EBA094A58390A2E66E1C6F8220B2DAF6581FB726C8F5FCD30453109DA82D5970C2C89BA08E8646CE8519C01796D2EF117C9FACEAC77940F5A4C0A12F7F043D40C3FFC058173967D1D9E8A0AF35E43D3164FF2109816FA948, 5, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA013Avestan13', N'Avestan', N'CA013', N'3', N'Repellat laudantium.', 14, 4, 20, N'https://www.youourhat.dk/ingalloul/re/tervearea.php?t=56', 0xA5FCCDE5174E81DB8054971296F94337DA11DFD891C0C0836FCA80E234BE535677D1723D9AECC1991ED4B58FA51FCD05DED1A65EC970F5E43B49754CCE9EA6C100419AC587059C, 5, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA014Gujarati14', N'Gujarati', N'CA014', N'3', N'Repudiandae ut.', 15, 5, 20, N'http://www.hadtitiha.ar/ithesea/tioteand/as/armeeveas.php?t=69&p=918', 0x4F45B9BD0B30DD4FFC7B046318F58C07DB8D01, 5, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA015Maltese15', N'Maltese', N'CA015', N'12', N'Quod quos. Ipsum omnis.', 16, 1, 20, N'http://thaer.ch/hadhenwit/notaned.php', 0x7675CB802DF48E6485087DD834B80E84B638D9, 0, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA016Pali16', N'Pali', N'CA016', N'6', N'Ut consequatur. Molestiae!', 17, 2, 20, N'http://www.eshision.it/entor/hadter/ourthase/alntreme.php', 0x6B264F539A43A80BB493E9FA044B77D97A398F17A178CAF4FD2C2E5FE60850A2B4F6E5502578E5EA4B83AFF21E83D4E94135097CA9C169F25B5B556E144824AC4247450D6626B40253A4CC1DC9D8D57A57451EB1FED4F9F28CF2F5CA, 0, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA017Slovak17', N'Slovak', N'CA017', N'6', N'Non alias enim blanditiis.', 18, 3, 20, N'http://www.wasmenthi.nl/hati/aneaoul/ingatfornd.php?t=86&p=8890', 0x77D6025F03AFD73DC6821A80072805F54C298385DA16CF2A72AD6E4D52817431E9DFDCCECABEC528FD3C90C20331F7ABF4FD3FC87144486106D7ED55418AEB450EE996274C362B8E645A879E850C2641B6C3595441ACBFA5977BC7F2D070E673514BB41A9ACF5EBDD2B16417BCA9DBFAB1AC9F7E319603612AF190D16F39BDF374144D3A570CA6E6649B828F47A8E9ED9FCC4024D06842BA4852EFA93E8C4D98F470A3A85CA1A2A505B8199513731A8207A332A2F899230BD192F1051CFDA7, 3, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA018Wolof18', N'Wolof', N'CA018', N'6', N'Necessitatibus vitae. Cum.', 19, 4, 20, N'http://www.hadse.ca/ntteome/thaallve/uldhadhad/eveeareve.htm#5', 0x4DE99BD7054190FE2A9A1E174EADA6D4386DA19B5AAA9F5A4D97D6CAAF9D89071141, 0, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA019Zulu19', N'Zulu', N'CA019', N'6', N'Hic delectus. Sed nobis.', 20, 5, 20, N'http://www.erashose.com/hishoou/ingted/seonwa/toourwa.php?t=60', 0x2AD7427DC61333785D7A0BBD24EB1DCCAE5C0C7DA349408A6D6AC54F8D1117060C657CFCF6F0DB88273242E042D9B2DF91D0DAAB04C4A4E096B80F5B4DE3EB4C6304B1BE6E20D6BE8183567107604894B8E6BDBC376B0148C19C663E, 0, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA020Turkmen20', N'Turkmen', N'CA020', N'6', N'Eaque qui aut. Qui in!', 21, 1, 20, N'http://www.neallveto.de/allarou/esfornt/foreath/leour.htm', 0x7F3A4346F57C3D28F47071FA1B2A806D33D8366F7BA366262E14F70269FCD2BA98DE0148132A11E40A6CC4764CC11C4180DA8EC42FCE65DCD41C18E1843ABFF79EB7623D29375909C651650FDEF0DA6DF7B6818E6E0D8AC9782574F611305FCFACCCD7945EDF18498185FDDD6856FDE342AAE9CEB93189902C98C403C362F796F295621218450E189E38, 1, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA021Persian21', N'Persian', N'CA021', N'12', N'Nihil in odio dignissimos est.', 22, 2, 20, N'http://aseshinne.ae/esbutis/thaented/ea/wasoulistio.htm#3647', 0xE810AC60222790B4674690167B434668C61A14851E8E67EBD3F4EBCBFD9CD12F8024A0808037A2DC32AE8F4F617FE6CED1DD48FE8AB2EE5AA9C18D2D3CC5B7CA75619557A3C6E78E78375370FE1789540D1DF91F54D2A5CD3546D7BEAA74A06DF6C5DA00E98E2A0BF5BA85525F7E5B9138391F1ECC9776A2BBC7215DEF29E30397E679393D886B7FF2EE2A9A4D526DB7EA4586715581A05F4E3744216DCD1BCCD682BA79, 2, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA022Tigrinya22', N'Tigrinya', N'CA022', N'12', N'Atque nemo. Dolor ipsam.', 23, 3, 20, N'http://www.notithwas.tw/erareth/athenhinle.php', 0x2254AFCEA02CDE6CDC5568596972AAA272AE16451AEA0643491125D25EC3CA98F4B2C8F1D7A3B454C2F271E1DCC7035A712963D4A434EA374D6B848F070B0E188BD065B6AAB8CACFF9C18327792467810DCA613460F6F3BFC891A36B1E254DB6E359560B614CB0B85F94DAE3B1C2BE290402813CA9D9B895DDA6EE19155EB0D473CC441FCD5C20C119A9D5CC1B100E05D379671BA4100D09A0C12EBB5D97A200E3066FE57E9E5BA7E2BF230004EC79CD97E9469B, 3, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA023Romansh23', N'Romansh', N'CA023', N'3', N'Veniam tempore.', 24, 4, 20, N'http://www.hiwitatthe.ua/eveouar/erereare/herngalhen.asp', 0x952F62BF3A7F0B2E64638207D4E814A02986341EBF39E4ED0C05B4486024745106094DD60C25441F4F797E5CA0F82F03642C6E62117D365C4B75B234CAC3CD40EE3100CB9A3E93034215CE46BA884D13D6B0E334B5113F89D2F18B97730F548CAC3D6D6EF8646826986A20FCAFF0A1C3279E5E19E0998ADDF277F8A8B2FC9033C041997C1ADE1B7148BC9B4BF143D9E150C86FD5B03AAB13B3907C816BBF739CDAEC3B6D5624A84982ECD123FD3FEBAE9D1658EA8DBA82859686C98A62, 1, 1)
GO
INSERT [dbo].[courses] ([courseId], [courseName], [courseCategoryId], [courseDuration], [courseDescription], [courseInstructorID], [courseMinQualificationId], [courseBatchSize], [courseVideoLink], [courseSyllabus], [courseRating], [courseStatus]) VALUES (N'CA024Tajik24', N'Tajik', N'CA024', N'12', N'Aut provident velit. Est.', 25, 5, 20, N'https://www.hadarewasthi.dk/eraforng/reshoenen.php?t=96&p=5747', 0x068849FE7004076C8A2C1F2552C368871574A4CDE354, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[enquiries] ON 
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (1, 10, N'CA002Afrikaans02', N'Provident dolores rerum. Rerum ut aspernatur repudiandae accusantium! Qui quis quo sit dolorem consequatur qui; reiciendis expedita sed. Qui facere.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (2, 22, N'CA012Kongo12', N'Autem ex voluptas. Reiciendis ratione iusto nostrum temporibus suscipit non; est sit facilis provident sequi ut nisi.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (3, 18, N'CA007Shona07', N'Quis aut cum. Rem temporibus et. Eligendi quae qui. Autem sequi voluptatem! Qui ad omnis; nam eligendi eum. Obcaecati omnis eos; aut sunt fugit? Aliquid a.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (4, 6, N'CA013Avestan13', N'Repellendus mollitia nobis. Ut aut doloribus quis. Placeat laborum id minus accusantium dolores eos. Aperiam exercitationem provident reprehenderit doloribus!', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (5, 2, N'CA012Kongo12', N'Sit consequatur autem. Totam minus eius! Nisi a ut. Voluptas blanditiis est. Ut quam sit; et tenetur commodi. Asperiores voluptas fuga. Cupiditate dicta.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (6, 23, N'CA002Afrikaans02', N'Quibusdam rerum asperiores sit dolorum a beatae.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (7, 15, N'CA002Afrikaans02', N'In ut placeat. Enim dolores voluptate! Et consequuntur nisi. Quasi eaque eum! Ut est explicabo. Temporibus aut pariatur? Numquam recusandae ut. Deserunt.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (8, 15, N'CA020Turkmen20', N'Dolorem odit et aut ipsum laboriosam consequatur. Reiciendis porro vel laborum pariatur vel? Quidem quibusdam molestias et.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (9, 1, N'CA002Afrikaans02', N'Possimus et accusantium. Corporis eligendi hic in incidunt? Molestias ut nisi quia; sed non ipsam ducimus dolores alias. A est et!', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (10, 16, N'CA020Turkmen20', N'Voluptatem expedita sit. Aut neque quia voluptatem? Aut maxime aut aliquid et quia delectus; sit iure doloremque inventore esse. Quia sed nam...', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (11, 25, N'CA011Igbo11', N'Iste quia excepturi. Natus error possimus! Molestiae nam exercitationem. Rerum laborum delectus. Inventore quae ipsum. Ab amet odit. Possimus ad est.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (12, 25, N'CA019Zulu19', N'Magnam qui eum. Rerum velit et? Ut ducimus eveniet. Impedit quis ut. Eius aut alias! Est optio molestiae. Hic id soluta. Pariatur molestias velit; vel fugit.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (13, 5, N'CA011Igbo11', N'Iusto et quaerat sapiente facere et aut; omnis ipsum dolor minima fugit veritatis qui.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (14, 2, N'CA002Afrikaans02', N'Voluptatum et aut. Soluta qui nihil. Ut dolore harum. Labore voluptas quas; temporibus est voluptas. Ut quo error? Illum obcaecati optio. Porro ut ea. Est!', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (15, 17, N'CA019Zulu19', N'Accusamus perspiciatis aliquam magni dolorem esse. Deleniti ut qui! Accusantium ut quidem. Dolor quo nam! Sed sunt et. Et omnis dolore.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (16, 23, N'CA006Faroese06', N'Et maxime minima corporis accusantium; unde ducimus aut et. Quo tempora totam eaque odio numquam eos.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (17, 14, N'CA022Tigrinya22', N'Deleniti aliquid pariatur reiciendis ut sit. Itaque soluta officia. Ab esse quis! Magnam consequuntur asperiores. Sed ut deleniti. Impedit aut sunt.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (18, 2, N'CA003Malayalam03', N'Enim magnam repudiandae. Debitis quasi mollitia; qui fugit est. Dolorem ut eum. Quia a provident. Rem in tempora. Similique qui sed!', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (19, 25, N'CA022Tigrinya22', N'Non ut hic voluptatem. Doloremque delectus fugiat dolorem! Cumque perspiciatis quis porro placeat soluta. Odio repellat architecto praesentium repellendus.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (20, 4, N'CA001Chinese01', N'Facilis veritatis est. Quidem laborum ullam? Sint quae fuga; exercitationem pariatur esse? Et nostrum ullam. Expedita et rerum! Accusantium aut laboriosam?', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (21, 17, N'CA002Afrikaans02', N'Sint et id tenetur eos sit; enim expedita exercitationem dolores. Possimus aut perspiciatis laboriosam officia fuga corporis.', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (22, 13, N'CA022Tigrinya22', N'Odio reiciendis quasi. Quia quaerat accusamus? Earum doloremque rem! Animi amet aperiam. Qui possimus natus. Consectetur laborum aut! Animi vitae corporis.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (23, 13, N'CA006Faroese06', N'Optio aliquid id. Eveniet ea qui. Quo non assumenda; ratione eos consequuntur. Rerum corporis est. Quia nulla doloremque? Qui aut esse! Cumque id aut...', 1)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (24, 8, N'CA006Faroese06', N'Quis non consequatur nisi laboriosam odit. Dolores ullam ex. Ea in aut! Commodi accusamus animi doloribus corrupti cum quis.', 0)
GO
INSERT [dbo].[enquiries] ([enquiryId], [enquiryUserId], [enquiryCourseId], [enquiryDescription], [enquiryStatus]) VALUES (25, 22, N'CA002Afrikaans02', N'Enim delectus illum. Quas ex aut? Eos a sint. Ipsa et ipsum? Omnis ullam aliquam; rem eligendi sunt. Quod deserunt nemo. Fuga dolorum ut.', 1)
GO
SET IDENTITY_INSERT [dbo].[enquiries] OFF
GO
SET IDENTITY_INSERT [dbo].[instructor] ON 
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (1, N'Carrillo253', N'Smothers@example.com', N'+971 3 412 2259')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (2, N'Vicente5', N'nsdolbat.bxchu@nowhere.com', N'+33 7 65 79 52 74')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (3, N'Garth1984', N'CyrusDyson49@nowhere.com', N'+33 0 45 37 04 41')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (4, N'Cyndi858', N'WilberGaddis@example.com', N'+49 9465 400031')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (5, N'Stanford1965', N'HymanMatson@example.com', N'+971 4 057 5521')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (6, N'Newsome2005', N'Allman691@example.com', N'+420 509 147 840')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (7, N'Emelia2000', N'Nelida.Slaughter89@nowhere.com', N'+49 (1989) 917153')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (8, N'Styles2002', N'Schwarz@nowhere.com', N'+49 (4094) 992947')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (9, N'Seals2010', N'Bray@example.com', N'+55 58 0640-0920')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (10, N'Derick687', N'Siegel77@nowhere.com', N'+55 08 8302-0061')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (11, N'Ozella2025', N'Lawler@example.com', N'+55 78 3706-9366')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (12, N'Nagle24', N'Shelby_Blackmon@example.com', N'+1 916-401-6546')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (13, N'Courtney5', N'WilliamsCass123@nowhere.com', N'+49 2728 907648')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (14, N'Lozano3', N'CherrylHHolloway@nowhere.com', N'+49-2742-585253')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (15, N'Mel2004', N'Mcmaster@nowhere.com', N'+55 78 5459-6607')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (16, N'Gaylord292', N'avptw0627@example.com', N'+44 858 290 5949')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (17, N'Jack895', N'ChristianBauer64@nowhere.com', N'+49 4212 726500')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (18, N'Ward2012', N'MarkusPfeifer@example.com', N'+44 605 324 9890')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (19, N'Wallace24', N'HongForsythe942@example.com', N'+971 4 454 2013')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (20, N'Courtney985', N'Farrell@example.com', N'+55 28 4901-7885')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (21, N'Rosario741', N'Hallman52@example.com', N'+380 63 869-261-3')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (22, N'Soriano2008', N'Abreu@nowhere.com', N'+49 6298 741188')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (23, N'Farr189', N'KathyrnKay@nowhere.com', N'+49 (1484) 353578')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (24, N'Maddie2004', N'Dolan@example.com', N'+1 397-497-0804')
GO
INSERT [dbo].[instructor] ([instructorId], [instructorName], [instructorEmail], [instructorPhone]) VALUES (25, N'Craig479', N'odtyk412@example.com', N'+44 6936 79 2319')
GO
SET IDENTITY_INSERT [dbo].[instructor] OFF
GO
SET IDENTITY_INSERT [dbo].[qualifications] ON 
GO
INSERT [dbo].[qualifications] ([qualificationId], [qualificationName], [qualificationStatus]) VALUES (1, N'Ph. D', 1)
GO
INSERT [dbo].[qualifications] ([qualificationId], [qualificationName], [qualificationStatus]) VALUES (2, N'Post Graduate', 1)
GO
INSERT [dbo].[qualifications] ([qualificationId], [qualificationName], [qualificationStatus]) VALUES (3, N'Under Graduate', 1)
GO
INSERT [dbo].[qualifications] ([qualificationId], [qualificationName], [qualificationStatus]) VALUES (4, N'Senior Secondary', 1)
GO
INSERT [dbo].[qualifications] ([qualificationId], [qualificationName], [qualificationStatus]) VALUES (5, N'High School', 1)
GO
SET IDENTITY_INSERT [dbo].[qualifications] OFF
GO
SET IDENTITY_INSERT [dbo].[role] ON 
GO
INSERT [dbo].[role] ([roleId], [roleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[role] ([roleId], [roleName]) VALUES (2, N'User')
GO
SET IDENTITY_INSERT [dbo].[role] OFF
GO
SET IDENTITY_INSERT [dbo].[user_batch] ON 
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (1, 5, N'BA000')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (2, 21, N'BA001')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (3, 15, N'BA002')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (4, 10, N'BA003')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (5, 10, N'BA004')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (6, 19, N'BA005')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (7, 24, N'BA006')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (8, 9, N'BA007')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (9, 12, N'BA008')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (10, 22, N'BA009')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (11, 25, N'BA010')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (12, 21, N'BA011')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (13, 10, N'BA000')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (14, 11, N'BA001')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (15, 6, N'BA002')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (16, 16, N'BA003')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (17, 18, N'BA004')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (18, 12, N'BA005')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (19, 5, N'BA006')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (20, 24, N'BA007')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (21, 13, N'BA008')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (22, 7, N'BA009')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (23, 20, N'BA010')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (24, 5, N'BA011')
GO
INSERT [dbo].[user_batch] ([id], [userId], [batchId]) VALUES (25, 2, N'BA000')
GO
SET IDENTITY_INSERT [dbo].[user_batch] OFF
GO
SET IDENTITY_INSERT [dbo].[user_qualification] ON 
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (1, 1, 1)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (2, 2, 2)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (3, 3, 3)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (4, 4, 4)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (5, 5, 5)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (6, 6, 1)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (7, 7, 2)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (8, 8, 3)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (9, 9, 4)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (10, 10, 5)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (11, 11, 1)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (12, 12, 2)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (13, 13, 3)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (14, 14, 4)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (15, 15, 5)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (16, 16, 1)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (17, 17, 2)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (18, 18, 3)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (19, 19, 4)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (20, 20, 5)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (21, 21, 1)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (22, 22, 2)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (23, 23, 3)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (24, 24, 4)
GO
INSERT [dbo].[user_qualification] ([id], [userId], [qualificationId]) VALUES (25, 25, 5)
GO
SET IDENTITY_INSERT [dbo].[user_qualification] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (1, N'Dorothy', N'202cb962ac59075b964b07152d234b70', 1, N'Dorothy@example.com', N'+33 1 45 34 10 47', N'USA', N'New Jersey', N'Brookings')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (2, N'Aron', N'202cb962ac59075b964b07152d234b70', 2, N'Aron@example.com', N'+44 1564 771355', N'USA', N'North Carolina', N'Grosse Pointe Woods')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (3, N'Clint', N'202cb962ac59075b964b07152d234b70', 1, N'Clint@example.com', N'+33 5 84 44 46 99', N'USA', N'Kentucky', N'San Gabriel')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (4, N'Nancie', N'202cb962ac59075b964b07152d234b70', 2, N'Nancie@example.com', N'+52 65 0541 3007', N'USA', N'New Mexico', N'Bellmead')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (5, N'Olivia', N'202cb962ac59075b964b07152d234b70', 1, N'Olivia@example.com', N'+44 6265 061591', N'USA', N'Kentucky', N'Kettering')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (6, N'Florene', N'202cb962ac59075b964b07152d234b70', 2, N'Florene@example.com', N'+49-6549-152434', N'USA', N'South Dakota', N'McComb')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (7, N'Adelia', N'202cb962ac59075b964b07152d234b70', 1, N'Adelia@example.com', N'+33 0 01 97 25 55', N'USA', N'Alaska', N'Pittsfield')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (8, N'Ammie', N'202cb962ac59075b964b07152d234b70', 2, N'Ammie@example.com', N'+380 38 553-089-8', N'USA', N'Texas', N'Medina')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (9, N'Tajuana', N'202cb962ac59075b964b07152d234b70', 1, N'Tajuana@example.com', N'+49 (1229) 468603', N'USA', N'Wisconsin', N'Hazleton')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (10, N'Kina', N'202cb962ac59075b964b07152d234b70', 2, N'Kina@example.com', N'+380 50 357-299-3', N'USA', N'North Dakota', N'Pecos')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (11, N'Sharice', N'202cb962ac59075b964b07152d234b70', 1, N'Sharice@example.com', N'+55 76 3363-7938', N'USA', N'Iowa', N'Irondale')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (12, N'Jolyn', N'202cb962ac59075b964b07152d234b70', 2, N'Jolyn@example.com', N'+49 (4244) 565520', N'USA', N'Missouri', N'Old Forge')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (13, N'Adam', N'202cb962ac59075b964b07152d234b70', 1, N'Adam@example.com', N'+44 998 198 8570', N'USA', N'Massachusetts', N'Longview')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (14, N'Andrew', N'202cb962ac59075b964b07152d234b70', 2, N'Andrew@example.com', N'+55 10 5221-6573', N'USA', N'Colorado', N'Wilton Manors')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (15, N'Curtis', N'202cb962ac59075b964b07152d234b70', 1, N'Curtis@example.com', N'+420 679 961 060', N'USA', N'Washington', N'Cynthiana')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (16, N'Christene', N'202cb962ac59075b964b07152d234b70', 2, N'Christene@example.com', N'+49-0860-500003', N'USA', N'Illinois', N'Newport')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (17, N'Darrick', N'202cb962ac59075b964b07152d234b70', 1, N'Darrick@example.com', N'+49 (6227) 857444', N'USA', N'Hawaii', N'New Carrollton')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (18, N'Carl', N'202cb962ac59075b964b07152d234b70', 2, N'Carl@example.com', N'+33 0 02 66 66 02', N'USA', N'Rhode Island', N'Camas')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (19, N'Cheryl', N'202cb962ac59075b964b07152d234b70', 1, N'Cheryl@example.com', N'+380 61 782-323-6', N'USA', N'Vermont', N'Port Orchard')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (20, N'Joaquin', N'202cb962ac59075b964b07152d234b70', 2, N'Joaquin@example.com', N'+33 3 44 38 85 49', N'USA', N'California', N'Edenton')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (21, N'Trinidad', N'202cb962ac59075b964b07152d234b70', 1, N'Trinidad@example.com', N'+420 290 847 857', N'USA', N'Vermont', N'Orange Park')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (22, N'Korey', N'202cb962ac59075b964b07152d234b70', 2, N'Korey@example.com', N'+49-9268-849947', N'USA', N'Nevada', N'California City')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (23, N'Tabatha', N'202cb962ac59075b964b07152d234b70', 1, N'Tabatha@example.com', N'+420 282 834 142', N'USA', N'New Hampshire', N'Bonne Terre')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (24, N'Adolfo', N'202cb962ac59075b964b07152d234b70', 2, N'Adolfo@example.com', N'+49 5889 152209', N'USA', N'Nebraska', N'Surprise')
GO
INSERT [dbo].[users] ([userId], [userName], [userPassword], [userRoleId], [userEmail], [userPhone], [userCountry], [userState], [userCity]) VALUES (25, N'Abel', N'202cb962ac59075b964b07152d234b70', 1, N'Abel@example.com', N'+49 (7290) 485397', N'USA', N'Nevada', N'Northville')
GO
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[activity_log]  WITH NOCHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[batches]  WITH NOCHECK ADD FOREIGN KEY([batchCourseId])
REFERENCES [dbo].[courses] ([courseId])
GO
ALTER TABLE [dbo].[course_enrollment]  WITH NOCHECK ADD FOREIGN KEY([batchId])
REFERENCES [dbo].[batches] ([batchId])
GO
ALTER TABLE [dbo].[course_enrollment]  WITH NOCHECK ADD FOREIGN KEY([courseId])
REFERENCES [dbo].[courses] ([courseId])
GO
ALTER TABLE [dbo].[course_enrollment]  WITH NOCHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[courses]  WITH NOCHECK ADD FOREIGN KEY([courseCategoryId])
REFERENCES [dbo].[category] ([categoryId])
GO
ALTER TABLE [dbo].[courses]  WITH NOCHECK ADD FOREIGN KEY([courseInstructorID])
REFERENCES [dbo].[instructor] ([instructorId])
GO
ALTER TABLE [dbo].[courses]  WITH NOCHECK ADD FOREIGN KEY([courseMinQualificationId])
REFERENCES [dbo].[qualifications] ([qualificationId])
GO
ALTER TABLE [dbo].[enquiries]  WITH NOCHECK ADD FOREIGN KEY([enquiryUserId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[enquiries]  WITH NOCHECK ADD FOREIGN KEY([enquiryCourseId])
REFERENCES [dbo].[courses] ([courseId])
GO
ALTER TABLE [dbo].[user_batch]  WITH NOCHECK ADD FOREIGN KEY([batchId])
REFERENCES [dbo].[batches] ([batchId])
GO
ALTER TABLE [dbo].[user_batch]  WITH NOCHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[user_qualification]  WITH NOCHECK ADD FOREIGN KEY([qualificationId])
REFERENCES [dbo].[qualifications] ([qualificationId])
GO
ALTER TABLE [dbo].[user_qualification]  WITH NOCHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[users]  WITH NOCHECK ADD FOREIGN KEY([userRoleId])
REFERENCES [dbo].[role] ([roleId])
GO
USE [master]
GO
ALTER DATABASE [chummaveruthe] SET  READ_WRITE 
GO
