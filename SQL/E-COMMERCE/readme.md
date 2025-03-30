# Diagrama de Banco de Dados - E-Commerce

Este diagrama representa o modelo de dados de um sistema de **E-Commerce**, incluindo as tabelas para clientes, produtos, vendedores, pedidos, pagamentos, entre outros. As tabelas são inter-relacionadas por **chaves estrangeiras** e **restrições de integridade** para garantir a consistência dos dados.

## Link para o Diagrama

O diagrama pode ser visualizado no **dbdiagram.io** através do seguinte link:

[https://dbdiagram.io/d/DIO-E-COMMERCE-67e6bc9c4f7afba1849779d1](https://dbdiagram.io/d/DIO-E-COMMERCE-67e6bc9c4f7afba1849779d1)

## Restrições e Integridade

- **UNIQUE**:
  - O **CPF** e **CNPJ** dos **clientes**, **fornecedores** e **vendedores** são únicos, garantindo que não haja duplicidade de documentos.

- **CHECK**:
  - A **restrição `CHECK`** foi comentada no modelo para garantir que um vendedor ou fornecedor tenha apenas **um CPF ou CNPJ**, mas não ambos.

- **Chaves estrangeiras**:
  - As tabelas estão interligadas por **chaves estrangeiras** para garantir a consistência das informações (por exemplo, a tabela **produto** tem uma chave estrangeira para a tabela **fornecedor**).

