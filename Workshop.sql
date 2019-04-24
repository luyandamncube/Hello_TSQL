USE Blog

GO
CREATE TABLE Author
(
	--AuthorID INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(255) NOT NULL,
	Surname NVARCHAR(255) NOT NULL,
	Email VARCHAR(255),
	Website VARCHAR(1000),
)
GO 
CREATE TABLE Post
(
	--PostID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	AuthorID INT,
	--AuthorID INT references Author(AuthorID) NOT NULL,
	Title VARCHAR(1000) NOT NULL,
	Intro VARCHAR(MAX),
	Body VARCHAR(MAX),
	CreatedDate DATETIME NOT NULL,
	Published BIT NOT NULL,
)
--//////////////////////////////////////  DML  //////////////////////////////////////
GO
ALTER TABLE Author
ADD AuthorID INT PRIMARY KEY IDENTITY(1,1) NOT NULL
GO 
ALTER TABLE Post
ADD PostID INT PRIMARY KEY IDENTITY(1,1) NOT NULL
GO 
ALTER TABLE Post
ADD CONSTRAINT PostFK FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
ON DELETE CASCADE
ON UPDATE CASCADE
--Add three authors to table
GO
INSERT INTO Author(Name, Surname, Email, Website)
VALUES
	('JK', 'Rowling', 'JK@Potter.com', 'harrypotter.com'),
	('JR', 'Tolkien', 'JR@LOTR.com', 'lordoftherings.com'),
	('Phillip', 'Pullman', 'PP@knife.com', 'subtleknife.com'),
	('Dan', 'Brown', 'PP@Brown.com', 'danbrown.com')
GO
INSERT INTO Post(Title, Intro, Body, CreatedDate, Published, AuthorID)
VALUES
	('My post', 'What is this about?', 'This is the body', '2019-04-24', 1, 2),
	('My second post', 'What is not this about?', 'This is the body', '2019-04-24', 1, 3),
	('My third post', 'What could this be about?', 'This is the body', '2019-04-24', 1, 1),
	('My fourth post', 'What was this about?', 'This is the body', '2019-04-24', 1, 1),
	('My fifth post', 'What would this have been about?', 'This is the body', '2019-04-24', 1, 1),
	('My sixth post', 'What could this never be about?', 'This is the body', '2019-04-24', 1, 2),
	('My seventh post', 'What about me', 'This is the body', '2019-04-24', 1, 1),
	('My eighth post', 'What should I do', 'This is the body', '2019-04-24', 1, 3)
GO
INSERT INTO Post(Title, Intro, Body, CreatedDate, Published)
VALUES
('My ninth post', 'What shouldnt I do', 'This is the body', '2019-04-24',0)
GO
--//////////////////////////////////////  JOIN  //////////////////////////////////////
CREATE VIEW vw_AuthorPosts 
AS
SELECT 
	a.[Name],
	a.Surname, 
	a.Email,
	p.Title
FROM Author AS a
FULL JOIN Post AS p ON a.AuthorID = p.AuthorID
--///////////////////////////////////  AGREGATION  ////////////////////////////////////
GO
CREATE VIEW vw_AuthorPostCount
AS
SELECT Name, Surname, Email, (SELECT COUNT(*) FROM Post WHERE Author.AuthorID = Post.AuthorID) AS TotalPosts
FROM Author;
--////////////////////////////////  STORED PROCEDURES  ////////////////////////////////
GO
CREATE PROCEDURE dbo.usp_insert_author 
	@author_name VARCHAR(255), 
	@author_surname VARCHAR(255), 
	@author_email varchar(255),
	@author_website varchar(255)
AS    
INSERT INTO Author([Name],Surname, Email, Website)
VALUES (@author_name, @author_surname, @author_email, @author_website)  
GO
EXEC dbo.usp_insert_author 
	@author_name = 'Zack', 
	@author_surname = 'De Frietas', 
	@author_email = 'z.defrietas@gmail.com',
	@author_website = 'frietasbooks.com'
GO
SELECT * FROM Author
GO
CREATE PROCEDURE dbo.usp_getauthorposts 
	@AuthorID VARCHAR(255)
AS
SELECT 
	a.[Name],
	a.Surname, 
	a.Email,
	p.Title
FROM Author AS a WHERE a.AuthorID = @AuthorID
FULL JOIN Post AS p ON a.AuthorID = p.AuthorID