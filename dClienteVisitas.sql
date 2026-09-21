SELECT
    CAST(CodCliente AS INTEGER) AS CodCliente,
    DiaSemana,
    CAST(Rota AS INTEGER) AS Rota,
    CAST(OrdemVisita AS INTEGER) AS OrdemVisita,
    CAST(EqVs AS INTEGER) AS EqVs,
    CAST(EscrV as INTEGER) AS EscrV
FROM POLE_FATO_ClienteVisita
WHERE CodCliente <> 0
AND EscrV BETWEEN 3001 AND 4000;