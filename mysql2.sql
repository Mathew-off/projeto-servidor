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
INSERT INTO lugar (nome) VALUES ('sala a'), ('sala b'), ('sala c'), ('sala d'), ('sala e');
-- Criação da tabela modelo e marcas das maquinas
create table modelo (
	idModelo INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
	modelo_marca varchar(255) NOT NULL 
)DEFAULT CHARSET = utf8;
-- Inserção dos modelos e marcas
INSERT INTO modelo (modelo_marca) VALUES 
('modelo 01 e marca 01'), ('modelo 02 e marca 02'), ('modelo 03 e marca 03'), ('modelo 04 e marca 04'), ('modelo 05 e marca 05'), ('Outros');
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
-- Criação da tabela manuntenção
create table manutencao (
	id INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
	nome varchar(255) NOT NULL,
    data_manutencao DATE NOT NULL,
    data_previsao DATE,
    custo decimal (6,2) ,
    detalhes varchar (255) ,
    observacoes varchar(300),
    lugar ENUM ('sala a', 'sala b', 'sala c', 'sala d', 'sala e') NOT NULL,
    tipo_manutencao ENUM ('Corretiva','Preventiva') NOT NULL,
    modelo_marca ENUM ('modelo 01 e marca 01', 'modelo 02 e marca 02', 'modelo 03 e marca 03', 'modelo 04 e marca 04', 'modelo 05 e marca 05', 'Outros') NOT NULL,
    tipo_conserto ENUM ('Limpeza dos filtros de ar', 'Substituição dos filtros', 'Limpeza de dreno','Medição de tensão elétrica', 'Medição de temperatura do ar', 'Verificação do estado dos filtros','Outros') NOT NULL
)DEFAULT CHARSET = utf8;

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
INSERT INTO manutencao (nome,data_manutencao,data_previsao,custo,detalhes,observacoes,lugar,tipo_manutencao,modelo_marca,tipo_conserto) 
VALUES ('matheus','2024-09-01',NULL,'200.50','Limpeza dos filtros de ar',NULL,'sala e','Corretiva','modelo 03 e marca 03', 'Substituição dos filtros'),
('joao','2024-07-12',NULL,'150.75','troca de óleo',NULL,'sala b','Preventiva','modelo 02 e marca 02', 'Limpeza dos filtros de ar'),
('gabriel','2024-05-23',NULL,'320.00','troca de correia',NULL,'sala c','Corretiva','modelo 03 e marca 03', 'Limpeza de dreno'),
('carlos','2024-02-02',NULL,'100.25','troca de filtro de ar',NULL,'sala d','Corretiva','modelo 04 e marca 04', 'Medição de tensão elétrica'),
('mariana','2024-03-15',NULL,'450.90','troca de pastilha de freio',NULL,'sala e','Preventiva','modelo 05 e marca 05', 'Medição de temperatura do ar'),
('rafael','2024-08-05',NULL,'220.30','troca de vela',NULL,'sala a','Corretiva','modelo 01 e marca 01', 'Verificação do estado dos filtros'),
('juliana','2024-01-25',NULL,'310.60','troca de amortecedor',NULL,'sala b','Preventiva','modelo 02 e marca 02', 'Substituição dos filtros'),
('fernando','2024-04-18',NULL,'180.45','troca de pneu',NULL,'sala c','Corretiva','modelo 03 e marca 03', 'Limpeza dos filtros de ar'),
('beatriz','2024-01-07',NULL,'270.20','troca de bateria',NULL,'sala d','Preventiva','modelo 04 e marca 04', 'Limpeza de dreno'),
('lucas','2024-07-14',NULL,'195.75','troca de cabo',NULL,'sala e','Corretiva','modelo 05 e marca 05', 'Medição de tensão elétrica');
use controladores_de_temperatura;
SELECT * FROM manutencao;
