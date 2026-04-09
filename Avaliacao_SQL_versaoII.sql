-- =========================================
-- TIPO FORNECEDOR
-- =========================================
CREATE TABLE tipo_fornecedor (
    id_tipo_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_tipo_fornecedor VARCHAR(100) NOT NULL
);

-- =========================================
-- ENDEREÇO
-- =========================================
CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(150) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- FORNECEDOR
-- =========================================
CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    cnpj VARCHAR(18) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_tipo_fornecedor INT NOT NULL,
    id_endereco INT NOT NULL,
    FOREIGN KEY (id_tipo_fornecedor) REFERENCES tipo_fornecedor(id_tipo_fornecedor),
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

-- =========================================
-- FUNCIONÁRIOS
-- =========================================
CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome_funcionario VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    data_admissao DATE NOT NULL,
    id_endereco INT,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

-- =========================================
-- CATEGORIA PRODUTO
-- =========================================
CREATE TABLE categoria_produto (
    id_categoria_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(100) NOT NULL
);

-- =========================================
-- UNIDADE DE MEDIDA
-- =========================================
CREATE TABLE unidade_de_medida (
    id_unidade_medida INT PRIMARY KEY AUTO_INCREMENT,
    tipo_medida VARCHAR(50) NOT NULL
);

-- =========================================
-- PRODUTO
-- =========================================
CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(150) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_categoria_produto INT NOT NULL,
    id_unidade_medida INT NOT NULL,
    FOREIGN KEY (id_categoria_produto) REFERENCES categoria_produto(id_categoria_produto),
    FOREIGN KEY (id_unidade_medida) REFERENCES unidade_de_medida(id_unidade_medida)
);

