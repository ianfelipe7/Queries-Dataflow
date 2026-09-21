SELECT
      TP_PEDIDO,
      Desc_TP_PEDIDO,
      CASE 
        WHEN TP_PEDIDO = 'Z009' THEN 'Portal de Vendas'
        WHEN TP_PEDIDO = 'Z010' THEN 'Sellentt'  
        WHEN TP_PEDIDO = 'Z004' THEN 'Venda Assistida'  
      ELSE  'Outros'
      END AS FONTE_PEDIDO
    FROM POLE_FATO_TpPedido;