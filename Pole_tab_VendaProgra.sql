WITH cte AS (
    SELECT *,
      UPPER(
        CASE 
          WHEN MONTH([PROX_DATA]) = 1 THEN 'JAN'
          WHEN MONTH([PROX_DATA]) = 2 THEN 'FEV'
          WHEN MONTH([PROX_DATA]) = 3 THEN 'MAR'
          WHEN MONTH([PROX_DATA]) = 4 THEN 'ABR'
          WHEN MONTH([PROX_DATA]) = 5 THEN 'MAI'
          WHEN MONTH([PROX_DATA]) = 6 THEN 'JUN'
          WHEN MONTH([PROX_DATA]) = 7 THEN 'JUL'
          WHEN MONTH([PROX_DATA]) = 8 THEN 'AGO'
          WHEN MONTH([PROX_DATA]) = 9 THEN 'SET'
          WHEN MONTH([PROX_DATA]) = 10 THEN 'OUT'
          WHEN MONTH([PROX_DATA]) = 11 THEN 'NOV'
          WHEN MONTH([PROX_DATA]) = 12 THEN 'DEZ'
        END
        ) AS MesAbr,
      CAST([EMISSOR_ORDEM] AS INT) AS codcliente,
      CAST([ROTA] AS INT) AS ROTA_int,
      UPPER(REPLACE(LTRIM(REPLACE(CAST([ROTA] AS VARCHAR(50)), '0', ' ')), ' ', '0')) AS RotaNoZeros,
      YEAR([PROX_DATA]) AS YearPart,
      UPPER(REPLACE(LTRIM(REPLACE(CAST([EMISSOR_ORDEM] AS VARCHAR(50)), '0', ' ')), ' ', '0')) AS CodNoZero
    FROM dbo.Pole_tab_VendaProgra
    WHERE EMISSOR_ORDEM IS NOT NULL AND ROTA IS NOT NULL
)
    SELECT 
      ORGANIZACAO,
      DOCUMENTO_VENDAS,  
      PROX_DATA,  
      DT_CRIACAO_ORDEM,  
      CodNoZero AS EMISSOR_ORDEM,  
      N_MATERIAL,
      ESCRITORIO_VENDAS,
      EQUIPE_VENDAS, 
      RotaNoZeros AS ROTA, 
      QUANTIDADE,  
      VALOR,  
      codcliente,
      RotaNoZeros + MesAbr + CAST(YearPart AS VARCHAR(4)) AS 'Rota + AnoMes'
    FROM cte
    WHERE ESCRITORIO_VENDAS IS NOT NULL
      AND ESCRITORIO_VENDAS <> ''
      AND ESCRITORIO_VENDAS NOT BETWEEN 2000 AND 3000
      AND EQUIPE_VENDAS <> '314'
    ;