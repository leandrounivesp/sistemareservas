

-- Criação da tabela de Usuários
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    Senha NVARCHAR(255) NOT NULL,
    Telefone NVARCHAR(20)
);

-- Criação da tabela de Serviços (Para salões) ou Mesas (Para restaurantes)
CREATE TABLE Servicos (
    ServicoID INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(255) NOT NULL,
    Descricao TEXT,
    Duracao INT -- Duração em minutos para serviços. Pode ser omitido para Mesas
);

-- Criação da tabela de Reservas
CREATE TABLE Reservas (
    ReservaID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT,
    ServicoID INT, -- Renomear para MesaID se for para restaurantes
    DataHora DATETIME NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Confirmada',
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (ServicoID) REFERENCES Servicos(ServicoID)
);

-- Criação de índices, se necessário, para melhor performance nas consultas
CREATE INDEX IDX_Reservas_DataHora ON Reservas(DataHora);
CREATE INDEX IDX_Reservas_UsuarioID ON Reservas(UsuarioID);
CREATE INDEX IDX_Reservas_ServicoID ON Reservas(ServicoID);

-- Exemplos de inserção de dados
-- Adicionando um usuário
INSERT INTO Usuarios (Nome, Email, Senha, Telefone) VALUES ('João Silva', 'joao.silva@email.com', 'senha123', '11999887766');

-- Adicionando um serviço (ou mesa)
INSERT INTO Servicos (Nome, Descricao, Duracao) VALUES ('Corte de Cabelo Feminino', 'Corte básico feminino com lavagem.', 60);

-- Fazendo uma reserva
INSERT INTO Reservas (UsuarioID, ServicoID, DataHora, Status) VALUES (1, 1, '2024-03-15 14:00:00', 'Confirmada');

-- Consulta para ver reservas de um dia específico
SELECT r.ReservaID, u.Nome, s.Nome AS Servico, r.DataHora, r.Status
FROM Reservas r
JOIN Usuarios u ON r.UsuarioID = u.UsuarioID
JOIN Servicos s ON r.ServicoID = s.ServicoID
WHERE CAST(r.DataHora AS DATE) = '2024-03-15';


