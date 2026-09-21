SELECT 
    CdRamoAtividade,
    Segmentacao
FROM 
    POLE_FATO_SEGMENTACAO
WHERE CdRamoAtividade IS NOT NULL;