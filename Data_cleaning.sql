CREATE OR REPLACE VIEW `agro-data-project.Agricultural_Production.cleaned_data` AS 
WITH CLEAN AS (
  SELECT *,
    TRIM(Cultivo_Agricola) AS Crop_Cleaned,
    SAFE.PARSE_DATE('%Y%m%d', CAST(Fecha_Corte AS STRING)) AS Date_Cleaned,

    CASE
      WHEN Campania_Agricola = '2023-2024' THEN Produccion
      ELSE Rendimiento
    END AS Production_Cleaned,

    CASE
      WHEN Campania_Agricola = '2023-2024' THEN Rendimiento
      ELSE Produccion
    END AS Yield_Cleaned

  FROM `Agricultural_Production.Production and performance`),

QUALITY AS (
  SELECT * ,
    SAFE_DIVIDE(Production_Cleaned * 1000, Cosechada)
      AS Yield_Calculated,
    CASE
      WHEN Production_Cleaned > 0 AND Yield_Cleaned = 0
      THEN 'Review'
      ELSE 'OK'
    END AS Yield_Status,

    CASE
      WHEN SAFE_CAST(Cod_Cultivo AS INT64) IS NULL
      THEN 'Review'
      ELSE 'OK'
    END AS Code_Status,
    
    CASE 
      WHEN Cod_Ubigeo ='#N/D' OR Cod_Ubigeo IS NULL
      THEN 'Review'
      ELSE 'OK'
    END AS Ubigeo_Status

  FROM CLEAN),

CONSISTENCY AS (
  SELECT *,
    CASE
      WHEN Yield_Calculated IS NULL
        OR Yield_Cleaned IS NULL
      THEN 'Not checked'
      WHEN ABS(Yield_Calculated - Yield_Cleaned) > 0.01
      THEN 'Review'
      ELSE 'OK'
    END AS Yield_Consistency_Status
  FROM QUALITY),

FINAL AS (
  SELECT *,
    CASE
      WHEN Yield_Status = 'Review'
        OR Yield_Consistency_Status = 'Review'
        OR Code_Status = 'Review'
        OR Ubigeo_Status = 'Review'
      THEN 'Review'

      WHEN Yield_Consistency_Status = 'Not checked'
      THEN 'Not checked'

      ELSE 'OK'
    END AS Overall_Status
  FROM CONSISTENCY
)

SELECT *, SAFE_DIVIDE(Yield_Cleaned * Cosechada, 1000)
    AS Total_Yield_Tonnes
FROM FINAL;

