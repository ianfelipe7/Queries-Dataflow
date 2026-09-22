SELECT DISTINCT 
    CASE
        WHEN LEN(TRIM(nuCNPJ)) < 14 THEN 
            RIGHT(CONCAT(REPLICATE('0', 14), TRIM(nuCNPJ)), 14)
        ELSE
            TRIM(nuCNPJ)
    END AS nuCNPJ,
    ContaCredito,
    cdCliente,
    CAST(cdCliente AS BIGINT) AS [cdCliente - Copiar],
    nmRazaoSocial,
    nmFantasia,
    CASE 
        WHEN Segmentacao IS NULL OR Segmentacao = '' THEN 'Centro Distribuição'
        ELSE Segmentacao
    END AS Segmentação,
    CASE 
        WHEN cdCategoria = 20 THEN 'Varejo'
        WHEN cdCategoria = 10 THEN 'Atacado'
        WHEN cdCategoria = 30 THEN 'FoodService'
        WHEN cdCategoria = 40 THEN 'As'
        WHEN cdCategoria = 50 THEN 'Outros'
        WHEN cdCategoria = 60 THEN 'Funcionario'
        WHEN cdCategoria = 70 THEN 'Atacarejo'
    END AS Categoria,
    cdCategoria,
    ESCRITORIO,
    EQUIPE,
    SUBSTRING(cdRotaEntrega, PATINDEX('%[^0]%', cdRotaEntrega + '0'), LEN(cdRotaEntrega)) AS cdRotaEntrega,
    NmVendedor,
    CAST(cdRede AS BIGINT) AS cdRede,
    dsLogradouroComercial,
    dsBairroComercial,
    dsCidadeComercial,
    RIGHT(cdCidadeComercial, 7) AS cdCidadeComercial,
    nuFoneFax,
    nuCelular,
    dsEmail,
    cdCondicaoPagamento,
    dtUltimoPedido,
    CAST(flStatusCliente AS BIGINT) AS flStatusCliente,
    dtCadastro,
    cdLatitude,
    cdLongitude,
    GrpConta,
    dsSituacao,
    flStatusCliente,
    cdCondicaoPagamento,
    cdTabelaPreco,
    LEFT(DiaVisita, 3) AS DiaVisita,
    DiaEntrega,
    DiaSeman,
    CAST(OrdemVisita AS BIGINT) AS OrdemVisita,
    vlLimiteCredito,
    LimDisp,
    Risco,
    c.cdRamoAtividade
FROM 
    POLE_FATO_CLIENTE_NEW c
LEFT JOIN 
    POLE_FATO_SEGMENTACAO s
ON 
    c.cdRamoAtividade = s.cdRamoAtividade
WHERE ESCRITORIO IS NOT NULL
    AND ESCRITORIO <> ''
    AND ESCRITORIO NOT BETWEEN 2000 AND 3000
    AND EQUIPE <> '314'
;