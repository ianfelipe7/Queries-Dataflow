SELECT
    MATERIAL,
    CAST(MATERIAL * 1 AS VARCHAR(20)) AS Cod_Material,
    HIERARQUIA,
    EAN,
    DescMaterial,
    DescHierarquia,
    KG_EMBALAGEM,
    Gramas,
    UM,
    MARCA_DO_PRODUTO,
    CONCAT(EAN, '.', CAST(MATERIAL AS INT)) AS Chave_Ean_Material
FROM POLE_FATO_MATERIAIS
WHERE 
    CAST(MATERIAL AS INT) BETWEEN 300000 AND 499999
    AND TRIM(DescHierarquia) NOT LIKE '%não%'
    AND TRIM(DescHierarquia) NOT LIKE ''
    AND TRIM(DescMaterial) NOT LIKE '%não%'
    AND TRIM(DescMaterial) NOT LIKE '%VFUN%'
    AND TRIM(DescMaterial) NOT LIKE '%nao%'
    AND TRIM(EAN) IS NOT NULL
    AND TRIM(EAN) <> '';