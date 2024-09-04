ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
SELECT User FROM mysql.user;
-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS controladores_de_temperatura
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;
-- Criação da tabela local 
use controladores_de_temperatura;
create table Local_ (
	idLocal INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	nome varchar(255)
)DEFAULT CHARSET = utf8;
-- Inserção de locais
INSERT INTO Local_ (nome) VALUES ('sala a'), ('sala b'), ('sala c'), ('sala d'), ('sala e');
-- Criação da tabela modelo e marcas das maquinas
create table modelo (
	idModelo INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
	modelo_marca varchar(255) NOT NULL 
)DEFAULT CHARSET = utf8;
-- Inserção dos modelos e marcas
INSERT INTO modelo (modelo_marca) VALUES 
('modelo 01 e marca 01'), ('modelo 02 e marca 02'), ('modelo 03 e marca 03'), ('modelo 04 e marca 04'), ('modelo 05 e marca 05');
-- Criação da tabela manuntenções corretivas
CREATE TABLE corretiva (
    idCorretiva INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
    servico VARCHAR(255)
)  DEFAULT CHARSET=UTF8;
-- Inserção das manuntenções corretivas
INSERT INTO corretiva (servico) VALUES ('Limpeza dos filtros de ar'), ('Substituição dos filtros'), ('Limpeza de dreno');
-- Criação da tabela manuntenções preventivas
create table preventiva (
	idPreventiva INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
	servico varchar(100)
)DEFAULT CHARSET = utf8;
-- Inserção das manuntenções preventivas
INSERT INTO preventiva (servico) VALUES ('Medição de tensão elétrica'), ('Medição de temperatura do ar'), ('Verificação do estado dos filtros');
-- Criação da tabela inseriveis
create table inseriveis (
	id INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
	nome varchar(255) NOT NULL,
    data_manuntencao DATE NOT NULL,
    data_previsao DATE,
    custo decimal (6,2) ,
    detalhes varchar (255) NOT NULL,
    observacoes varchar(300),
    Local_ ENUM ('sala a', 'sala b', 'sala c', 'sala d', 'sala e') NOT NULL,
    modelo_marca ENUM ('modelo 01 e marca 01', 'modelo 02 e marca 02', 'modelo 03 e marca 03', 'modelo 04 e marca 04', 'modelo 05 e marca 05') NOT NULL,
    corretiva ENUM ('Limpeza dos filtros de ar', 'Substituição dos filtros', 'Limpeza de dreno') ,
    preventiva ENUM ('Medição de tensão elétrica', 'Medição de temperatura do ar', 'Verificação do estado dos filtros')  
)DEFAULT CHARSET = utf8;
-- Inserção de 13 manuntenções
INSERT INTO inseriveis (nome,data_manuntencao,data_previsao,custo,detalhes,observacoes,Local_,modelo_marca,corretiva,preventiva) 
VALUES ('matheus','2000-10-01',NULL,'200.50','troca de filtro',NULL,'sala e','modelo 03 e marca 03', 'Substituição dos filtros',NULL),
('PEDRO', '2001-07-15', NULL, '150.75', 'troca de FLUIDOS', NULL,'sala B','modelo 02 e marca 02',NULL,'Medição de temperatura do ar'), 
('MARCOS', '2022-03-22', NULL, '175.30', 'troca de CABOS', NULL,'sala A','modelo 01 e marca 01','Limpeza de dreno',NULL),
('FERNANDA', '2005-01-09', NULL, '99.03', 'reparo de circuito', NULL,'sala C','modelo 02 e marca 02','Limpeza de dreno',NULL),
('FERNANDA', '2019-05-09', NULL, '458.56', 'substituição de bateria', NULL,'sala A','modelo 02 e marca 02','Limpeza de dreno',NULL),
('DANIEL', '2003-02-07', NULL, NULL, 'troca de CABOS', NULL,'sala A','modelo 03 e marca 03','Limpeza de dreno',NULL),
('JULIANO', '2020-10-26', NULL, '259.90', 'substituição de bateria', NULL,'sala C','modelo 02 e marca 02','Limpeza de dreno',NULL),
('GUSTAVO', '2012-03-23', NULL, '218.59', 'substituição de bateria', NULL,'sala B','modelo 01 e marca 01','Limpeza de dreno',NULL),
('JULIANO', '2014-01-27', NULL, NULL, 'reparo de circuito', NULL,'sala C','modelo 02 e marca 02','Limpeza de dreno',NULL),
('HELENA', '2013-05-17', NULL, '434.29', 'troca de CABOS', NULL,'sala B','modelo 02 e marca 02','Limpeza dos filtros de ar',NULL),
('ISABEL', '2001-11-18', NULL, '179.55', 'substituição de bateria', NULL,'sala A','modelo 02 e marca 02','Limpeza dos filtros de ar',NULL),
('LARISSA', '2006-10-23', NULL, '366.43', 'substituição de bateria', NULL,'sala A','modelo 02 e marca 02','Limpeza de dreno',NULL),
('CARLA', '2023-01-01', NULL, '409.84', 'reparo de circuito', NULL,'sala B','modelo 02 e marca 02','Limpeza dos filtros de ar',NULL),
('WESLEY', '2002-03-22', NULL, '175.30', 'troca de CABOS', NULL,'sala A','modelo 01 e marca 01','Limpeza de dreno',NULL);
use controladores_de_temperatura;
SELECT * FROM inseriveis;
