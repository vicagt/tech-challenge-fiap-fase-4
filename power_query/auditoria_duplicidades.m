let
    Fonte = Amazon,
    #"Linhas Agrupadas" = Table.Group(Fonte, {"product_id"}, {{"Qtd_Registros", each Table.RowCount(_), Int64.Type}}),
    #"Linhas Filtradas" = Table.SelectRows(#"Linhas Agrupadas", each [Qtd_Registros] > 1)
in
    #"Linhas Filtradas"
