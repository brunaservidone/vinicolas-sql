CREATE SCHEMA IF NOT EXISTS mydb;
USE mydb;
CREATE TABLE IF NOT EXISTS Regiao (
    codRegiao BIGINT NOT NULL,
    nomeRegiao VARCHAR(100) NOT NULL,
    descricaoRegiao TEXT NOT NULL,
    PRIMARY KEY (codRegiao)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS Vinicola (
    codVinicola BIGINT NOT NULL,
    nomeVinicola VARCHAR(100) NOT NULL,
    descricaoVinicola TEXT NOT NULL,
    foneVinicola VARCHAR(15) NOT NULL,
    emailVinicola VARCHAR(100) NOT NULL,
    codRegiao BIGINT NOT NULL,
    PRIMARY KEY (codVinicola),
    INDEX fk_vinicola_regiao_idx (codRegiao),
    CONSTRAINT fk_vinicola_regiao
        FOREIGN KEY (codRegiao)
        REFERENCES Regiao (codRegiao)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS Vinho (
    codVinho BIGINT NOT NULL,
    nomeVinho VARCHAR(50) NOT NULL,
    tipoVinho VARCHAR(30) NOT NULL,
    anoVinho INT NOT NULL,
    descricaoVinho TEXT NOT NULL,
    codVinicola BIGINT NOT NULL,
    PRIMARY KEY (codVinho),
    INDEX fk_vinho_vinicola_idx (codVinicola),
    CONSTRAINT fk_vinho_vinicola
        FOREIGN KEY (codVinicola)
        REFERENCES Vinicola (codVinicola)
) ENGINE = InnoDB;
INSERT INTO Regiao
(codRegiao, nomeRegiao, descricaoRegiao)
VALUES
(1, 'Serra Gaucha', 'Regiao tradicional de producao de vinhos no Brasil.'),
(2, 'Vale dos Vinhedos', 'Regiao conhecida pela producao de vinhos de qualidade.'),
(3, 'Campanha Gaucha', 'Regiao de clima favoravel ao cultivo de uvas.'),
(4, 'Vale do Sao Francisco', 'Regiao brasileira com producao de uvas e vinhos.'),
(5, 'Serra Catarinense', 'Regiao de altitude com producao de vinhos finos.');
INSERT INTO Vinicola
(codVinicola, nomeVinicola, descricaoVinicola, foneVinicola, emailVinicola, codRegiao)
VALUES
(1, 'Vinicola Aurora', 'Vinicola tradicional especializada em vinhos brasileiros.', '5432112345', 'a@vinho.com', 1),
(2, 'Vinicola Miolo', 'Produtora de vinhos e espumantes de diferentes variedades.', '5432223456', 'b@vinho.com', 2),
(3, 'Vinicola Campestre', 'Vinicola dedicada a vinhos produzidos na Campanha Gaucha.', '5532334567', 'c@vinho.com', 3),
(4, 'Vinicola Sertao', 'Produtora de vinhos da regiao do Vale do Sao Francisco.', '8732445678', 'd@vinho.com', 4),
(5, 'Vinicola Altitude', 'Vinicola especializada em vinhos de altitude.', '4832556789', 'e@vinho.com', 5);
INSERT INTO Vinho
(codVinho, nomeVinho, tipoVinho, anoVinho, descricaoVinho, codVinicola)
VALUES
(1, 'Aurora Tinto', 'Tinto', 2022, 'Vinho tinto produzido com uvas selecionadas.', 1),
(2, 'Miolo Reserva', 'Tinto', 2021, 'Vinho de sabor equilibrado e aroma marcante.', 2),
(3, 'Campestre Rose', 'Rose', 2023, 'Vinho rose leve e refrescante.', 3),
(4, 'Sertao Branco', 'Branco', 2022, 'Vinho branco de aroma frutado.', 4),
(5, 'Altitude Tinto', 'Tinto', 2020, 'Vinho tinto produzido em regiao de altitude.', 5);
SELECT
    Vinho.nomeVinho,
    Vinho.anoVinho,
    Vinicola.nomeVinicola,
    Regiao.nomeRegiao
FROM Vinho
INNER JOIN Vinicola
    ON Vinho.codVinicola = Vinicola.codVinicola
INNER JOIN Regiao
    ON Vinicola.codRegiao = Regiao.codRegiao;
DROP USER IF EXISTS 'sommelier'@'localhost';
CREATE USER 'sommelier'@'localhost'
IDENTIFIED BY 'SUA_SENHA_AQUI';
GRANT SELECT
ON mydb.Vinho
TO 'sommelier'@'localhost';
GRANT SELECT (codVinicola, nomeVinicola)
ON mydb.Vinicola
TO 'sommelier'@'localhost';
ALTER USER 'sommelier'@'localhost'
WITH MAX_QUERIES_PER_HOUR 40;