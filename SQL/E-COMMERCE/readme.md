# Diagrama de Banco de Dados - E-Commerce

Este diagrama representa o modelo de dados de um sistema de **E-Commerce**, incluindo as tabelas para clientes, produtos, vendedores, pedidos, pagamentos, entre outros. As tabelas são inter-relacionadas por **chaves estrangeiras** e **restrições de integridade** para garantir a consistência dos dados.

## Link para o Diagrama

O diagrama pode ser visualizado no **dbdiagram.io** através do seguinte link:

[https://dbdiagram.io/d/DIO-E-COMMERCE-67e6bc9c4f7afba1849779d1](https://dbdiagram.io/d/DIO-E-COMMERCE-67e6bc9c4f7afba1849779d1)

## Tabelas

### 1. **cliente**
Armazena as informações do cliente.
- `id`: Identificador único do cliente (chave primária).
- `nome`: Nome do cliente.
- `cpf`: CPF do cliente (único).
- `cnpj`: CNPJ do cliente (único).
- `endereco`: Endereço completo do cliente.
- `cep`: CEP do cliente.
- `nome_da_rua`: Nome da rua do endereço.
- `logradouro`: Logradouro do endereço.
- `bairro`: Bairro do endereço.

### 2. **produto**
Contém informações sobre os produtos à venda.
- `id`: Identificador único do produto (chave primária).
- `categoria`: Categoria do produto.
- `descricao`: Descrição do produto.
- `valor`: Valor do produto.
- `fornecedor_id`: Relacionamento com a tabela **fornecedor**.

### 3. **produto_vendedor**
Relaciona os produtos com os vendedores.
- `produto_id`: Chave estrangeira para a tabela **produto**.
- `vendedor_id`: Chave estrangeira para a tabela **vendedor**.
- `quantidade`: Quantidade do produto disponível com o vendedor.

### 4. **vendedor**
Armazena os dados dos vendedores.
- `id`: Identificador único do vendedor (chave primária).
- `nome`: Nome do vendedor.
- `razao_social`: Razão social do vendedor.
- `cnpj`: CNPJ do vendedor (único).
- `status`: Status do vendedor (ex: Ativo/Inativo).
- `email`: E-mail do vendedor.
- `endereco`: Endereço completo do vendedor.
- `cep`: CEP do vendedor.
- `nome_da_rua`: Nome da rua do endereço.
- `logradouro`: Logradouro do endereço.
- `bairro`: Bairro do endereço.

### 5. **produto_pedido**
Relaciona os produtos aos pedidos realizados.
- `produto_id`: Chave estrangeira para a tabela **produto**.
- `pedido_id`: Chave estrangeira para a tabela **pedido**.
- `quantidade`: Quantidade do produto no pedido.

### 6. **estoque**
Contém informações sobre os locais de estoque.
- `id`: Identificador único do estoque (chave primária).
- `local`: Local do estoque.

### 7. **produto_estoque**
Relaciona os produtos aos locais de estoque e a quantidade disponível.
- `produto_id`: Chave estrangeira para a tabela **produto**.
- `estoque_id`: Chave estrangeira para a tabela **estoque**.
- `quantidade`: Quantidade do produto disponível no estoque.

### 8. **pedido**
Contém os dados dos pedidos feitos pelos clientes.
- `id`: Identificador único do pedido (chave primária).
- `status`: Status do pedido.
- `descricao`: Descrição do pedido.
- `cliente_id`: Chave estrangeira para a tabela **cliente**.
- `frete`: Valor do frete.

### 9. **entrega**
Relaciona os pedidos às entregas e rastreamento.
- `id`: Identificador único da entrega (chave primária).
- `status`: Status da entrega.
- `pedido_id`: Chave estrangeira para a tabela **pedido**.
- `codigo_rastreio`: Código de rastreio único para a entrega.

### 10. **forma_pagamento**
Armazena as diferentes formas de pagamento disponíveis.
- `id`: Identificador único da forma de pagamento (chave primária).
- `descricao`: Descrição da forma de pagamento (ex: Cartão de Crédito, Boleto Bancário).

### 11. **pagamento**
Relaciona os pagamentos aos clientes e pedidos.
- `id`: Identificador único do pagamento (chave primária).
- `cliente_id`: Chave estrangeira para a tabela **cliente**.
- `data_pedido`: Data do pedido realizado.
- `valor_total`: Valor total do pagamento.
- `forma_pagamento_id`: Chave estrangeira para a tabela **forma_pagamento**.

### 12. **fornecedor**
Contém os dados dos fornecedores de produtos.
- `id`: Identificador único do fornecedor (chave primária).
- `razao_social`: Razão social do fornecedor (única).
- `cnpj`: CNPJ do fornecedor.
- `cpf`: CPF do fornecedor.

## Restrições e Integridade

- **UNIQUE**:
  - O **CPF** e **CNPJ** dos **clientes**, **fornecedores** e **vendedores** são únicos, garantindo que não haja duplicidade de documentos.

- **CHECK**:
  - A **restrição `CHECK`** foi comentada no modelo para garantir que um vendedor ou fornecedor tenha apenas **um CPF ou CNPJ**, mas não ambos.

- **Chaves estrangeiras**:
  - As tabelas estão interligadas por **chaves estrangeiras** para garantir a consistência das informações (por exemplo, a tabela **produto** tem uma chave estrangeira para a tabela **fornecedor**).