-- =========================================
-- ESTOQUE
-- =========================================
CREATE TABLE estoque (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    quantidade_disponivel INT NOT NULL,
    data_ultima_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- =========================================
-- PEDIDOS
-- =========================================
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_do_pedido VARCHAR(50) NOT NULL,
    data_prevista_de_entrega DATETIME NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

-- =========================================
-- ITEM
-- =========================================
CREATE TABLE item (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    qtd_produto INT NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- =========================================
-- TIPO PAGAMENTO
-- =========================================
CREATE TABLE tipo_pagamento (
    id_tipo_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_tipo_pagamento VARCHAR(100) NOT NULL
);

-- =========================================
-- FORMA PAGAMENTO
-- =========================================
CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_forma_pagamento VARCHAR(100) NOT NULL
);

-- =========================================
-- PAGAMENTOS
-- =========================================
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

-- =========================================
-- EMPRESA CLIENTE
-- =========================================
CREATE TABLE empresa_cliente (
    id_empresa_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_endereco INT NOT NULL,
    id_pedido INT NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- =========================================
-- FRIMESA EMPRESA
-- =========================================
CREATE TABLE frimesa_empresa (
    id_frimesa INT PRIMARY KEY AUTO_INCREMENT,
    cnpj VARCHAR(18) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_categoria_fornecedor INT,
    id_endereco INT,
    id_funcionario INT,
    id_fornecedor INT,
    id_empresa_cliente INT,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
    FOREIGN KEY (id_empresa_cliente) REFERENCES empresa_cliente(id_empresa_cliente)
);



-- =========================================
-- SELECT
-- =========================================
SELECT * FROM tipo_fornecedor;
SELECT * FROM endereco;
SELECT * FROM fornecedor;
SELECT * FROM funcionarios;
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
SELECT * FROM frimesa_empresa;

-- =========================================
-- INSERT
-- =========================================
INSERT INTO tipo_fornecedor (nome_tipo_fornecedor) VALUES
('Produtor de Leite'),
('Produtor de Suínos'),
('Ração Animal'),
('Embalagens'),
('Transporte Logístico');

INSERT INTO endereco (rua, bairro, cidade, estado) VALUES
('Linha Industrial', 'Zona Rural', 'Medianeira', 'PR'),
('Rodovia BR-277', 'Interior', 'Cascavel', 'PR'),
('Estrada Rural KM 10', 'Interior', 'Toledo', 'PR'),
('Av. Logística', 'Distrito Industrial', 'Chapecó', 'SC'),
('Rua das Cooperativas', 'Centro', 'Palotina', 'PR');

INSERT INTO fornecedor (cnpj, id_tipo_fornecedor, id_endereco) VALUES
('10000000000001', 1, 1),
('20000000000002', 2, 2),
('30000000000003', 3, 3),
('40000000000004', 4, 4),
('50000000000005', 5, 5);

INSERT INTO funcionarios (nome_funcionario, cpf, cargo, data_admissao, id_endereco) VALUES
('Carlos Mendes', '11111111111', 'Gerente Industrial', '2018-02-10', 1),
('Fernanda Rocha', '22222222222', 'Engenheira de Alimentos', '2019-06-15', 2),
('Ricardo Souza', '33333333333', 'Supervisor de Produção', '2020-03-20', 3),
('Juliana Alves', '44444444444', 'Analista de Qualidade', '2021-08-01', 4),
('Marcos Pereira', '55555555555', 'Operador de Máquinas', '2022-11-11', 5);

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

INSERT INTO pedidos (status_do_pedido, data_prevista_de_entrega, id_fornecedor) VALUES
('Processando', NOW() + INTERVAL 2 DAY, 1),
('Enviado', NOW() + INTERVAL 3 DAY, 2),
('Entregue', NOW() + INTERVAL 1 DAY, 3),
('Pendente', NOW() + INTERVAL 5 DAY, 4),
('Cancelado', NOW() + INTERVAL 4 DAY, 5);

INSERT INTO item (qtd_produto, id_pedido, id_produto, preco_unitario, subtotal) VALUES
(50, 1, 1, 15.00, 750.00),
(200, 2, 2, 4.00, 800.00),
(100, 3, 3, 12.00, 1200.00),
(80, 4, 4, 20.00, 1600.00),
(60, 5, 5, 18.00, 1080.00);

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

INSERT INTO empresa_cliente (nome_empresa, cnpj, id_endereco, id_pedido) VALUES
('Supermercado Paraná', '11111111000101', 1, 1),
('Atacadão Sul', '22222222000102', 2, 2),
('Distribuidora Oeste', '33333333000103', 3, 3),
('Rede Mercados Brasil', '44444444000104', 4, 4),
('Comercial Alimentos LTDA', '55555555000105', 5, 5);

INSERT INTO frimesa_empresa (cnpj, nome, id_endereco, id_funcionario, id_fornecedor, id_empresa_cliente) VALUES
('99999999000101', 'Frimesa Matriz', 1, 1, 1, 1),
('99999999000102', 'Frimesa Unidade Cascavel', 2, 2, 2, 2),
('99999999000103', 'Frimesa Unidade Toledo', 3, 3, 3, 3),
('99999999000104', 'Frimesa Unidade SC', 4, 4, 4, 4),
('99999999000105', 'Frimesa Unidade Palotina', 5, 5, 5, 5);

-- =========================================
-- UPDATE E DELETE
-- =========================================
UPDATE tipo_fornecedor SET nome_tipo_fornecedor = 'Produtor Atualizado' WHERE id_tipo_fornecedor = 1;
DELETE FROM tipo_fornecedor WHERE id_tipo_fornecedor = 5;

UPDATE endereco SET cidade = 'Curitiba Atualizado' WHERE id_endereco = 1;
DELETE FROM endereco WHERE id_endereco = 5;

UPDATE fornecedor SET cnpj = '99999999999999' WHERE id_fornecedor = 1;
DELETE FROM fornecedor WHERE id_fornecedor = 5;

UPDATE funcionarios SET cargo = 'Gerente Geral' WHERE id_funcionario = 1;
DELETE FROM funcionarios WHERE id_funcionario = 5;

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

UPDATE frimesa_empresa SET nome = 'Frimesa Atualizada' WHERE id_frimesa = 1;
DELETE FROM frimesa_empresa WHERE id_frimesa = 5;