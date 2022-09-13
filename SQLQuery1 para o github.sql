create table tbl_autor (
id_autor smallint primary key identity(1, 1),
nome_autor varchar(30) not null unique,
autor_vivo char(3)
)

create table tbl_livros (
id_livro smallint primary key identity(1, 1),
nome_livro varchar(35) not null,
saga_livro varchar(15),
id_autor smallint,
editora_livro varchar(15),
valor_livro money,
CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) REFERENCES tbl_autor(id_autor)
)

INSERT INTO tbl_autor (nome_autor)
VALUES ('Arthur Conan Doyle'), ('Agatha Mary Clarissa Christie'), ('Edgar Allan Poe')

INSERT INTO tbl_livros (nome_livro, saga_livro, id_autor, editora_livro, valor_livro)
VALUES ('Um estudo em vermelho', 'Sherlock Holmes', 1, 'ftd', 10.50),
('O signo dos quatro', 'Sherlock Holmes', 1, 'atica', 10.50),
('O cão dos Baskervilles', 'Sherlock Holmes', 1, 'ftd', 7.00),
('Assassinato no Expresso do Oriente', 'Agatha Christie', 2, 'HarperCollins', 29.86),
('Morte no Nilo', 'Agatha Christie', 2, 'HarperCollins', 26.86)
