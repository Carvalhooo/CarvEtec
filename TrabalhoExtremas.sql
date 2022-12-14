CREATE DATABASE TrabalhoExtremas; 

--PESQUISAR O CONCEITO DE VIEWS COM DEFINIÇÃO E EXEMPLOS.

--Em seguida, definir os comandos para o banco de dados.

--Dado um.banco de dados com as seguintes tabelas:

--MARCA = {CODMARCA, NOMEMARCA}++++++++

--TIPO = {CODTIPO, NOMETIPO}+++++++++

--PRODUTO = {CODPRODUTO, NOMEPRODUTO, QUANTIDADE, VALOR, CODMARCA_FK, CODTIPO_FK}++++++++

--VENDA = {CODVENDA, DATAVENDA}++++++++++

--ITENSVENDA = {CODVENDA_FK, CODPRODUTO_FK, QUANTIDADE, VALOR}++++++++


--Crie uma view que:

--Mostre os dados de um produto substituindo as chaves estrangeiras pelos valores correspondentes.

--Ex: CODPRODUTO, NOMEPRODUTO, QUANTIDADE, VALOR, MARCA  E TIPO.

CREATE TABLE MARCA(
	CODMARCA SERIAL PRIMARY KEY,
	NOMEMARCA VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE TIPO(
	CODTIPO SERIAL PRIMARY KEY,
	NOMETIPO VARCHAR(80) NOT NULL UNIQUE
);

-- CRIAR A TABELA PRODUTO
CREATE TABLE PRODUTO(
	CODPRODUTO SERIAL PRIMARY KEY,
	NOMEPRODUTO VARCHAR(80) NOT NULL UNIQUE,
	QUANTIDADE NUMERIC(10,2) NOT NULL,
	VALOR NUMERIC(10,2) NOT NULL,
	CODMARCA_FK INTEGER REFERENCES MARCA(CODMARCA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
	CODTIPO_FK INTEGER REFERENCES TIPO(CODTIPO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);

--CRIAR A TABELA VENDA
CREATE TABLE VENDA(
	CODVENDA SERIAL PRIMARY KEY,
	DATAVENDA DATE NOT NULL
);

--CRIAR A TABELA ITENSVENDA
CREATE TABLE ITENSVENDA(
	CODVENDA_FK INTEGER REFERENCES VENDA(CODVENDA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
	CODPRODUTO_FK INTEGER REFERENCES PRODUTO(CODPRODUTO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
	QUANTV NUMERIC(10,2) NOT NULL,
	VALORV NUMERIC(10,2) NOT NULL
);
ALTER TABLE ITENSVENDA ADD CONSTRAINT PK_COMPOSTA PRIMARY KEY(CODVENDA_FK, CODPRODUTO_FK);

INSERT INTO MARCA (NOMEMARCA) VALUES
('APPLE');

INSERT INTO MARCA (NOMEMARCA) VALUES
('SAMSUNG');

INSERT INTO PRODUTO (NOMEPRODUTO, QUANTIDADE, VALOR, CODMARCA_FK, CODTIPO_FK ) VALUES
('IPHONE 13',2, 6900 , 1, 1 );

INSERT INTO PRODUTO (NOMEPRODUTO, QUANTIDADE, VALOR, CODMARCA_FK, CODTIPO_FK ) VALUES
('S22 ULTRA',2, 5000 , 2 ,1);

INSERT INTO PRODUTO (NOMEPRODUTO, QUANTIDADE, VALOR,CODMARCA_FK, CODTIPO_FK ) VALUES
('MACKBOOK',1, 10000 , 1 , 2);

INSERT INTO TIPO (NOMETIPO) VALUES
('NOTEBOOK');

INSERT INTO TIPO (NOMETIPO) VALUES
('CELULAR');

CREATE VIEW DADOS_PRODUTO AS 
SELECT P.CODPRODUTO,P.NOMEPRODUTO,P.QUANTIDADE,P.VALOR,T.NOMETIPO,M.NOMEMARCA
FROM PRODUTO P, TIPO T, MARCA M
WHERE P.CODMARCA_FK=M.CODMARCA AND P.CODTIPO_FK=T.CODTIPO;

SELECT * FROM DADOS_PRODUTO;