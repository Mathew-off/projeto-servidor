ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
SELECT User FROM mysql.user;
-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS controladores_de_temperatura
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;
-- Criação da tabela local 
use controladores_de_temperatura;
create table lugar (
	idLocal INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	nome varchar(255)
)DEFAULT CHARSET = utf8;
-- Inserção de locais
INSERT INTO lugar (nome) VALUES ('1° A'), ('1° B'), ('1° C'), ('2° A'), ('2° B'), ('2° C'),('3° A'), ('3° B'), ('3° C'),('Laboratorio de informática'),('Sala de estudos');
-- Criação da tabela modelo e marcas das maquinas
create table modelo (
	idModelo INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
	modelo_marca varchar(255) NOT NULL 
)DEFAULT CHARSET = utf8;
-- Inserção dos modelos e marcas
INSERT INTO modelo (modelo_marca) VALUES 
('Carrier Eco Saver Puron'), ('Daikin FTXS25J'), ('LG-Dual Inverter'), ('Inversor Fujitsu'), ('Midea Liva Wi-Fi') , ('Gree Eco Garden'),('Outros');
-- Criação da tabela manuntenções corretivas
create table tipo_manuntencao (
	idLocal INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	nome varchar(255)
)DEFAULT CHARSET = utf8;
-- Inserção de locais
INSERT INTO tipo_manuntencao (nome) VALUES ('Corretiva'), ('Preventiva');
-- Criação da tabela tipo de conserto
CREATE TABLE tipo_conserto (
    idCorretiva INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
    servico VARCHAR(255)
)  DEFAULT CHARSET=UTF8;
-- Inserção das manuntenções corretivas
INSERT INTO tipo_conserto (servico) VALUES ('Limpeza dos filtros de ar'), ('Substituição dos filtros'), ('Limpeza de dreno'),('Medição de tensão elétrica'), ('Medição de temperatura do ar'), ('Verificação do estado dos filtros'), ('Outros');

CREATE TABLE cadastro (
	id INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	nomeUser VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL 
) DEFAULT CHARSET=UTF8;

-- Criação da tabela manuntenção
CREATE TABLE manutencao (
    id INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    nome VARCHAR(255) NOT NULL,
    data_manutencao DATE NOT NULL,
    data_previsao DATE,
    custo DECIMAL(6,2),
    detalhes VARCHAR(255),
    observacoes VARCHAR(300),
    lugar ENUM('1° A', '1° B', '1° C', '2° A', '2° B', '2° C', '3° A', '3° B', '3° C', 'Laboratorio de informática', 'Sala de estudos') NOT NULL,
    tipo_manutencao ENUM('Corretiva', 'Preventiva') NOT NULL,
    modelo_marca ENUM('Carrier Eco Saver Puron', 'Daikin FTXS25J', 'LG-Dual Inverter', 'Inversor Fujitsu', 'Midea Liva Wi-Fi', 'Gree Eco Garden', 'Outros') NOT NULL,
    tipo_conserto ENUM('Limpeza dos filtros de ar', 'Substituição dos filtros', 'Limpeza de dreno', 'Medição de tensão elétrica', 'Medição de temperatura do ar', 'Verificação do estado dos filtros', 'Outros') NOT NULL
) DEFAULT CHARSET = utf8;

DELIMITER $$

CREATE TRIGGER formatar_user_antes_inserir
BEFORE INSERT ON cadastro
FOR EACH ROW
BEGIN
    SET NEW.nomeUser = CONCAT(UPPER(LEFT(NEW.nomeUser, 1)), LOWER(SUBSTRING(NEW.nomeUser, 2)));
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER formatar_nome_antes_inserir
BEFORE INSERT ON manutencao
FOR EACH ROW
BEGIN
    SET NEW.nome = CONCAT(UPPER(LEFT(NEW.nome, 1)), LOWER(SUBSTRING(NEW.nome, 2)));
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER formatar_nome_antes_atualizar
BEFORE UPDATE ON manutencao
FOR EACH ROW
BEGIN
    SET NEW.nome = CONCAT(UPPER(LEFT(NEW.nome, 1)), LOWER(SUBSTRING(NEW.nome, 2)));
END $$

DELIMITER ;


-- Inserção de 13 manuntenções
INSERT INTO manutencao (nome, data_manutencao, data_previsao, custo, detalhes, observacoes, lugar, tipo_manutencao, modelo_marca, tipo_conserto) 
VALUES 
    ('Matheus', '2024-09-01', NULL, '200.50', 'Limpeza dos filtros de ar', NULL, 'Sala de estudos', 'Corretiva', 'LG-Dual Inverter', 'Substituição dos filtros'),
    ('João', '2024-07-12', NULL, '150.75', 'Troca de óleo', NULL, '1° A', 'Preventiva', 'Daikin FTXS25J', 'Limpeza dos filtros de ar'),
    ('Gabriel', '2024-05-23', NULL, '320.00', 'Troca de correia', NULL, '1° B', 'Corretiva', 'LG-Dual Inverter', 'Limpeza de dreno'),
    ('Carlos', '2024-02-02', NULL, '100.25', 'Troca de filtro de ar', NULL, '2° C', 'Corretiva', 'Inversor Fujitsu', 'Medição de tensão elétrica'),
    ('Mariana', '2024-03-15', NULL, '450.90', 'Troca de pastilha de freio', NULL, '3° A', 'Preventiva', 'Midea Liva Wi-Fi', 'Medição de temperatura do ar'),
    ('Rafael', '2024-08-05', NULL, '220.30', 'Troca de vela', NULL, 'Laboratorio de informática', 'Corretiva', 'Carrier Eco Saver Puron', 'Verificação do estado dos filtros'),
    ('Juliana', '2024-01-25', NULL, '310.60', 'Troca de amortecedor', NULL, '2° A', 'Preventiva', 'Daikin FTXS25J', 'Substituição dos filtros'),
    ('Fernando', '2024-04-18', NULL, '180.45', 'Troca de pneu', NULL, '1° C', 'Corretiva', 'LG-Dual Inverter', 'Limpeza dos filtros de ar'),
    ('Beatriz', '2024-01-07', NULL, '270.20', 'Troca de bateria', NULL, '3° B', 'Preventiva', 'Inversor Fujitsu', 'Limpeza de dreno'),
    ('Lucas', '2024-07-14', NULL, '195.75', 'Troca de cabo', NULL, 'Sala de estudos', 'Corretiva', 'Midea Liva Wi-Fi', 'Medição de tensão elétrica');
use controladores_de_temperatura;
SELECT * FROM manutencao;
