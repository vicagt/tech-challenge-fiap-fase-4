let
    Fonte = Amazon,
    #"Outras Colunas Removidas" = Table.SelectColumns(Fonte,{"review_title"}),
    #"Dividir Coluna por Delimitador" = Table.ExpandListColumn(Table.TransformColumns(#"Outras Colunas Removidas", {{"review_title", Splitter.SplitTextByDelimiter(",", QuoteStyle.Csv), let itemType = (type nullable text) meta [Serialized.Text = true] in type {itemType}}}), "review_title"),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Dividir Coluna por Delimitador",{{"review_title", type text}}),
    #"Texto em Minúscula" = Table.TransformColumns(#"Tipo Alterado",{{"review_title", Text.Lower, type text}}),
    #"Texto Aparado" = Table.TransformColumns(#"Texto em Minúscula",{{"review_title", Text.Trim, type text}}),
    #"Texto Limpo" = Table.TransformColumns(#"Texto Aparado",{{"review_title", Text.Clean, type text}}),
    #"Dividir Coluna por Delimitador1" = Table.ExpandListColumn(Table.TransformColumns(#"Texto Limpo", {{"review_title", Splitter.SplitTextByDelimiter(" ", QuoteStyle.Csv), let itemType = (type nullable text) meta [Serialized.Text = true] in type {itemType}}}), "review_title"),
    #"Tipo Alterado1" = Table.TransformColumnTypes(#"Dividir Coluna por Delimitador1",{{"review_title", type text}}),
    #"Personalização Adicionada" = Table.AddColumn(#"Tipo Alterado1", "Palavra", each if [review_title] = null then null
else Text.Trim(
    Text.Remove(
        [review_title],
        {".", ",", "!", "?", ":", ";", "(", ")", "[", "]", """", "'", "/", "\", "-", "_", "*", "#", "@", "&"}
    )
)),
    #"Personalização Adicionada1" = Table.AddColumn(#"Personalização Adicionada", "Palavra_Valida", each let
    palavra = [Palavra],
    stopwords = {
        "the", "and", "for", "is", "a", "an", "to", "of",
        "in", "on", "at", "it", "its", "this", "that",
        "with", "as", "by", "be", "was", "were", "are",
        "i", "you", "your", "my", "me", "we", "they",
        "he", "she", "them", "from", "or", "but",
        "not", "so", "if", "do", "does", "did",
        "have", "has", "had", "can", "could",
        "would", "should", "will", "just", "very",
        "one", "all", "some", "more", "than", "then"
    }
in
    if palavra = null then null
    else if Text.Length(palavra) < 3 then null
    else if List.Contains(stopwords, palavra) then null
    else palavra),
    #"Linhas Filtradas" = Table.SelectRows(#"Personalização Adicionada1", each ([Palavra_Valida] <> null)),
    #"Outras Colunas Removidas1" = Table.SelectColumns(#"Linhas Filtradas",{"Palavra_Valida"}),
    #"Linhas Agrupadas" = Table.Group(#"Outras Colunas Removidas1", {"Palavra_Valida"}, {{"Frequencia", each Table.RowCount(_), Int64.Type}}),
    #"Linhas Classificadas" = Table.Sort(#"Linhas Agrupadas",{{"Frequencia", Order.Descending}})
in
    #"Linhas Classificadas"
