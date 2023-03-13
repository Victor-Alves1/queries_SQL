USE [master];

CREATE DATABASE [Biblioteca];

USE [Biblioteca];

CREATE TABLE tbl_autor (
id_autor SMALLINT PRIMARY KEY IDENTITY(1, 1),
nome_autor VARCHAR(30) NOT NULL UNIQUE,
autor_vivo CHAR(3)
);

CREATE TABLE tbl_livros (
id_livro SMALLINT PRIMARY KEY IDENTITY(1, 1),
nome_livro VARCHAR(40) NOT NULL,
saga_livro VARCHAR(20),
id_autor SMALLINT,
editora_livro VARCHAR(20),
valor_livro MONEY,
CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) REFERENCES tbl_autor(id_autor)
);

INSERT INTO tbl_autor (nome_autor)
VALUES ('Arthur Conan Doyle'), ('Agatha Mary Clarissa Christie'), ('Edgar Allan Poe');

INSERT INTO tbl_livros (nome_livro, saga_livro, id_autor, editora_livro, valor_livro)
VALUES ('Um estudo em vermelho', 'Sherlock Holmes', 1, 'ftd', 10.50),
('O signo dos quatro', 'Sherlock Holmes', 1, 'atica', 10.50),
('O cão dos Baskervilles', 'Sherlock Holmes', 1, 'ftd', 7.00),
('Assassinato no Expresso do Oriente', 'Agatha Christie', 2, 'HarperCollins', 29.86),
('Morte no Nilo', 'Agatha Christie', 2, 'HarperCollins', 26.86);
