let
    Fonte = Amazon,

    #"Linhas Classificadas" = Table.Sort(
        Fonte,
        {
            {"rating_count", Order.Descending},
            {"product_id", Order.Ascending}
        }
    ),

    #"Linhas Armazenadas" = Table.Buffer(#"Linhas Classificadas"),

    #"Produtos Unicos" = Table.Distinct(
        #"Linhas Armazenadas",
        {"product_id"}
    )
in
    #"Produtos Unicos"
