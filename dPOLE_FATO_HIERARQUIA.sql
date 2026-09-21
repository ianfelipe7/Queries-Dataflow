let
    Origem = Sql.Database(pServidor, pBanco),
    #"Navegação 1" = Origem{[Schema = "dbo", Item = "POLE_FATO_HIERARQUIA"]}[Data],
    #"Linhas filtradas" = Table.SelectRows(#"Navegação 1", each Text.StartsWith([HIERARQUIA], "0008") or Text.StartsWith([HIERARQUIA], "0012")),
    #"Linhas filtradas 1" = Table.SelectRows(#"Linhas filtradas", each not Text.Contains([HIERARQUIA_PRODUTOS], "Não") and not Text.Contains([HIERARQUIA_PRODUTOS], "Usar")),
    #"Primeiros caracteres inseridos" = Table.AddColumn(#"Linhas filtradas 1", "Primeiros caracteres", each Text.Start([HIERARQUIA], 8), type text),
    #"Colunas renomeadas" = Table.RenameColumns(#"Primeiros caracteres inseridos", {{"Primeiros caracteres", "N1"}}),
    #"Primeiros caracteres inseridos 1" = Table.AddColumn(#"Colunas renomeadas", "Primeiros caracteres", each Text.Start([HIERARQUIA], 12), type text),
    #"Colunas renomeadas 1" = Table.RenameColumns(#"Primeiros caracteres inseridos 1", {{"Primeiros caracteres", "N2"}}),
    #"Primeiros caracteres inseridos 2" = Table.AddColumn(#"Colunas renomeadas 1", "Primeiros caracteres", each Text.Start([HIERARQUIA], 18), type text),
    #"Colunas renomeadas 2" = Table.RenameColumns(#"Primeiros caracteres inseridos 2", {{"Primeiros caracteres", "N3"}}),
    #"Valor substituído" = Table.ReplaceValue(#"Colunas renomeadas 2", "000800060002000004", "000800060002000002", Replacer.ReplaceText, {"N3"}),
    #"Coluna condicional inserida" = Table.AddColumn(#"Valor substituído", "Personalizar", each if [N2] = "001200010001" then "'00080005" else [N1]),
    #"Tipo de coluna alterado" = Table.TransformColumnTypes(#"Coluna condicional inserida", {{"Personalizar", type text}}),
    #"Colunas renomeadas 4" = Table.RenameColumns(#"Tipo de coluna alterado", {{"Personalizar", "N1 Comercial"}}),
    #"Valor substituído 1" = Table.ReplaceValue(#"Colunas renomeadas 4", "Galeto Temperado Cong", "Galeto Temperado", Replacer.ReplaceText, {"HIERARQUIA_PRODUTOS"}),
    #"Coluna condicional inserida 1" = Table.AddColumn(#"Valor substituído 1", "N1 NewFEV24", each if [N3] = "001200010000000001" then "'00080002" else if [N3] = "001200010000000005" then "'00080002" else if [N3] = "001200010000000008" then "'00080005" else if [N3] = "001200010000000011" then "'00080002" else if [N3] = "001200010000000004" then "'00080002" else if [N3] = "001200010000000006" then "'00080002" else if [N3] = "001200010000000009" then "'00080002" else if [N3] = "001200010000000012" then "'00080002" else if [N3] = "001200010000000013" then "'00080002" else if [N3] = "001200010000000015" then "'00080002" else if [N3] = "001200010000000014" then "'00080002" else if [N3] = "001200010000000000" then "'00080002" else if [N3] = "001200010000000016" then "'00080002" else if [N3] = "001200010000000017" then "00080002" else [N1 Comercial] ),
    #"Coluna condicional inserida 2" = Table.AddColumn(#"Coluna condicional inserida 1", "N2 NewFEV24", each if [N3] = "001200010000000004" then "'000800020010" else if [N3] = "001200010000000006" then "000800020009" else if [N3] = "001200010000000009" then "'000800020010" else if [N3] = "001200010000000012" then "'000800020010" else if [N3] = "001200010000000013" then "'000800020009" else if [N3] = "001200010000000008" then "'000800050013" else if [N3] = "001200010000000015" then "'000800020008" else if [N3] = "001200010000000016" then "'000800020010" else if [N3] = "001200010000000017" then "000800020010" else [N2]),
    #"Transformar colunas" = Table.TransformColumnTypes(#"Coluna condicional inserida 2", {{"N1 NewFEV24", type text}, {"N2 NewFEV24", type text}})
in
    #"Transformar colunas"

#---------------------------------------------------------------------------------------------------------------------

WITH LinhasFiltradas AS (
    SELECT *
    FROM dbo.POLE_FATO_HIERARQUIA
    WHERE (HIERARQUIA LIKE '0008%' OR HIERARQUIA LIKE '0012%')
      AND HIERARQUIA_PRODUTOS NOT LIKE '%Não%'
      AND HIERARQUIA_PRODUTOS NOT LIKE '%Usar%'
),

ColunasBase AS (
    SELECT
        *,
        LEFT(HIERARQUIA, 8)  AS N1,
        LEFT(HIERARQUIA, 12) AS N2,
        CASE
            WHEN LEFT(HIERARQUIA, 18) = '000800060002000004' THEN '000800060002000002'
            ELSE LEFT(HIERARQUIA, 18)
        END AS N3
    FROM LinhasFiltradas
),

ColunaComercial AS (
    SELECT
        *,
        REPLACE(HIERARQUIA_PRODUTOS, 'Galeto Temperado Cong', 'Galeto Temperado')
            AS HIERARQUIA_PRODUTOS_AJUSTADA,
        CASE
            WHEN N2 = '001200010001' THEN '00080005'
            ELSE N1
        END AS [N1 Comercial]
    FROM ColunasBase
)

SELECT
    *,
    CASE N3
        WHEN '001200010000000001' THEN '00080002'
        WHEN '001200010000000005' THEN '00080002'
        WHEN '001200010000000008' THEN '00080005'
        WHEN '001200010000000011' THEN '00080002'
        WHEN '001200010000000004' THEN '00080002'
        WHEN '001200010000000006' THEN '00080002'
        WHEN '001200010000000009' THEN '00080002'
        WHEN '001200010000000012' THEN '00080002'
        WHEN '001200010000000013' THEN '00080002'
        WHEN '001200010000000015' THEN '00080002'
        WHEN '001200010000000014' THEN '00080002'
        WHEN '001200010000000000' THEN '00080002'
        WHEN '001200010000000016' THEN '00080002'
        WHEN '001200010000000017' THEN '00080002'
        ELSE [N1 Comercial]
    END AS [N1 NewFEV24],
    CASE N3
        WHEN '001200010000000004' THEN '000800020010'
        WHEN '001200010000000006' THEN '000800020009'
        WHEN '001200010000000009' THEN '000800020010'
        WHEN '001200010000000012' THEN '000800020010'
        WHEN '001200010000000013' THEN '000800020009'
        WHEN '001200010000000008' THEN '000800050013'
        WHEN '001200010000000015' THEN '000800020008'
        WHEN '001200010000000016' THEN '000800020010'
        WHEN '001200010000000017' THEN '000800020010'
        ELSE N2
    END AS [N2 NewFEV24]
FROM ColunaComercial;