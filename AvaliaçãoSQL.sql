#=================================================================================================================================
CREATE TABLE categorias_fornecedor (
    id_categoria_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    tipo_fornecedor VARCHAR(100) NOT NULL
);

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    cnpj_fornecedor VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_categoria_fornecedor INT NOT NULL,
    FOREIGN KEY (id_categoria_fornecedor) REFERENCES categorias_fornecedor(id_categoria_fornecedor)
);

CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(150) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
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

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_do_pedido VARCHAR(50) NOT NULL,
    data_prevista_de_entrega DATETIME NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE item (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    qtd_produto INT NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    preco_unitario NUMERIC(10,2) NOT NULL,
    subtotal NUMERIC(10,2),
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
    valor NUMERIC(10,2) NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_forma_pagamento INT NOT NULL,
    id_tipo_pagamento INT NOT NULL,
    id_pedido INT NOT NULL,
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento),
    FOREIGN KEY (id_tipo_pagamento) REFERENCES tipo_pagamento(id_tipo_pagamento),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
#=================================================================================================================================

#==================================================================================================================================
SELECT * FROM fornecedor;
SELECT * FROM endereco;
SELECT * FROM categorias_fornecedor;
SELECT * FROM produto;
SELECT * FROM categoria_produto;
SELECT * FROM unidade_de_medida;
SELECT * FROM pedidos;
SELECT * FROM item;
SELECT * FROM pagamentos;
SELECT * FROM tipo_pagamento;
SELECT * FROM forma_pagamento;
#======================================================================================================================================

#======================================================================================================================================
INSERT INTO categorias_fornecedor (tipo_fornecedor) VALUES ('Plásticos'), ('Eletrônicos'), ('Construção');

INSERT INTO fornecedor (cnpj_fornecedor, nome, id_categoria_fornecedor) VALUES 
('11111111111111', 'Fornecedor A', 1),
('22222222222222', 'Fornecedor B', 2),
('33333333333333', 'Fornecedor C', 3);

INSERT INTO endereco (rua, bairro, cidade, estado, id_fornecedor) VALUES
('Rua A', 'Centro', 'São Paulo', 'SP', 1),
('Rua B', 'Bairro B', 'Rio de Janeiro', 'RJ', 2),
('Rua C', 'Bairro C', 'Curitiba', 'PR', 3);

INSERT INTO categoria_produto (nome_categoria) VALUES ('Carne'), ('Informática'), ('Materiais');

INSERT INTO unidade_de_medida (tipo_medida) VALUES ('Litro'), ('Metro'), ('Quilo');

INSERT INTO produto (nome_produto, id_categoria_produto, id_unidade_medida) VALUES ('Coca-Cola', 1, 1), ('Notebook', 2, 2), ('Cimento', 3, 3);

INSERT INTO pedidos (data_pedido, status_do_pedido, data_prevista_de_entrega, id_fornecedor) VALUES
(NOW(), 'Pendente', DATE_ADD(NOW(), INTERVAL 5 DAY), 1),
(NOW(), 'Enviado', DATE_ADD(NOW(), INTERVAL 3 DAY), 2),
(NOW(), 'Entregue', DATE_ADD(NOW(), INTERVAL 1 DAY), 3);

INSERT INTO item (qtd_produto, id_pedido, id_produto, preco_unitario, subtotal) VALUES
(10, 1, 1, 5.00, 50.00),
(2, 2, 2, 2500.00, 5000.00),
(30, 3, 3, 30.00, 900.00);

INSERT INTO tipo_pagamento (nome_tipo_pagamento) VALUES ('À vista'), ('Parcelado'), ('Boleto');

INSERT INTO forma_pagamento (nome_forma_pagamento) VALUES ('Pix'), ('Cartão'), ('Dinheiro');

INSERT INTO pagamentos (valor, id_forma_pagamento, id_tipo_pagamento, id_pedido) VALUES (50.00, 1, 1, 1), (5000.00, 2, 2, 2), (900.00, 3, 3, 3);
#======================================================================================================================================

#======================================================================================================================================

UPDATE categorias_fornecedor SET tipo_fornecedor = 'Atualizado' WHERE id_categoria_fornecedor = 1;
DELETE FROM categorias_fornecedor WHERE id_categoria_fornecedor > 3;

UPDATE fornecedor SET nome = 'Fornecedor A Atualizado' WHERE id_fornecedor = 1;
DELETE FROM fornecedor WHERE id_fornecedor = 3;

UPDATE endereco SET cidade = 'Florianópolis' WHERE id_endereco = 1;
DELETE FROM endereco WHERE id_endereco = 3;

UPDATE categoria_produto SET nome_categoria = 'Bebidas Atualizado' WHERE id_categoria_produto = 1;
DELETE FROM categoria_produto WHERE id_categoria_produto = 3;

UPDATE unidade_de_medida SET tipo_medida = 'Litros' WHERE id_unidade_medida = 1;
DELETE FROM unidade_de_medida WHERE id_unidade_medida = 3;

UPDATE produto SET nome_produto = 'Coca-Cola Zero' WHERE id_produto = 1;
DELETE FROM produto WHERE id_produto = 3;

UPDATE pedidos SET status_do_pedido = 'Concluído' WHERE id_pedido = 1;
DELETE FROM pedidos WHERE id_pedido = 3;

UPDATE item SET qtd_produto = 20 WHERE id_item = 1;
DELETE FROM item WHERE id_item = 3;

UPDATE tipo_pagamento SET nome_tipo_pagamento = 'À vista Atualizado' WHERE id_tipo_pagamento = 1;
DELETE FROM tipo_pagamento WHERE id_tipo_pagamento = 3;

UPDATE forma_pagamento SET nome_forma_pagamento = 'Pix Atualizado' WHERE id_forma_pagamento = 1;
DELETE FROM forma_pagamento WHERE id_forma_pagamento = 3;

UPDATE pagamentos SET valor = 100.00 WHERE id_pagamento = 1;
DELETE FROM pagamentos WHERE id_pagamento = 3;
#======================================================================================================================================