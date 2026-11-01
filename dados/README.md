# Dados — Tech Challenge Fase 4

## 1. Descrição da Base

O projeto utiliza uma base de dados de produtos comercializados na Amazon, disponibilizada para análise no contexto do Tech Challenge da Pós-Tech em Data Analytics da FIAP.

A base contém informações sobre produtos, categorias, preços, descontos, avaliações e comentários de consumidores.

## 2. Estrutura dos Dados

Os principais campos utilizados foram:

| Campo                 | Descrição                               |
| --------------------- | --------------------------------------- |
| `product_id`          | Identificador do produto                |
| `product_name`        | Nome do produto                         |
| `category`            | Categoria do produto                    |
| `discounted_price`    | Preço com desconto                      |
| `actual_price`        | Preço original                          |
| `discount_percentage` | Percentual de desconto                  |
| `rating`              | Nota média do produto                   |
| `rating_count`        | Quantidade informada de avaliações      |
| `review_title`        | Títulos das avaliações dos consumidores |

## 3. Tratamento e Preparação

A base original contém **1.465 registros**.

Durante o tratamento dos dados, foram identificadas ocorrências repetidas de produtos. Para os indicadores de produtos, foi criada a tabela `Dim_Produtos`, contendo **1.351 produtos únicos**.

A consolidação considerou o identificador `product_id`, priorizando o registro com maior `rating_count`.

A tabela original foi preservada para análises de avaliações e comentários.

Também foram realizados tratamentos de tipos de dados, valores inválidos, categorias, preços e descontos.

## 4. Conversão Monetária

Os valores originalmente apresentados em rúpias indianas (INR) foram convertidos para reais (BRL), utilizando a taxa fixa indicativa:

**1 INR = R$ 0,06**

Essa taxa foi adotada como premissa de análise, não representando necessariamente a cotação histórica de mercado.

## 5. Reprodutibilidade

Os códigos de tratamento e transformação estão disponíveis na pasta `power_query/`.

As medidas utilizadas nos indicadores estão documentadas na pasta `dax/`.

O arquivo Power BI completo está disponível na pasta `dashboard/`.
