USE [master]
GO
/****** Object:  Database [LearningApp]    Script Date: 18/12/2024 5:56:19 CH ******/
CREATE DATABASE [LearningApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LearningApp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LearningApp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LearningApp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LearningApp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LearningApp] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LearningApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LearningApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LearningApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LearningApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LearningApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LearningApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [LearningApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LearningApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LearningApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LearningApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LearningApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LearningApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LearningApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LearningApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LearningApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LearningApp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LearningApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LearningApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LearningApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LearningApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LearningApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LearningApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LearningApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LearningApp] SET RECOVERY FULL 
GO
ALTER DATABASE [LearningApp] SET  MULTI_USER 
GO
ALTER DATABASE [LearningApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LearningApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LearningApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LearningApp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LearningApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LearningApp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LearningApp', N'ON'
GO
ALTER DATABASE [LearningApp] SET QUERY_STORE = ON
GO
ALTER DATABASE [LearningApp] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LearningApp]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 18/12/2024 5:56:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[feedback_id] [int] NOT NULL,
	[user_id] [int] NULL,
	[lesson_id] [int] NULL,
	[content] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lessons]    Script Date: 18/12/2024 5:56:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lessons](
	[lesson_id] [int] NOT NULL,
	[lesson_name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[lesson_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDF_Materials]    Script Date: 18/12/2024 5:56:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDF_Materials](
	[pdf_id] [int] NOT NULL,
	[lesson_id] [int] NULL,
	[pdf_link] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pdf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPTX_Materials]    Script Date: 18/12/2024 5:56:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPTX_Materials](
	[pptx_id] [int] NOT NULL,
	[lesson_id] [int] NULL,
	[pptx_link] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pptx_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quizzes]    Script Date: 18/12/2024 5:56:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quizzes](
	[quiz_id] [int] NOT NULL,
	[lesson_id] [int] NULL,
	[question] [nvarchar](max) NOT NULL,
	[answer] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 18/12/2024 5:56:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[role] [varchar](10) NOT NULL,
 CONSTRAINT [PK__Users__B9BE370F4413EC75] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Video_Materials]    Script Date: 18/12/2024 5:56:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video_Materials](
	[video_id] [int] NOT NULL,
	[lesson_id] [int] NULL,
	[video_link] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[video_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (4, 37, 1, N'Feedback 4 from User 37 for Lesson 1')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (9, 20, 7, N'Feedback 9 from User 20 for Lesson 7')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (12, 79, 6, N'Feedback 12 from User 79 for Lesson 6')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (14, 67, 3, N'Feedback 14 from User 67 for Lesson 3')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (15, 84, 8, N'Feedback 15 from User 84 for Lesson 8')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (21, 30, 5, N'Feedback 21 from User 30 for Lesson 5')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (25, 91, 3, N'Feedback 25 from User 91 for Lesson 3')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (28, 96, 5, N'Feedback 28 from User 96 for Lesson 5')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (31, 77, 4, N'Feedback 31 from User 77 for Lesson 4')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (34, 82, 5, N'Feedback 34 from User 82 for Lesson 5')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (40, 90, 6, N'Feedback 40 from User 90 for Lesson 6')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (41, 31, 5, N'Feedback 41 from User 31 for Lesson 5')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (43, 64, 5, N'Feedback 43 from User 64 for Lesson 5')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (44, 12, 8, N'Feedback 44 from User 12 for Lesson 8')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (47, 88, 4, N'Feedback 47 from User 88 for Lesson 4')
INSERT [dbo].[Feedback] ([feedback_id], [user_id], [lesson_id], [content]) VALUES (48, 22, 8, N'Feedback 48 from User 22 for Lesson 8')
GO
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (1, N'Giới thiệu về lập trình Python và các công cụ lập trình', N'Nắm được khái niệm ngôn ngữ lập trình Python
Biết cách tải và cải đặt Python
Sử dụng được một số công cụ lập trình như IDLE, PyCharm
Tạo được và hiểu được cấu trúc của một Project')
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (2, N'Các khái niệm cơ bản', N'Hiểu và thực hiện được các kiểu dữ liệu cơ bản
Khai báo được biến, ghi chú
Thực hành được các toán tử
Nhập liệu được từ bàn phím
Xử lý được các lỗi ')
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (3, N'Các biểu thức điều kiện và vòng lặp', N'Hiểu và vận hành được các cấu trúc điều kiện: boolean, if, else, elif
Nắm được biểu thức pass
So sánh được số thực trong Python
Hiểu và vận hành được cấu trúc vòng lặp: while, for, while/else, for/else
Hiểu và vận hành được biểu thức break, continue')
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (4, N'Hàm trong Python', N'Hiểu được khái niệm và nguyên tắc hoạt động về hàm
Biết cách viết hàm, gọi hàm
Sử dụng được Global variable, Parameter mặc định
Hiểu và thực hiện được hàm đệ quy
Sử dụng được một số hàm có sẵn của Python: các hàm toán học, round, time, random, exit, eval…')
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (5, N'Xử lý chuỗi', N'Hiểu được khái niệm và cấu trúc của chuỗi
Thực hiện được các hàm in hoa , in thường
Thực hiện được các hàm căn lề, xóa khoảng trắng
Thực hiện được các hàm tìm kiếm
Thực hiện được các hàm định dạng
Thực hiện được các hàm tách chuỗi và nối chuỗi')
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (6, N'Xử lý danh sách', N'Hiểu được cơ chế vận hành của List
Khai báo và sử dụng được List
Thực hiện được các hàm: duyệt, gán, chèn, nối đuôi, xóa, đảo ngược, sắp xếp, slicing
Hiểu và thực hiện được List đa chiều')
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (7, N'Xử lý tập tin', N'Hiểu được lý do vì sao phải lưu và đọc tập tin
Phân biệt được các loại tập tin thông dụng
Ghi được tập tin
Đọc được tập tin')
INSERT [dbo].[Lessons] ([lesson_id], [lesson_name], [description]) VALUES (8, N'Thiết kế giao diện với tkinter', N'Hiểu được cách hoạt động của tkinter
Nắm được kỹ thuật sử dụng các control cơ bản trong tkinter
Thiết kế giao diện được với tkinter')
GO
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (1, 1, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (2, 1, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (3, 1, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (4, 1, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (5, 1, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (6, 1, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (7, 2, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (8, 2, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (9, 2, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (10, 2, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (11, 2, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (12, 2, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (13, 3, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (14, 3, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (15, 3, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (16, 3, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (17, 3, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (18, 3, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (19, 4, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (20, 4, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (21, 4, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (22, 4, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (23, 4, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (24, 4, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (25, 5, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (26, 5, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (27, 5, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (28, 5, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (29, 5, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (30, 5, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (31, 6, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (32, 6, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (33, 6, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (34, 6, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (35, 6, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (36, 6, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (37, 7, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (38, 7, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (39, 7, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (40, 7, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (41, 7, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (42, 7, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (43, 8, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EXqeYUj_HlFKoyDJzAyRRIkBWBDCMIQelJjogtQJr_N0tg?e=3fYekF')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (44, 8, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ERrrue73VnlGt3FlBMrRDKIB7rPgJ0NENOgfaebqV8fewA?e=567HbQ')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (45, 8, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWA7F2pfOcdFkPf40VWARcABtAPr6X0dYgzBY4uXz8Im-g?e=BE9p3z')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (46, 8, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EYad8FAHYc9AvfHSXcpuovgBH_crACw4MOo1oOkqxUzHjw?e=sla35T')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (47, 8, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/EWxJL1ejs69PkOao6dShS2wBvSNhBnDxuyH2-N6zw7s6vw?e=V5DlGf')
INSERT [dbo].[PDF_Materials] ([pdf_id], [lesson_id], [pdf_link]) VALUES (48, 8, N'https://uithcm-my.sharepoint.com/:b:/g/personal/22521329_ms_uit_edu_vn/ESdm1Tn49j9LuU3PTLehhJoBWwEM35hEip9kMdQuLMGYHw?e=xLeLdj')
GO
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (1, 1, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/EcRMcfs2ZqhKgI-IjY_UKc8BzTq-4N-zTFlz-TPRzMivYA?e=YzyACc')
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (2, 2, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/EQkXdXBpGx9BntbZD3uiRlIBA10mjOGrgBQVd95GKSj6_w?e=W8Tbem')
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (3, 3, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/Ef-bmP-EPFZHoTCkyAqgnH0B6fZfYN2O3Ph_MhYdro5UhA?e=8qLNP4')
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (4, 4, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/ETYNQ3di4r5Ag_mV7LvRlcwBLt9AjdaG3OE3wbCtqtS1Yg?e=bFhugb')
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (5, 5, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/EYKvHpTo7-pMhWQ_xMDw1AwB3VaMEGfORon7D7X89_Wftg?e=H62tNY')
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (6, 6, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/ETBH2TCZ9xZIttFTWCY6KlcBLpP6Z9kwkj0MkNPu2VRIxw?e=ZCwnhA')
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (7, 7, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/EXmXzLw-fxpDoVY-JGARhb8B-q5PK9q3Ix3xQP_6jdBIxQ?e=wdHR7K')
INSERT [dbo].[PPTX_Materials] ([pptx_id], [lesson_id], [pptx_link]) VALUES (8, 8, N'https://uithcm-my.sharepoint.com/:p:/g/personal/22521329_ms_uit_edu_vn/EW5vRUX2lVlMl117s9idPrsBOZGienKrEQcZShbexWVHtg?e=Zr95Lk')
GO
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (1, 1, N'Python có phải là ngôn ngữ lập trình dễ học cho người mới bắt đầu không?
A. Có
B. Không', N'A. Có')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (2, 1, N'Python được sử dụng rộng rãi trong các lĩnh vực nào sau đây?
A. Phát triển web
B. Khoa học dữ liệu
C. Trí tuệ nhân tạo
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (3, 1, N'Trang web chính thức để tải Python là gì?
A. www.python.org
B. www.python.com
C. www.python.net
D. www.python.edu', N'A. www.python.org')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (4, 1, N'Sau khi tải Python, bạn cần làm gì để kiểm tra xem Python đã được cài đặt thành công trên máy tính của mình?
A. Mở trình duyệt web và tìm kiếm "Python"
B. Mở Command Prompt hoặc Terminal và gõ "python --version"
C. Khởi động lại máy tính
D. Không cần làm gì cả', N'B. Mở Command Prompt hoặc Terminal và gõ "python --version"')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (5, 1, N'Công cụ nào sau đây là một IDE phổ biến để lập trình Python?
A. PyCharm
B. Microsoft Word
C. Adobe Photoshop
D. Google Chrome', N'A. PyCharm')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (6, 1, N'Jupyter Notebook thường được sử dụng trong lĩnh vực nào?
A. Phát triển web
B. Khoa học dữ liệu và học máy
C. Thiết kế đồ họa
D. Chỉnh sửa video', N'B. Khoa học dữ liệu và học máy')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (7, 1, N'Để tạo một dự án mới trong PyCharm, bạn cần chọn tùy chọn nào từ menu?
A. File > New Project
B. Edit > New Project
C. View > New Project
D. Help > New Project', N'A. File > New Project')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (8, 1, N'Khi tạo một dự án Python mới trong PyCharm, bạn cần chỉ định gì?
A. Đường dẫn lưu trữ dự án
B. Phiên bản Python
C. Tên dự án
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (9, 2, N'Kiểu dữ liệu nào sau đây là kiểu dữ liệu cơ bản trong Python?
A. int
B. float
C. str
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (10, 2, N'Cách khai báo biến trong Python là gì?
A. var x = 10
B. x = 10
C. int x = 10
D. let x = 10', N'B. x = 10')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (11, 2, N'Để ghi chú một dòng lệnh trong Python, bạn sử dụng ký tự nào?
A. //
B. #
C. /*
D. --', N'B. #')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (12, 2, N'Để ghi chú nhiều dòng lệnh trong Python, bạn sử dụng ký tự nào?
A. """
B. ''''''
C. ##
D. Cả A và B', N'D. Cả A và B')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (13, 2, N'Toán tử nào sau đây được sử dụng để cộng hai số trong Python?
A. -
B. +
C. *
D. /', N'B. +')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (14, 2, N'Toán tử nào sau đây được sử dụng để so sánh hai giá trị trong Python?
A. ==
B. =
C. !=
D. Cả A và C', N'D. Cả A và C')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (15, 2, N'Hàm nào sau đây được sử dụng để nhập liệu từ bàn phím trong Python?
A. input()
B. read()
C. scan()
D. get()', N'A. input()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (16, 2, N'Kết quả của hàm input() luôn có kiểu dữ liệu gì?
A. int
B. float
C. str
D. bool', N'C. str')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (17, 2, N'Hàm nào sau đây được sử dụng để xuất dữ liệu ra màn hình trong Python?
A. print()
B. echo()
C. display()
D. show()', N'A. print()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (18, 2, N'Để xuất dữ liệu với định dạng cụ thể, bạn có thể sử dụng phương pháp nào sau đây?
A. f-string
B. format()
C. %
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (19, 2, N'Lỗi nào sau đây là lỗi cú pháp trong Python?
A. SyntaxError
B. TypeError
C. ValueError
D. IndexError', N'A. SyntaxError')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (20, 2, N'Lỗi nào sau đây xảy ra khi bạn cố gắng truy cập một chỉ số không tồn tại trong danh sách?
A. SyntaxError
B. TypeError
C. ValueError
D. IndexError', N'D. IndexError')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (21, 3, N'Biểu thức Boolean trong Python có thể có giá trị nào?
A. True
B. False
C. Cả A và B
D. None', N'C. Cả A và B')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (22, 3, N'Kết quả của biểu thức 5 > 3 trong Python là gì?
A. True
B. False
C. None
D. Error', N'A. True')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (23, 3, N'Cú pháp của biểu thức if trong Python là gì?
A. if condition:
B. if (condition)
C. if condition then
D. if (condition):', N'A. if condition:')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (24, 3, N'Biểu thức if trong Python có thể kiểm tra điều kiện nào?
A. Biểu thức Boolean
B. Biểu thức số học
C. Biểu thức chuỗi
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (25, 3, N'Cú pháp của biểu thức if ... else trong Python là gì?
A. if condition: ... else:
B. if (condition): ... else:
C. if condition: ... else
D. if (condition): ... else', N'A. if condition: ... else:')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (26, 3, N'Biểu thức if ... else được sử dụng để làm gì?
A. Thực hiện một khối lệnh nếu điều kiện đúng, và một khối lệnh khác nếu điều kiện sai
B. Thực hiện một khối lệnh nếu điều kiện đúng
C. Thực hiện một khối lệnh nếu điều kiện sai
D. Không có đáp án nào đúng', N'A. Thực hiện một khối lệnh nếu điều kiện đúng, và một khối lệnh khác nếu điều kiện sai')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (27, 3, N'Cú pháp của biểu thức if ... elif ... else trong Python là gì?
A. if condition: ... elif condition: ... else:
B. if (condition): ... elif (condition): ... else:
C. if condition: ... elif condition: ... else
D. if (condition): ... elif (condition): ... else', N'A. if condition: ... elif condition: ... else:')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (28, 3, N'Biểu thức if ... elif ... else được sử dụng để làm gì?
A. Kiểm tra nhiều điều kiện khác nhau và thực hiện các khối lệnh tương ứng
B. Kiểm tra một điều kiện duy nhất
C. Thực hiện một khối lệnh nếu điều kiện đúng
D. Thực hiện một khối lệnh nếu điều kiện sai', N'A. Kiểm tra nhiều điều kiện khác nhau và thực hiện các khối lệnh tương ứng')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (29, 3, N'Biểu thức pass trong Python được sử dụng để làm gì?
A. Bỏ qua một khối lệnh mà không thực hiện gì
B. Thực hiện một khối lệnh
C. Kết thúc chương trình
D. Không có đáp án nào đúng', N'A. Bỏ qua một khối lệnh mà không thực hiện gì')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (30, 3, N'Khi nào bạn nên sử dụng biểu thức pass?
A. Khi bạn muốn để trống một khối lệnh mà không gây lỗi cú pháp
B. Khi bạn muốn kết thúc chương trình
C. Khi bạn muốn thực hiện một khối lệnh
D. Khi bạn muốn bỏ qua một dòng lệnh', N'A. Khi bạn muốn để trống một khối lệnh mà không gây lỗi cú pháp')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (31, 3, N'Để so sánh hai số thực trong Python, bạn nên sử dụng phương pháp nào?
A. Sử dụng toán tử == trực tiếp
B. Sử dụng hàm math.isclose()
C. Sử dụng toán tử != trực tiếp
D. Sử dụng hàm float.compare()', N'B. Sử dụng hàm math.isclose()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (32, 3, N'Hàm math.isclose(a, b) trả về giá trị nào nếu a và b gần bằng nhau?
A. True
B. False
C. None
D. Error', N'A. True')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (33, 3, N'Cú pháp của biểu thức if/else như phép gán trong Python là gì?
A. x = a if condition else b
B. x = if condition: a else: b
C. x = a if condition: else b
D. x = if condition then a else b', N'A. x = a if condition else b')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (34, 3, N'Biểu thức if/else như phép gán được sử dụng để làm gì?
A. Gán giá trị cho biến dựa trên điều kiện
B. Thực hiện một khối lệnh nếu điều kiện đúng
C. Thực hiện một khối lệnh nếu điều kiện sai
D. Không có đáp án nào đúng', N'A. Gán giá trị cho biến dựa trên điều kiện')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (35, 3, N'Cú pháp của vòng lặp while trong Python là gì?
A. while condition:
B. while (condition):
C. while condition then:
D. while (condition) then:', N'A. while condition:')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (36, 3, N'Vòng lặp while sẽ tiếp tục lặp lại cho đến khi nào?
A. Điều kiện trở thành False
B. Điều kiện trở thành True
C. Một giá trị cụ thể được trả về
D. Không có đáp án nào đúng', N'A. Điều kiện trở thành False')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (37, 3, N'Cú pháp của vòng lặp for trong Python là gì?
A. for item in iterable:
B. for (item in iterable):
C. for item: in iterable
D. for (item): in iterable', N'A. for item in iterable:')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (38, 3, N'Vòng lặp for thường được sử dụng để làm gì?
A. Lặp qua các phần tử của một iterable (như danh sách, tuple, từ điển)
B. Thực hiện một khối lệnh một lần
C. Kiểm tra điều kiện
D. Không có đáp án nào đúng', N'A. Lặp qua các phần tử của một iterable (như danh sách, tuple, từ điển)')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (39, 3, N'Câu lệnh break trong Python được sử dụng để làm gì?
A. Thoát khỏi vòng lặp hiện tại
B. Bỏ qua một lần lặp và tiếp tục vòng lặp
C. Kết thúc chương trình
D. Không có đáp án nào đúng', N'A. Thoát khỏi vòng lặp hiện tại')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (40, 3, N'Khi nào bạn nên sử dụng câu lệnh break?
A. Khi bạn muốn kết thúc vòng lặp sớm dựa trên một điều kiện
B. Khi bạn muốn bỏ qua một lần lặp
C. Khi bạn muốn kết thúc chương trình
D. Khi bạn muốn kiểm tra điều kiện', N'A. Khi bạn muốn kết thúc vòng lặp sớm dựa trên một điều kiện')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (41, 3, N'Câu lệnh continue trong Python được sử dụng để làm gì?
A. Bỏ qua một lần lặp và tiếp tục vòng lặp
B. Thoát khỏi vòng lặp hiện tại
C. Kết thúc chương trình
D. Không có đáp án nào đúng', N'A. Bỏ qua một lần lặp và tiếp tục vòng lặp')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (42, 3, N'Khi nào bạn nên sử dụng câu lệnh continue?
A. Khi bạn muốn bỏ qua một lần lặp dựa trên một điều kiện
B. Khi bạn muốn kết thúc vòng lặp sớm
C. Khi bạn muốn kết thúc chương trình
D. Khi bạn muốn kiểm tra điều kiện', N'A. Khi bạn muốn bỏ qua một lần lặp dựa trên một điều kiện')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (43, 3, N'Cú pháp của lệnh while/else trong Python là gì?
A. while condition: ... else:
B. while (condition): ... else:
C. while condition then: ... else:
D. while (condition) then: ... else:', N'A. while condition: ... else:')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (44, 3, N'Khối lệnh else trong lệnh while/else sẽ được thực hiện khi nào?
A. Khi vòng lặp while kết thúc mà không gặp câu lệnh break
B. Khi vòng lặp while kết thúc mà gặp câu lệnh break
C. Khi điều kiện của vòng lặp while trở thành True
D. Không có đáp án nào đúng', N'A. Khi vòng lặp while kết thúc mà không gặp câu lệnh break')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (45, 3, N'Cú pháp của lệnh for/else trong Python là gì?
A. for item in iterable: ... else:
B. for (item in iterable): ... else:
C. for item: in iterable ... else:
D. for (item): in iterable ... else:', N'A. for item in iterable: ... else:')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (46, 3, N'Khối lệnh else trong lệnh for/else sẽ được thực hiện khi nào?
A. Khi vòng lặp for kết thúc mà không gặp câu lệnh break
B. Khi vòng lặp for kết thúc mà gặp câu lệnh break
C. Khi điều kiện của vòng lặp for trở thành True
D. Không có đáp án nào đúng', N'A. Khi vòng lặp for kết thúc mà không gặp câu lệnh break')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (47, 3, N'Vòng lặp lồng nhau là gì?
A. Vòng lặp bên trong một vòng lặp khác
B. Vòng lặp chỉ có một lần lặp
C. Vòng lặp không có điều kiện
D. Không có đáp án nào đúng', N'A. Vòng lặp bên trong một vòng lặp khác')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (48, 3, N'Khi sử dụng vòng lặp lồng nhau, vòng lặp bên trong sẽ được thực hiện bao nhiêu lần?
A. Một lần
B. Số lần bằng số lần lặp của vòng lặp bên ngoài
C. Số lần bằng số lần lặp của vòng lặp bên trong
D. Số lần bằng tích của số lần lặp của cả hai vòng lặp', N'D. Số lần bằng tích của số lần lặp của cả hai vòng lặp')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (49, 4, N'Hàm trong Python là gì?
A. Một khối lệnh có thể tái sử dụng
B. Một biến toàn cục
C. Một kiểu dữ liệu
D. Một vòng lặp', N'A. Một khối lệnh có thể tái sử dụng')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (50, 4, N'Hàm giúp ích gì trong lập trình?
A. Giảm thiểu mã lặp lại
B. Tăng tính tổ chức của mã
C. Dễ dàng bảo trì và mở rộng
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (51, 4, N'Cú pháp tổng quát để định nghĩa một hàm trong Python là gì?
A. def function_name(parameters):
B. function function_name(parameters):
C. define function_name(parameters):
D. func function_name(parameters):', N'A. def function_name(parameters):')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (52, 4, N'Một hàm có thể không có tham số nào không?
A. Có
B. Không', N'A. Có')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (53, 4, N'Cách gọi một hàm trong Python là gì?
A. function_name()
B. call function_name()
C. execute function_name()
D. run function_name()', N'A. function_name()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (54, 4, N'Khi gọi một hàm, bạn có thể truyền bao nhiêu tham số?
A. Không giới hạn
B. Tối đa 10 tham số
C. Tối đa 5 tham số
D. Không thể truyền tham số', N'A. Không giới hạn')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (55, 4, N'Hàm trong Python có thể trả về giá trị không?
A. Có
B. Không', N'A. Có')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (56, 4, N'Từ khóa nào được sử dụng để trả về giá trị từ một hàm?
A. return
B. yield
C. output
D. give', N'A. return')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (57, 4, N'Cách viết tài liệu cho một hàm trong Python là gì?
A. Sử dụng chuỗi docstring ngay sau định nghĩa hàm
B. Sử dụng chú thích #
C. Sử dụng từ khóa doc
D. Sử dụng từ khóa comment', N'A. Sử dụng chuỗi docstring ngay sau định nghĩa hàm')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (58, 4, N'Chuỗi docstring được đặt trong dấu gì?
A. Dấu ngoặc kép ba lần (""" """)
B. Dấu ngoặc đơn ba lần ('''''' '''''')
C. Dấu ngoặc kép đơn (")
D. Cả A và B', N'D. Cả A và B')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (59, 4, N'Biến toàn cục (global variable) là gì?
A. Biến được định nghĩa bên ngoài tất cả các hàm và có thể được truy cập từ bất kỳ đâu trong mã
B. Biến được định nghĩa bên trong một hàm
C. Biến chỉ có thể được truy cập từ một hàm cụ thể
D. Biến chỉ có thể được truy cập từ một vòng lặp cụ thể', N'A. Biến được định nghĩa bên ngoài tất cả các hàm và có thể được truy cập từ bất kỳ đâu trong mã')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (60, 4, N'Từ khóa nào được sử dụng để khai báo một biến toàn cục bên trong một hàm?
A. global
B. local
C. var
D. globalize', N'A. global')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (61, 4, N'Tham số mặc định trong hàm là gì?
A. Tham số có giá trị mặc định nếu không được truyền giá trị khi gọi hàm
B. Tham số không có giá trị mặc định
C. Tham số bắt buộc phải có giá trị khi gọi hàm
D. Tham số không thể có giá trị mặc định', N'A. Tham số có giá trị mặc định nếu không được truyền giá trị khi gọi hàm')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (62, 4, N'Cú pháp để định nghĩa một tham số mặc định trong hàm là gì?
A. def function_name(param=value):
B. def function_name(param==value):
C. def function_name(param=value):
D. def function_name(param=value):', N'A. def function_name(param=value):')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (63, 4, N'Lambda expression trong Python là gì?
A. Một cách để định nghĩa các hàm ẩn danh
B. Một biến toàn cục
C. Một kiểu dữ liệu
D. Một vòng lặp', N'A. Một cách để định nghĩa các hàm ẩn danh')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (64, 4, N'Cú pháp của lambda expression trong Python là gì?
A. lambda arguments: expression
B. lambda (arguments): expression
C. lambda arguments => expression
D. lambda (arguments) => expression', N'A. lambda arguments: expression')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (65, 4, N'Hàm đệ qui là gì?
A. Hàm gọi chính nó
B. Hàm không có tham số
C. Hàm không trả về giá trị
D. Hàm chỉ được gọi một lần', N'A. Hàm gọi chính nó')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (66, 4, N'Điều kiện dừng trong hàm đệ qui là gì?
A. Điều kiện để kết thúc đệ qui và tránh vòng lặp vô hạn
B. Điều kiện để bắt đầu đệ qui
C. Điều kiện để gọi hàm khác
D. Điều kiện để trả về giá trị', N'A. Điều kiện để kết thúc đệ qui và tránh vòng lặp vô hạn')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (67, 4, N'Hàm math.sqrt(x) trong Python trả về giá trị gì?
A. Bình phương của x
B. Căn bậc hai của x
C. Giá trị tuyệt đối của x
D. Logarit của x', N'B. Căn bậc hai của x')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (68, 4, N'Hàm math.pow(x, y) trong Python trả về giá trị gì?
A. x cộng y
B. x trừ y
C. x nhân y
D. x mũ y', N'D. x mũ y')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (69, 4, N'Hàm round(x) trong Python được sử dụng để làm gì?
A. Làm tròn x đến số nguyên gần nhất
B. Làm tròn x đến số thập phân gần nhất
C. Làm tròn x đến số nguyên lớn nhất
D. Làm tròn x đến số nguyên nhỏ nhất', N'A. Làm tròn x đến số nguyên gần nhất')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (70, 4, N'Kết quả của round(3.14159, 2) là gì?
A. 3.14
B. 3.15
C. 3.1
D. 3.2', N'A. 3.14')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (71, 4, N'Hàm time.time() trong Python trả về giá trị gì?
A. Thời gian hiện tại dưới dạng số giây kể từ epoch (1970-01-01 00:00:00 UTC)
B. Thời gian hiện tại dưới dạng chuỗi
C. Ngày hiện tại
D. Giờ hiện tại', N'A. Thời gian hiện tại dưới dạng số giây kể từ epoch (1970-01-01 00:00:00 UTC)')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (72, 4, N'Hàm time.sleep(seconds) trong Python được sử dụng để làm gì?
A. Tạm dừng chương trình trong một khoảng thời gian xác định
B. Lấy thời gian hiện tại
C. Định dạng thời gian
D. Tính toán thời gian', N'A. Tạm dừng chương trình trong một khoảng thời gian xác định')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (73, 4, N'Hàm random.randint(a, b) trong Python trả về giá trị gì?
A. Một số nguyên ngẫu nhiên trong khoảng từ a đến b (bao gồm cả a và b)
B. Một số thực ngẫu nhiên trong khoảng từ a đến b
C. Một số nguyên ngẫu nhiên trong khoảng từ a đến b (không bao gồm a và b)
D. Một số thực ngẫu nhiên trong khoảng từ a đến b (không bao gồm a và b)', N'A. Một số nguyên ngẫu nhiên trong khoảng từ a đến b (bao gồm cả a và b)')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (74, 4, N'Hàm random.choice(sequence) trong Python được sử dụng để làm gì?
A. Chọn một phần tử ngẫu nhiên từ một sequence (danh sách, tuple, chuỗi)
B. Sắp xếp một sequence theo thứ tự ngẫu nhiên
C. Tạo một sequence ngẫu nhiên
D. Xóa một phần tử ngẫu nhiên từ một sequence', N'A. Chọn một phần tử ngẫu nhiên từ một sequence (danh sách, tuple, chuỗi)')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (75, 4, N'Hàm exit() trong Python được sử dụng để làm gì?
A. Thoát khỏi chương trình
B. Tạm dừng chương trình
C. Khởi động lại chương trình
D. Không có đáp án nào đúng', N'A. Thoát khỏi chương trình')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (76, 4, N'Hàm exit() thuộc thư viện nào trong Python?
A. sys
B. os
C. time
D. random', N'A. sys')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (77, 4, N'Hàm eval(expression) trong Python được sử dụng để làm gì?
A. Thực thi một biểu thức Python được truyền vào dưới dạng chuỗi
B. Đánh giá một biểu thức logic
C. Tính toán giá trị của một biểu thức số học
D. Kiểm tra kiểu dữ liệu của một biến', N'A. Thực thi một biểu thức Python được truyền vào dưới dạng chuỗi')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (78, 4, N'Kết quả của eval(''3 + 5'') là gì?
A. 8
B. ''3 + 5''
C. 35
D. Error', N'A. 8')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (79, 5, N'Chuỗi (string) trong Python là gì?
A. Một tập hợp các ký tự
B. Một số nguyên
C. Một số thực
D. Một biến boolean', N'A. Một tập hợp các ký tự')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (80, 5, N'Chuỗi trong Python được bao quanh bởi ký tự nào?
A. Dấu ngoặc kép (")
B. Dấu ngoặc đơn ('')
C. Dấu ngoặc kép ba lần (""" """)
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (81, 5, N'Hàm upper() trong Python được sử dụng để làm gì?
A. Chuyển đổi tất cả các ký tự trong chuỗi thành chữ hoa
B. Chuyển đổi tất cả các ký tự trong chuỗi thành chữ thường
C. Xóa khoảng trắng trong chuỗi
D. Tìm kiếm một ký tự trong chuỗi', N'A. Chuyển đổi tất cả các ký tự trong chuỗi thành chữ hoa')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (82, 5, N'Hàm lower() trong Python được sử dụng để làm gì?
A. Chuyển đổi tất cả các ký tự trong chuỗi thành chữ thường
B. Chuyển đổi tất cả các ký tự trong chuỗi thành chữ hoa
C. Xóa khoảng trắng trong chuỗi
D. Tìm kiếm một ký tự trong chuỗi', N'A. Chuyển đổi tất cả các ký tự trong chuỗi thành chữ thường')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (83, 5, N'Hàm rjust(width) trong Python được sử dụng để làm gì?
A. Căn lề phải chuỗi với độ rộng xác định
B. Căn lề trái chuỗi với độ rộng xác định
C. Căn giữa chuỗi với độ rộng xác định
D. Xóa khoảng trắng trong chuỗi', N'A. Căn lề phải chuỗi với độ rộng xác định')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (84, 5, N'Hàm ljust(width) trong Python được sử dụng để làm gì?
A. Căn lề trái chuỗi với độ rộng xác định
B. Căn lề phải chuỗi với độ rộng xác định
C. Căn giữa chuỗi với độ rộng xác định
D. Xóa khoảng trắng trong chuỗi', N'A. Căn lề trái chuỗi với độ rộng xác định')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (85, 5, N'Hàm center(width) trong Python được sử dụng để làm gì?
A. Căn giữa chuỗi với độ rộng xác định
B. Căn lề trái chuỗi với độ rộng xác định
C. Căn lề phải chuỗi với độ rộng xác định
D. Xóa khoảng trắng trong chuỗi', N'A. Căn giữa chuỗi với độ rộng xác định')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (86, 5, N'Hàm strip() trong Python được sử dụng để làm gì?
A. Xóa khoảng trắng ở đầu và cuối chuỗi
B. Xóa khoảng trắng ở giữa chuỗi
C. Xóa tất cả các ký tự trong chuỗi
D. Xóa một ký tự cụ thể trong chuỗi', N'A. Xóa khoảng trắng ở đầu và cuối chuỗi')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (87, 5, N'Hàm rstrip() trong Python được sử dụng để làm gì?
A. Xóa khoảng trắng ở cuối chuỗi
B. Xóa khoảng trắng ở đầu chuỗi
C. Xóa khoảng trắng ở giữa chuỗi
D. Xóa tất cả các ký tự trong chuỗi', N'A. Xóa khoảng trắng ở cuối chuỗi')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (88, 5, N'Hàm startswith(prefix) trong Python được sử dụng để làm gì?
A. Kiểm tra xem chuỗi có bắt đầu bằng tiền tố (prefix) không
B. Kiểm tra xem chuỗi có kết thúc bằng hậu tố (suffix) không
C. Tìm kiếm một ký tự trong chuỗi
D. Chuyển đổi chuỗi thành chữ hoa', N'A. Kiểm tra xem chuỗi có bắt đầu bằng tiền tố (prefix) không')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (89, 5, N'Hàm endswith(suffix) trong Python được sử dụng để làm gì?
A. Kiểm tra xem chuỗi có kết thúc bằng hậu tố (suffix) không
B. Kiểm tra xem chuỗi có bắt đầu bằng tiền tố (prefix) không
C. Tìm kiếm một ký tự trong chuỗi
D. Chuyển đổi chuỗi thành chữ thường', N'A. Kiểm tra xem chuỗi có kết thúc bằng hậu tố (suffix) không')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (90, 5, N'Hàm find(sub) trong Python được sử dụng để làm gì?
A. Tìm vị trí đầu tiên của chuỗi con (sub) trong chuỗi
B. Đếm số lần xuất hiện của chuỗi con (sub) trong chuỗi
C. Xóa chuỗi con (sub) trong chuỗi
D. Thay thế chuỗi con (sub) trong chuỗi', N'A. Tìm vị trí đầu tiên của chuỗi con (sub) trong chuỗi')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (91, 5, N'Hàm count(sub) trong Python được sử dụng để làm gì?
A. Đếm số lần xuất hiện của chuỗi con (sub) trong chuỗi
B. Tìm vị trí đầu tiên của chuỗi con (sub) trong chuỗi
C. Xóa chuỗi con (sub) trong chuỗi
D. Thay thế chuỗi con (sub) trong chuỗi', N'A. Đếm số lần xuất hiện của chuỗi con (sub) trong chuỗi')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (92, 5, N'Hàm format() trong Python được sử dụng để làm gì?
A. Định dạng chuỗi theo mẫu
B. Tìm kiếm một ký tự trong chuỗi
C. Xóa khoảng trắng trong chuỗi
D. Chuyển đổi chuỗi thành chữ hoa', N'A. Định dạng chuỗi theo mẫu')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (93, 5, N'Cú pháp để lấy một phần chuỗi (substring) trong Python là gì?
A. string[start:end]
B. string(start:end)
C. string[start to end]
D. string(start to end)', N'A. string[start:end]')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (94, 5, N'Hàm split(separator) trong Python được sử dụng để làm gì?
A. Tách chuỗi thành danh sách các chuỗi con dựa trên ký tự phân tách (separator)
B. Nối các chuỗi con thành một chuỗi
C. Xóa chuỗi con trong chuỗi
D. Thay thế chuỗi con trong chuỗi', N'A. Tách chuỗi thành danh sách các chuỗi con dựa trên ký tự phân tách (separator)')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (95, 5, N'Kết quả của split() khi không truyền tham số là gì?
A. Tách chuỗi dựa trên khoảng trắng
B. Tách chuỗi dựa trên dấu phẩy
C. Tách chuỗi dựa trên dấu chấm
D. Tách chuỗi dựa trên dấu chấm phẩy', N'A. Tách chuỗi dựa trên khoảng trắngi')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (96, 5, N'Hàm join(iterable) trong Python được sử dụng để làm gì?
A. Nối các phần tử của iterable thành một chuỗi
B. Tách chuỗi thành danh sách các chuỗi con
C. Xóa chuỗi con trong chuỗi
D. Thay thế chuỗi con trong chuỗi', N'A. Nối các phần tử của iterable thành một chuỗi')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (97, 5, N'Kết quả của ''-''.join([''a'', ''b'', ''c'']) là gì?
A. ''a-b-c''
B. ''abc''
C. ''a b c''
D. ''a,b,c''', N'A. ''a-b-c''')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (98, 6, N'Cách khai báo một List trong Python là gì?
A. list = []
B. list = ()
C. list = {}
D. list = <>', N'A. list = []')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (99, 6, N'List trong Python có thể chứa các loại dữ liệu nào?
A. Chỉ số nguyên
B. Chỉ chuỗi
C. Chỉ số thực
D. Bất kỳ loại dữ liệu nào', N'D. Bất kỳ loại dữ liệu nào')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (100, 6, N'Cách duyệt qua các phần tử của một List trong Python là gì?
A. for item in list:
B. for (item in list):
C. for item: in list
D. for (item): in list', N'A. for item in list:')
GO
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (101, 6, N'Hàm nào sau đây có thể được sử dụng để duyệt qua các phần tử của một List với chỉ số?
A. enumerate()
B. range()
C. len()
D. zip()', N'A. enumerate()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (102, 6, N'Cách gán giá trị cho một phần tử trong List là gì?
A. list[index] = value
B. list(index) = value
C. list[index] == value
D. list(index) == value', N'A. list[index] = value')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (103, 6, N'Điều gì xảy ra nếu bạn gán giá trị cho một chỉ số không tồn tại trong List?
A. Lỗi IndexError
B. Lỗi ValueError
C. Lỗi TypeError
D. Không có lỗi nào', N'A. Lỗi IndexError')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (104, 6, N'Phương thức insert(index, value) trong Python được sử dụng để làm gì?
A. Chèn một phần tử vào vị trí chỉ định trong List
B. Xóa một phần tử khỏi List
C. Thay thế một phần tử trong List
D. Sắp xếp các phần tử trong List', N'A. Chèn một phần tử vào vị trí chỉ định trong List')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (105, 6, N'Kết quả của list.insert(1, ''a'') khi list = [1, 2, 3] là gì?
A. [1, ''a'', 2, 3]
B. [''a'', 1, 2, 3]
C. [1, 2, ''a'', 3]
D. [1, 2, 3, ''a'']', N'A. [1, ''a'', 2, 3]')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (106, 6, N'Phương thức append(value) trong Python được sử dụng để làm gì?
A. Thêm một phần tử vào cuối List
B. Thêm một phần tử vào đầu List
C. Thêm một phần tử vào vị trí chỉ định trong List
D. Xóa một phần tử khỏi List', N'A. Thêm một phần tử vào cuối List')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (107, 6, N'Kết quả của list.append(''a'') khi list = [1, 2, 3] là gì?
A. [1, 2, 3, ''a'']
B. [''a'', 1, 2, 3]
C. [1, ''a'', 2, 3]
D. [1, 2, ''a'', 3]', N'A. [1, 2, 3, ''a'']')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (108, 6, N'Phương thức remove(value) trong Python được sử dụng để làm gì?
A. Xóa phần tử đầu tiên có giá trị chỉ định khỏi List
B. Xóa tất cả các phần tử có giá trị chỉ định khỏi List
C. Xóa phần tử tại vị trí chỉ định khỏi List
D. Xóa phần tử cuối cùng khỏi List', N'A. Xóa phần tử đầu tiên có giá trị chỉ định khỏi List')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (109, 6, N'Điều gì xảy ra nếu giá trị cần xóa không tồn tại trong List?
A. Lỗi ValueError
B. Lỗi IndexError
C. Lỗi TypeError
D. Không có lỗi nào', N'A. Lỗi ValueError')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (110, 6, N'Phương thức reverse() trong Python được sử dụng để làm gì?
A. Đảo ngược thứ tự các phần tử trong List
B. Sắp xếp các phần tử trong List theo thứ tự tăng dần
C. Sắp xếp các phần tử trong List theo thứ tự giảm dần
D. Xóa tất cả các phần tử trong List', N'A. Đảo ngược thứ tự các phần tử trong List')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (111, 6, N'Kết quả của list.reverse() khi list = [1, 2, 3] là gì?
A. [3, 2, 1]
B. [1, 2, 3]
C. [2, 1, 3]
D. [3, 1, 2]', N'A. [3, 2, 1]')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (112, 6, N'Phương thức sort() trong Python được sử dụng để làm gì?
A. Sắp xếp các phần tử trong List theo thứ tự tăng dần
B. Sắp xếp các phần tử trong List theo thứ tự giảm dần
C. Đảo ngược thứ tự các phần tử trong List
D. Xóa tất cả các phần tử trong List', N'A. Sắp xếp các phần tử trong List theo thứ tự tăng dần')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (113, 6, N'Để sắp xếp các phần tử trong List theo thứ tự giảm dần, bạn sử dụng cú pháp nào?
A. list.sort(reverse=True)
B. list.sort(reverse=False)
C. list.sort(descending=True)
D. list.sort(descending=False)', N'A. list.sort(reverse=True)')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (114, 6, N'Slicing trong Python là gì?
A. Lấy một phần của List
B. Thêm một phần tử vào List
C. Xóa một phần tử khỏi List
D. Đảo ngược thứ tự các phần tử trong List', N'A. Lấy một phần của List')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (115, 6, N'Cú pháp để lấy một phần của List từ chỉ số start đến chỉ số end là gì?
A. list[start:end]
B. list(start:end)
C. list[start to end]
D. list(start to end)', N'A. list[start:end]')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (116, 6, N'List đa chiều trong Python là gì?
A. List chứa các List khác
B. List chứa các số nguyên
C. List chứa các chuỗi
D. List chứa các số thực', N'A. List chứa các List khác')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (117, 6, N'Cách truy cập phần tử trong List đa chiều là gì?
A. list[i][j]
B. list(i)(j)
C. list[i, j]
D. list(i, j)', N'A. list[i][j]')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (118, 7, N'Vì sao chúng ta cần lưu trữ dữ liệu vào tập tin?
A. Để lưu trữ dữ liệu lâu dài
B. Để chia sẻ dữ liệu với người khác
C. Để xử lý dữ liệu lớn mà không thể lưu trữ trong bộ nhớ
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (119, 7, N'Lưu trữ dữ liệu vào tập tin giúp ích gì cho việc xử lý dữ liệu?
A. Giảm tải bộ nhớ
B. Dễ dàng quản lý và truy xuất dữ liệu
C. Bảo mật dữ liệu
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (120, 7, N'Loại tập tin nào sau đây là tập tin văn bản?
A. .txt
B. .xml
C. .json
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (121, 7, N'Loại tập tin nào sau đây thường được sử dụng để lưu trữ dữ liệu bảng tính?
A. .csv
B. .xlsx
C. .xls
D. Tất cả các đáp án trên', N'D. Tất cả các đáp án trên')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (122, 7, N'Cách mở một tập tin văn bản để đọc trong Python là gì?
A. open(''filename.txt'', ''r'')
B. open(''filename.txt'', ''w'')
C. open(''filename.txt'', ''a'')
D. open(''filename.txt'', ''x'')', N'A. open(''filename.txt'', ''r'')')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (123, 7, N'Phương thức nào được sử dụng để đọc toàn bộ nội dung của một tập tin văn bản trong Python?
A. read()
B. readline()
C. readlines()
D. write()', N'A. read()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (124, 7, N'Thư viện nào sau đây được sử dụng để xử lý tập tin XML trong Python?
A. xml.etree.ElementTree
B. json
C. csv
D. openpyxl', N'A. xml.etree.ElementTree')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (125, 7, N'Cách đọc một tập tin XML trong Python là gì?
A. tree = ElementTree.parse(''filename.xml'')
B. tree = json.load(''filename.xml'')
C. tree = csv.reader(''filename.xml'')
D. tree = openpyxl.load_workbook(''filename.xml'')', N'A. tree = ElementTree.parse(''filename.xml'')')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (126, 7, N'Thư viện nào sau đây được sử dụng để xử lý tập tin JSON trong Python?
A. json
B. xml.etree.ElementTree
C. csv
D. openpyxl', N'A. json')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (127, 7, N'Cách đọc một tập tin JSON trong Python là gì?
A. data = json.load(open(''filename.json''))
B. data = ElementTree.parse(''filename.json'')
C. data = csv.reader(''filename.json'')
D. data = openpyxl.load_workbook(''filename.json'')', N'A. data = json.load(open(''filename.json''))')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (128, 7, N'Thư viện nào sau đây được sử dụng để xử lý tập tin CSV trong Python?
A. csv
B. json
C. xml.etree.ElementTree
D. openpyxl', N'A. csv')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (129, 7, N'Cách đọc một tập tin CSV trong Python là gì?
A. reader = csv.reader(open(''filename.csv''))
B. reader = json.load(''filename.csv'')
C. reader = ElementTree.parse(''filename.csv'')
D. reader = openpyxl.load_workbook(''filename.csv'')', N'A. reader = csv.reader(open(''filename.csv''))')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (130, 7, N'Thư viện nào sau đây được sử dụng để xử lý tập tin Excel trong Python?
A. openpyxl
B. csv
C. json
D. xml.etree.ElementTree', N'A. openpyxl')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (131, 7, N'Cách đọc một tập tin Excel trong Python là gì?
A. workbook = openpyxl.load_workbook(''filename.xlsx'')
B. workbook = csv.reader(''filename.xlsx'')
C. workbook = json.load(''filename.xlsx'')
D. workbook = ElementTree.parse(''filename.xlsx'')', N'A. workbook = openpyxl.load_workbook(''filename.xlsx'')')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (132, 8, N'Tkinter là gì?
A. Thư viện GUI tiêu chuẩn của Python
B. Một ngôn ngữ lập trình
C. Một hệ điều hành
D. Một trình duyệt web', N'A. Thư viện GUI tiêu chuẩn của Python')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (133, 8, N'Tkinter được sử dụng để làm gì?
A. Tạo giao diện người dùng đồ họa (GUI)
B. Tạo các ứng dụng web
C. Tạo các ứng dụng di động
D. Tạo các ứng dụng dòng lệnh', N'A. Tạo giao diện người dùng đồ họa (GUI)')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (134, 8, N'Cách tạo một cửa sổ chính trong Tkinter là gì?
A. root = tk.Tk()
B. root = tk.Window()
C. root = tk.Frame()
D. root = tk.Panel()', N'A. root = tk.Tk()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (135, 8, N'Phương thức nào được sử dụng để chạy vòng lặp chính của ứng dụng Tkinter?
A. root.mainloop()
B. root.run()
C. root.start()
D. root.execute()', N'A. root.mainloop()')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (136, 8, N'Control nào sau đây được sử dụng để tạo một nút bấm trong Tkinter?
A. Button
B. Label
C. Entry
D. Text', N'A. Button')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (137, 8, N'Control nào sau đây được sử dụng để hiển thị văn bản trong Tkinter?
A. Label
B. Button
C. Entry
D. Text', N'A. Label')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (138, 8, N'Control nào sau đây được sử dụng để nhập văn bản trong Tkinter?
A. Entry
B. Button
C. Label
D. Frame', N'A. Entry')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (139, 8, N'Control nào sau đây được sử dụng để tạo một hộp văn bản nhiều dòng trong Tkinter?
A. Text
B. Entry
C. Label
D. Button', N'A. Text')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (140, 8, N'Cách thêm một nút bấm vào cửa sổ Tkinter là gì?
A. button = tk.Button(root, text="Click me")
B. button = tk.Label(root, text="Click me")
C. button = tk.Entry(root, text="Click me")
D. button = tk.Text(root, text="Click me")', N'A. button = tk.Button(root, text="Click me")')
INSERT [dbo].[Quizzes] ([quiz_id], [lesson_id], [question], [answer]) VALUES (141, 8, N'Phương thức nào được sử dụng để hiển thị một control trong cửa sổ Tkinter?
A. pack()
B. show()
C. display()
D. render()', N'A. pack()')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (1, N'user1', N'user1@example.com', N'qxeRThH6', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (2, N'user2', N'user2@example.com', N'iVE6Lp57', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (3, N'user3', N'user3@example.com', N'ESkyh5ug', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (4, N'user4', N'user4@example.com', N'qnnWM1Tk', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (5, N'user5', N'user5@example.com', N'BTKRsZHe', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (6, N'user6', N'user6@example.com', N'6XQWTGUv', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (7, N'user7', N'user7@example.com', N'3QTSEaAc', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (8, N'user8', N'user8@example.com', N'BkVNFoBa', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (9, N'user9', N'user9@example.com', N'qBHXlfJy', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (10, N'user10', N'user10@example.com', N'1icfzQnV', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (11, N'user11', N'user11@example.com', N'N6xvHIvD', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (12, N'user12', N'user12@example.com', N'Vcgns7bA', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (13, N'user13', N'user13@example.com', N'qzq5uZPj', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (14, N'user14', N'user14@example.com', N'SbcmwdoJ', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (15, N'user15', N'user15@example.com', N'szKjoj4J', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (16, N'user16', N'user16@example.com', N'RnARzeCb', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (17, N'user17', N'user17@example.com', N'90G9HUPm', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (18, N'user18', N'user18@example.com', N'hxaQuRmH', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (19, N'user19', N'user19@example.com', N'20OZ4153', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (20, N'user20', N'user20@example.com', N'3Ze2xqNu', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (21, N'user21', N'user21@example.com', N'tgwPkOdB', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (22, N'user22', N'user22@example.com', N'VEJThUL1', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (23, N'user23', N'user23@example.com', N'QekOFTjG', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (24, N'user24', N'user24@example.com', N'piuA15Ue', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (25, N'user25', N'user25@example.com', N'd0IgwouW', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (26, N'user26', N'user26@example.com', N'dJeXYYZD', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (27, N'user27', N'user27@example.com', N'JVMhiJQk', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (28, N'user28', N'user28@example.com', N'ZdCfFAFa', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (29, N'user29', N'user29@example.com', N'xiuYJMzW', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (30, N'user30', N'user30@example.com', N'rQ1U9HVn', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (31, N'user31', N'user31@example.com', N'DZzTfE0U', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (32, N'user32', N'user32@example.com', N'62lQcIso', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (33, N'user33', N'user33@example.com', N'HvH2dhCY', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (34, N'user34', N'user34@example.com', N'cIPMLCyI', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (35, N'user35', N'user35@example.com', N'9lRzArYX', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (36, N'user36', N'user36@example.com', N'93IxVWdZ', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (37, N'user37', N'user37@example.com', N'v0QLclrf', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (38, N'user38', N'user38@example.com', N'2WvJ4Stc', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (39, N'user39', N'user39@example.com', N'AeVXyP6w', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (40, N'user40', N'user40@example.com', N'WPSUs4Z3', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (41, N'user41', N'user41@example.com', N'7jFktiSS', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (42, N'user42', N'user42@example.com', N'BkVuXfWf', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (43, N'user43', N'user43@example.com', N'BTlaT21a', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (44, N'user44', N'user44@example.com', N'JuAKW927', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (45, N'user45', N'user45@example.com', N'gqdHPHed', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (46, N'user46', N'user46@example.com', N'VywOmSXQ', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (47, N'user47', N'user47@example.com', N'qoHW7SdO', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (48, N'user48', N'user48@example.com', N'Ixt5NJ1a', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (49, N'user49', N'user49@example.com', N'Juis420d', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (50, N'user50', N'user50@example.com', N'dQdWcllX', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (51, N'user51', N'user51@example.com', N'kZPfZ3gM', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (52, N'user52', N'user52@example.com', N'a2UCpv80', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (53, N'user53', N'user53@example.com', N'wTBddh5n', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (54, N'user54', N'user54@example.com', N'BKpKhRs8', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (55, N'user55', N'user55@example.com', N'5LD29e4A', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (56, N'user56', N'user56@example.com', N'P3WLpnWl', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (57, N'user57', N'user57@example.com', N'QwKjVsSJ', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (58, N'user58', N'user58@example.com', N'IcsGjcva', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (59, N'user59', N'user59@example.com', N'7sm6G6Gf', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (60, N'user60', N'user60@example.com', N'khGYRi2U', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (61, N'user61', N'user61@example.com', N'rNiZLUIb', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (62, N'user62', N'user62@example.com', N'0zrTlCKR', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (63, N'user63', N'user63@example.com', N'Ythb04Pr', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (64, N'user64', N'user64@example.com', N'lnfEZOCa', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (65, N'user65', N'user65@example.com', N'VdwrPuem', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (66, N'user66', N'user66@example.com', N'PanRs7Kx', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (67, N'user67', N'user67@example.com', N'iR9zYqUW', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (68, N'user68', N'user68@example.com', N'XzFSRI2r', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (69, N'user69', N'user69@example.com', N'fKOmn92H', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (70, N'user70', N'user70@example.com', N'uuvgecX1', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (71, N'user71', N'user71@example.com', N'9XfTSWzO', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (72, N'user72', N'user72@example.com', N'2qbUwBhC', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (73, N'user73', N'user73@example.com', N'lSppB1ee', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (74, N'user74', N'user74@example.com', N'90LRvvc8', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (75, N'user75', N'user75@example.com', N'jY6M6umo', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (76, N'user76', N'user76@example.com', N'MvRmpwdP', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (77, N'user77', N'user77@example.com', N'dX3tUBaD', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (78, N'user78', N'user78@example.com', N'Ghcfq9NX', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (79, N'user79', N'user79@example.com', N'1XKVpZtF', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (80, N'user80', N'user80@example.com', N'mAzUs3GS', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (81, N'user81', N'user81@example.com', N'AS5sSALf', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (82, N'user82', N'user82@example.com', N'ocF5qCA6', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (83, N'user83', N'user83@example.com', N'dSeZcFMT', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (84, N'user84', N'user84@example.com', N'UprUxwom', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (85, N'user85', N'user85@example.com', N'ehOVhJIU', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (86, N'user86', N'user86@example.com', N'a8L2Df8p', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (87, N'user87', N'user87@example.com', N'ALmhDVXM', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (88, N'user88', N'user88@example.com', N'nUfIMtvQ', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (89, N'user89', N'user89@example.com', N'hEwEjxhW', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (90, N'user90', N'user90@example.com', N'Fv9dRrLq', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (91, N'user91', N'user91@example.com', N'HZWgVMom', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (92, N'user92', N'user92@example.com', N'DrXp8yGF', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (93, N'user93', N'user93@example.com', N'H70nyGsd', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (94, N'user94', N'user94@example.com', N'WrVrAPzZ', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (95, N'user95', N'user95@example.com', N'oBIx0DjF', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (96, N'user96', N'user96@example.com', N'tFZukJD6', N'admin')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (97, N'user97', N'user97@example.com', N'nk8EEtpA', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (98, N'user98', N'user98@example.com', N'dMKSEuVr', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (99, N'user99', N'user99@example.com', N'BYSpbkP4', N'user')
GO
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (100, N'user100', N'user100@example.com', N'VSLCoABA', N'user')
INSERT [dbo].[Users] ([user_id], [username], [email], [password], [role]) VALUES (101, N'1', N'1', N'1', N'user')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (1, 1, N'https://youtu.be/c2sorFXCLU4?si=FAqWtxGdcoXRXxEW')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (2, 2, N'https://youtu.be/RDiL6VLud-Q?si=CRGwhDPhR1LSiKUH')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (3, 2, N'https://youtu.be/XeURcCz160o?si=dr9Jx-Wwm37JOIVO')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (4, 2, N'https://youtu.be/r9vECIW0Z3M?si=X9I79OrYJtmSN_Ga')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (5, 2, N'https://youtu.be/Ut6x6Jg5tA0?si=s1gwarjlZ4zd6NR2')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (6, 2, N'https://youtu.be/XMeYyJfbgpY?si=T_RJ_b7oHxA64NkS')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (7, 3, N'https://youtu.be/zWbdV8ukRg0?si=r8UOliDtqrTyXiHZ')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (8, 3, N'https://youtu.be/SeUdsjQ4G4Y?si=6t-btzpc5CzQMP00')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (9, 3, N'https://youtu.be/uERy6Qv2rWM?si=6uH8MjOrZx5PJrf1')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (10, 4, N'https://youtu.be/SxHbHDY7wLY?si=PzWILcF24h3NqCep')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (11, 4, N'https://youtu.be/qWaorZ1316A?si=P5ZvR6Vu7IAeEzsM')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (12, 4, N'https://youtu.be/6liSvjW-Iqo?si=cGkQjiZvCaOKoHxI')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (13, 5, N'https://youtu.be/Vb6XWSLPQfg?si=tUL3w9qHgnGPrOx8')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (14, 5, N'https://youtu.be/gzWriEOVjU0?si=biP_9--nf5sIgK3P')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (15, 5, N'https://youtu.be/LRUHnuHljPQ?si=4dK9ES1cSm0tpKZR')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (16, 5, N'https://youtu.be/q2TNJMBx6GE?si=3hJ1TIlQmsopEQm1')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (17, 5, N'https://youtu.be/u2Kd3weqPZE?si=vXqpDEpFxOfrW4lU')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (18, 6, N'https://youtu.be/rY5Oc4tS7F8?si=hAwimUfC9qBvjVcL')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (19, 6, N'https://youtu.be/zMML9jbEpmY?si=3zjQCjW96Bsn78w1')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (20, 7, N'https://youtu.be/6J8-jkoRBXw?si=5DXZwMiPp-lLLVA-')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (21, 8, N'https://youtu.be/h2npUBlguyA?si=prRGrpOIC_o-dAke')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (22, 8, N'https://youtu.be/C6-ju9jBrr8?si=O-d1MXx4Ftd9DQvw')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (23, 8, N'https://youtu.be/h_kdGCIc230?si=933NGbOlK8YM_PhR')
INSERT [dbo].[Video_Materials] ([video_id], [lesson_id], [video_link]) VALUES (24, 8, N'https://youtu.be/nS5YkZio_sk?si=fWMnzv2_vVMKUWpn')
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Lessons]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Users]
GO
ALTER TABLE [dbo].[PDF_Materials]  WITH CHECK ADD  CONSTRAINT [FK_PDF_Materials_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
GO
ALTER TABLE [dbo].[PDF_Materials] CHECK CONSTRAINT [FK_PDF_Materials_Lessons]
GO
ALTER TABLE [dbo].[PPTX_Materials]  WITH CHECK ADD  CONSTRAINT [FK_PPTX_Materials_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
GO
ALTER TABLE [dbo].[PPTX_Materials] CHECK CONSTRAINT [FK_PPTX_Materials_Lessons]
GO
ALTER TABLE [dbo].[Quizzes]  WITH CHECK ADD  CONSTRAINT [FK_Quizzes_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
GO
ALTER TABLE [dbo].[Quizzes] CHECK CONSTRAINT [FK_Quizzes_Lessons]
GO
ALTER TABLE [dbo].[Video_Materials]  WITH CHECK ADD  CONSTRAINT [FK_Video_Materials_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
GO
ALTER TABLE [dbo].[Video_Materials] CHECK CONSTRAINT [FK_Video_Materials_Lessons]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [CK__Users__role__37A5467C] CHECK  (([role]='user' OR [role]='admin'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [CK__Users__role__37A5467C]
GO
USE [master]
GO
ALTER DATABASE [LearningApp] SET  READ_WRITE 
GO
