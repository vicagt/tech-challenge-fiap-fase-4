let
    Fonte = Csv.Document(File.Contents("C:\Users\Viict\OneDrive\Tech Challenge - FIAP\FASE 4\amazon.csv"),[Delimiter=",", Columns=16, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(
    #"Cabeçalhos Promovidos",
    {
        {"product_id", type text},
        {"product_name", type text},
        {"category", type text},
        {"discounted_price", type text},
        {"actual_price", type text},
        {"discount_percentage", Percentage.Type},
        {"rating", type number},
        {"rating_count", type text},
        {"about_product", type text},
        {"user_id", type text},
        {"user_name", type text},
        {"review_id", type text},
        {"review_title", type text},
        {"review_content", type text},
        {"img_link", type text},
        {"product_link", type text}
    },
    "en-US"
),
    #"Erros Substituídos" = Table.ReplaceErrorValues(#"Tipo Alterado", {{"rating", null}}),
    #"Personalização Adicionada" = Table.AddColumn(#"Erros Substituídos", "Categoria_Principal", each Text.BeforeDelimiter([category], "|")),
    #"Valor Substituído" = Table.ReplaceValue(#"Personalização Adicionada","₹","",Replacer.ReplaceText,{"discounted_price"}),
    #"Valor Substituído1" = Table.ReplaceValue(#"Valor Substituído",",","",Replacer.ReplaceText,{"discounted_price"}),
    #"Tipo Alterado com Localidade" = Table.TransformColumnTypes(#"Valor Substituído1", {{"discounted_price", type number}}, "en-US"),
    #"Valor Substituído2" = Table.ReplaceValue(#"Tipo Alterado com Localidade","₹","",Replacer.ReplaceText,{"actual_price"}),
    #"Valor Substituído3" = Table.ReplaceValue(#"Valor Substituído2",",","",Replacer.ReplaceText,{"actual_price"}),
    #"Tipo Alterado com Localidade1" = Table.TransformColumnTypes(#"Valor Substituído3", {{"actual_price", type number}}, "en-US"),
    #"Valor Substituído4" = Table.ReplaceValue(#"Tipo Alterado com Localidade1",",","",Replacer.ReplaceText,{"rating_count"}),
    #"Tipo Alterado1" = Table.TransformColumnTypes(#"Valor Substituído4",{{"rating_count", Int64.Type}}),
    #"Personalização Adicionada1" = Table.AddColumn(#"Tipo Alterado1", "Preco_Original_BRL", each [actual_price] * Taxa_INR_BRL),
    #"Personalização Adicionada2" = Table.AddColumn(#"Personalização Adicionada1", "Preco_Desconto_BRL", each [discounted_price] * Taxa_INR_BRL),
    #"Tipo Alterado2" = Table.TransformColumnTypes(#"Personalização Adicionada2",{{"Preco_Original_BRL", Currency.Type}, {"Preco_Desconto_BRL", Currency.Type}})
in
    #"Tipo Alterado2"
