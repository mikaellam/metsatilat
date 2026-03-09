DROP VIEW IF EXISTS v_kohdekiinteistot;

CREATE VIEW v_kohdekiinteistot AS
SELECT *
FROM "PalstanSijaintitiedot"
WHERE kiinteistotunnus IN (
    '70241100050009', '70241100030061', '70241100050041', 
    '70242800150009', '70242800370006', '70242200090003'
);