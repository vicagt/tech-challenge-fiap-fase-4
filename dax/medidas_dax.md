# Medidas DAX — Tech Challenge Fase 4

## 1. Indicadores de Produtos Únicos

As medidas desta seção utilizam a tabela Dim_Produtos,
que contém um registro por produto.

### Total de Produtos

```dax
Total de Produtos =
COUNTROWS(Dim_Produtos)
```

### Avaliação Média

```dax
Avaliação Média =
AVERAGE(Dim_Produtos[rating])
```

### Desconto Médio

```dax
Desconto Médio =
AVERAGE(Dim_Produtos[discount_percentage])
```

### Soma das Avaliações Informadas

```dax
Soma das Avaliações Informadas =
SUM(Dim_Produtos[rating_count])
```

### Preço Médio (R$)

```dax
Preço Médio (R$) =
AVERAGE(Dim_Produtos[Preco_Desconto_BRL])
```

### Preço Original Médio (R$)

```dax
Preço Original Médio (R$) =
AVERAGE(Dim_Produtos[Preco_Original_BRL])
```

### Economia Média (R$)

```dax
Economia Média (R$) =
[Preço Original Médio (R$)] - [Preço Médio (R$)]
```

### Produtos com Avaliação Baixa

```dax
Produtos com Avaliação Baixa =
CALCULATE(
    COUNTROWS(Dim_Produtos),
    Dim_Produtos[rating] < 3.5,
    NOT ISBLANK(Dim_Produtos[rating])
)
```

### Produtos Bem Avaliados

```dax
Produtos Bem Avaliados =
CALCULATE(
    COUNTROWS(Dim_Produtos),
    Dim_Produtos[rating] >= 4.5
)
```

### % Produtos Bem Avaliados

```dax
% Produtos Bem Avaliados =
DIVIDE(
    [Produtos Bem Avaliados],
    [Total de Produtos],
    0
)
```

## 2. Indicadores da Base Original

As medidas desta seção utilizam os registros originais,
preservando as informações disponíveis para análise.

### Total de Registros Originais

```dax
Total de Registros Originais =
COUNTROWS(Amazon)
```

### Avaliação Média dos Registros

```dax
Avaliação Média dos Registros =
AVERAGE(Amazon[rating])
```

### Soma das Contagens Originais

```dax
Soma das Contagens Originais =
SUM(Amazon[rating_count])
```

## 3. Coluna Calculada

### Produto_Resumido

```dax
Produto_Resumido =
VAR Nome = Dim_Produtos[product_name]
RETURN
    IF(
        LEN(Nome) > 50,
        LEFT(Nome, 50) & "...",
        Nome
    )
```

## 4. Observações Metodológicas

- Dim_Produtos contém 1.351 produtos únicos.
- Amazon preserva os 1.465 registros originais.
- As medidas respeitam a granularidade de cada tabela.
- A soma de rating_count não representa necessariamente
  avaliações únicas, pois podem existir contagens sobrepostas.
- Os preços em reais utilizam uma taxa de conversão
  indicativa de INR 1 = BRL 0,06.
