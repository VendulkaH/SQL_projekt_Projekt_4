-- Ve skriptu pro úkol 5 jsem se přímo odkazovala na tabulku "economies" a tento skript jsem dělala dodatečně pro splnění zadání

CREATE TABLE t_Vendulka_Hruba_project_SQL_secondary_final
SELECT 
	country,
	year,
	GDP
FROM 
	economies
WHERE 
	GDP IS NOT NULL
  	AND country = 'Czech Republic'
  	AND year BETWEEN 2006 AND 2018;
