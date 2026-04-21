CREATE TABLE tipo_fornecedor (
    id_tipo_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_tipo_fornecedor VARCHAR(100) NOT NULL
);

CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(150) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_tipo_fornecedor INT NOT NULL,
    id_endereco INT NOT NULL,
    nome_fornecedor VARCHAR(25) NOT NULL,
    FOREIGN KEY (id_tipo_fornecedor) REFERENCES tipo_fornecedor(id_tipo_fornecedor),
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE categoria_produto (
    id_categoria_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE unidade_de_medida (
    id_unidade_medida INT PRIMARY KEY AUTO_INCREMENT,
    tipo_medida VARCHAR(50) NOT NULL
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(150) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_categoria_produto INT NOT NULL,
    id_unidade_medida INT NOT NULL,
    FOREIGN KEY (id_categoria_produto) REFERENCES categoria_produto(id_categoria_produto),
    FOREIGN KEY (id_unidade_medida) REFERENCES unidade_de_medida(id_unidade_medida)
);

CREATE TABLE estoque (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT UNIQUE NOT NULL,
    quantidade_disponivel INT NOT NULL,
    data_ultima_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE empresa_cliente (
    id_empresa_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_endereco INT NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_do_pedido VARCHAR(50) NOT NULL,
    data_prevista_de_entrega DATETIME NOT NULL,
    id_fornecedor INT NOT NULL,
    id_empresa_cliente INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
    FOREIGN KEY (id_empresa_cliente) REFERENCES empresa_cliente(id_empresa_cliente)
);

CREATE TABLE item (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    qtd_produto INT NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE tipo_pagamento (
    id_tipo_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_tipo_pagamento VARCHAR(100) NOT NULL
);

CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_forma_pagamento VARCHAR(100) NOT NULL
);

CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_forma_pagamento INT NOT NULL,
    id_tipo_pagamento INT NOT NULL,
    id_pedido INT NOT NULL,
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento),
    FOREIGN KEY (id_tipo_pagamento) REFERENCES tipo_pagamento(id_tipo_pagamento),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- SELECT
SELECT * FROM tipo_fornecedor;
SELECT * FROM endereco;
SELECT * FROM fornecedor;
SELECT * FROM categoria_produto;
SELECT * FROM unidade_de_medida;
SELECT * FROM produto;
SELECT * FROM estoque;
SELECT * FROM pedidos;
SELECT * FROM item;
SELECT * FROM tipo_pagamento;
SELECT * FROM forma_pagamento;
SELECT * FROM pagamentos;
SELECT * FROM empresa_cliente;

-- INSERT
INSERT INTO tipo_fornecedor (nome_tipo_fornecedor) VALUES
('Produtor de Leite'),
('Produtor de Suínos'),
('Ração Animal'),
('Embalagens'),
('Transporte Logístico');

INSERT INTO endereco (rua, bairro, cidade, estado, numero) VALUES
('Linha Industrial', 'Zona Rural', 'Medianeira', 'PR', 411),
('Rodovia BR-277', 'Interior', 'Cascavel', 'PR', 45),
('Estrada Rural KM 10', 'Interior', 'Toledo', 'PR', 566),
('Av. Logística', 'Distrito Industrial', 'Chapecó', 'SC', 789),
('Rua das Cooperativas', 'Centro', 'Palotina', 'PR', 543);

INSERT INTO fornecedor (cnpj, id_tipo_fornecedor, id_endereco, nome_fornecedor) VALUES
('10000000000001', 1, 1, 'BRF'),
('20000000000002', 2, 2, 'Videplast'),
('30000000000003', 3, 3, 'Alibem'),
('40000000000004', 4, 4, 'MBRF'),
('50000000000005', 5, 5, 'Master');

INSERT INTO categoria_produto (nome_categoria) VALUES
('Carnes Suínas'),
('Laticínios'),
('Embutidos'),
('Derivados de Leite'),
('Industrializados');

INSERT INTO unidade_de_medida (tipo_medida) VALUES
('Kg'),
('Litro'),
('Unidade'),
('Caixa'),
('Tonelada');

INSERT INTO produto (nome_produto, id_categoria_produto, id_unidade_medida) VALUES
('Carne Suína Resfriada', 1, 1),
('Leite Integral', 2, 2),
('Linguiça Toscana', 3, 1),
('Queijo Mussarela', 4, 1),
('Presunto Cozido', 5, 1);

INSERT INTO estoque (id_produto, quantidade_disponivel) VALUES
(1, 500),
(2, 1000),
(3, 300),
(4, 400),
(5, 350);

INSERT INTO empresa_cliente (nome_empresa, cnpj, id_endereco) VALUES
('Supermercado Paraná', '11111111000101', 1),
('Atacadão Sul', '22222222000102', 2),
('Distribuidora Oeste', '33333333000103', 3),
('Rede Mercados Brasil', '44444444000104', 4),
('Comercial Alimentos LTDA', '55555555000105', 5);

INSERT INTO pedidos (status_do_pedido, data_prevista_de_entrega, id_fornecedor, id_empresa_cliente) VALUES
('Processando', NOW() + INTERVAL 2 DAY, 1, 1),
('Enviado', NOW() + INTERVAL 3 DAY, 2, 2),
('Entregue', NOW() + INTERVAL 1 DAY, 3, 3),
('Pendente', NOW() + INTERVAL 5 DAY, 4, 4),
('Cancelado', NOW() + INTERVAL 4 DAY, 5, 5);

INSERT INTO item (qtd_produto, id_pedido, id_produto, preco_unitario) VALUES
(50, 1, 1, 15.00),
(200, 2, 2, 4.00),
(100, 3, 3, 12.00),
(80, 4, 4, 20.00),
(60, 5, 5, 18.00);

INSERT INTO tipo_pagamento (nome_tipo_pagamento) VALUES
('À vista'),
('Prazo 30 dias'),
('Prazo 60 dias'),
('Boleto'),
('Transferência');

INSERT INTO forma_pagamento (nome_forma_pagamento) VALUES
('Pix'),
('Boleto Bancário'),
('Transferência Bancária'),
('Cartão Empresarial'),
('TED');

INSERT INTO pagamentos (valor, id_forma_pagamento, id_tipo_pagamento, id_pedido) VALUES
(750.00, 1, 1, 1),
(800.00, 2, 2, 2),
(1200.00, 3, 3, 3),
(1600.00, 4, 4, 4),
(1080.00, 5, 5, 5);

-- UPDATE E DELETE
UPDATE tipo_fornecedor SET nome_tipo_fornecedor = 'Produtor Atualizado' WHERE id_tipo_fornecedor = 1;
DELETE FROM tipo_fornecedor WHERE id_tipo_fornecedor = 5;

UPDATE endereco SET cidade = 'Curitiba Atualizado' WHERE id_endereco = 1;
DELETE FROM endereco WHERE id_endereco = 5;

UPDATE fornecedor SET cnpj = '99999999999999' WHERE id_fornecedor = 1;
DELETE FROM fornecedor WHERE id_fornecedor = 5;

UPDATE categoria_produto SET nome_categoria = 'Carnes Premium' WHERE id_categoria_produto = 1;
DELETE FROM categoria_produto WHERE id_categoria_produto = 5;

UPDATE unidade_de_medida SET tipo_medida = 'Quilograma' WHERE id_unidade_medida = 1;
DELETE FROM unidade_de_medida WHERE id_unidade_medida = 5;

UPDATE produto SET nome_produto = 'Carne Suína Premium' WHERE id_produto = 1;
DELETE FROM produto WHERE id_produto = 5;

UPDATE estoque SET quantidade_disponivel = 999 WHERE id_estoque = 1;
DELETE FROM estoque WHERE id_estoque = 5;

UPDATE pedidos SET status_do_pedido = 'Finalizado' WHERE id_pedido = 1;
DELETE FROM pedidos WHERE id_pedido = 5;

UPDATE item SET qtd_produto = 999 WHERE id_item = 1;
DELETE FROM item WHERE id_item = 5;

UPDATE tipo_pagamento SET nome_tipo_pagamento = 'Pagamento Atualizado' WHERE id_tipo_pagamento = 1;
DELETE FROM tipo_pagamento WHERE id_tipo_pagamento = 5;

UPDATE forma_pagamento SET nome_forma_pagamento = 'Forma Atualizada' WHERE id_forma_pagamento = 1;
DELETE FROM forma_pagamento WHERE id_forma_pagamento = 5;

UPDATE pagamentos SET valor = 9999.99 WHERE id_pagamento = 1;
DELETE FROM pagamentos WHERE id_pagamento = 5;

UPDATE empresa_cliente SET nome_empresa = 'Cliente Atualizado' WHERE id_empresa_cliente = 1;
DELETE FROM empresa_cliente WHERE id_empresa_cliente = 5;