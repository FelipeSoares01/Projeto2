CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('PJ', 'PF') NOT NULL,
    documento VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15)
);

CREATE TABLE Fornecedor (
    fornecedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('PJ', 'PF') NOT NULL,
    documento VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15)
);

CREATE TABLE Produto (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    fornecedor_id INT,
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

CREATE TABLE Forma_Pagamento (
    forma_pagamento_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    detalhes VARCHAR(255)
);

CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pendente', 'Concluído', 'Cancelado') NOT NULL,
    forma_pagamento_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (forma_pagamento_id) REFERENCES Forma_Pagamento(forma_pagamento_id)
);

CREATE TABLE Entrega (
    entrega_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    status ENUM('Em trânsito', 'Entregue', 'Devolvido') NOT NULL,
    codigo_rastreio VARCHAR(50),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

INSERT INTO Cliente (nome, tipo, documento, email, telefone) VALUES 
('Maria Silva', 'PF', '12345678901', 'maria@email.com', '123456789'),
('João Sousa', 'PJ', '12345678000195', 'joao@empresa.com', '987654321');

INSERT INTO Fornecedor (nome, tipo, documento, email, telefone) VALUES 
('Fornecedor A', 'PJ', '12345678000195', 'fornecedorA@email.com', '111222333'),
('Fornecedor B', 'PF', '98765432100', 'fornecedorB@email.com', '444555666');

INSERT INTO Produto (nome, descricao, preco, estoque, fornecedor_id) VALUES 
('Produto 1', 'Descrição do Produto 1', 29.90, 100, 1),
('Produto 2', 'Descrição do Produto 2', 19.90, 50, 2);

INSERT INTO Forma_Pagamento (tipo, detalhes) VALUES 
('Cartão de Crédito', 'Vencimento em 30 dias'),
('Boleto', 'Pagamento à vista');

INSERT INTO Pedido (cliente_id, data, status, forma_pagamento_id) VALUES 
(1, NOW(), 'Pendente', 1),
(2, NOW(), 'Concluído', 2);

INSERT INTO Entrega (pedido_id, status, codigo_rastreio) VALUES 
(1, 'Em trânsito', 'R123456789'),
(2, 'Entregue', 'R987654321');

SELECT c.nome, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id;


SELECT DISTINCT f.nome
FROM Fornecedor f
JOIN Cliente c ON f.documento = c.documento
WHERE f.tipo = 'PJ';

SELECT p.nome AS produto, f.nome AS fornecedor, p.estoque
FROM Produto p
JOIN Fornecedor f ON p.fornecedor_id = f.fornecedor_id;

SELECT f.nome AS fornecedor, p.nome AS produto
FROM Fornecedor f
JOIN Produto p ON f.fornecedor_id = p.fornecedor_id;





