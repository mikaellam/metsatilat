DROP VIEW IF EXISTS v_kuviot_paapuulaji;

CREATE VIEW v_kuviot_paapuulaji AS
SELECT 
    row_number() OVER () AS id,
    m.standnumber,
    CASE 
        WHEN m.maintreespecies = 1 THEN 'Mänty'
        WHEN m.maintreespecies = 2 THEN 'Kuusi'
        WHEN m.maintreespecies = 3 THEN 'Rauduskoivu'
        WHEN m.maintreespecies = 4 THEN 'Hieskoivu'
        WHEN m.maintreespecies = 5 THEN 'Haapa'
        WHEN m.maintreespecies = 0 THEN 'Vesistö / Muu'
        ELSE 'Muu/Määrittämätön'
    END AS paapuulaji,
    m.area AS alkuperainen_pinta_ala,
    -- ST_Intersection leikkaa kuviot tismalleen kiinteistön rajaan
    ST_Multi(ST_CollectionExtract(ST_MakeValid(ST_Intersection(m.geom, k.geom)), 3))::geometry(MultiPolygon, 3067) AS geom
FROM "MV_Ruovesi" m
JOIN "PalstanSijaintitiedot" k ON ST_Intersects(m.geom, k.geom)
WHERE k.kiinteistotunnus IN (
    '70241100050009', '70241100030061', '70241100050041', 
    '70242800150009', '70242800370006', '70242200090003'
)
AND NOT ST_IsEmpty(ST_Intersection(m.geom, k.geom));