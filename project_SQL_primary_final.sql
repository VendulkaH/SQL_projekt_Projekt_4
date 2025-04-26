-- NAČTENÍ DAT A VÝPOČET PRŮMĚRŮ ZA ROKY
-- data z czechia_payroll
CREATE OR REPLACE VIEW view_vendulka_hruba_czechia_payroll AS
SELECT 
    industry_branch_code, -- odvětví
    AVG(value) AS value_salary, -- průměrná mzda
    value_type_code, -- jednotka
    payroll_year  -- rok
FROM 
    czechia_payroll
WHERE  
    value_type_code = 5958 -- jenom mzdy
GROUP BY 
    industry_branch_code,
    value_type_code,
    payroll_year;
	

-- data z czechia_price
CREATE OR REPLACE VIEW view_vendulka_hruba_czechia_price AS
SELECT
    category_code, -- druh potraviny
    AVG(value) AS value_food, -- průměrná hodnota potraviny
    YEAR(date_from) AS price_year -- rok prodeje potraviny
FROM 
    czechia_price
GROUP BY 
    category_code,
    YEAR(date_from);


-- data z economies
CREATE OR REPLACE VIEW view_vendulka_hruba_economies AS
SELECT
	country,
	`year` AS economies_year, -- uvozovky kvůli stejnému názvu funkce
	GDP,
	population
FROM 
	economies
WHERE 
	country = "Czech Republic";


-- VÝSLEDNÁ TABULKA
-- nejprve vytvoříme seznam všech unikátních let z jednotlivých pohledů
CREATE TABLE t_Vendulka_Hruba_project_SQL_primary_final AS
WITH years_union AS 
(
    SELECT DISTINCT payroll_year AS year FROM view_vendulka_hruba_czechia_payroll
    UNION
    SELECT DISTINCT price_year FROM view_vendulka_hruba_czechia_price
    UNION
    SELECT DISTINCT economies_year FROM view_vendulka_hruba_economies
)
SELECT
    y.year AS year_value,
    p.industry_branch_code,
    p.value_salary,
    c.category_code,
    c.value_food,
    e.GDP,
    e.population
FROM 
	years_union y
LEFT JOIN 
	view_vendulka_hruba_czechia_payroll p ON y.year = p.payroll_year
LEFT JOIN 
	view_vendulka_hruba_czechia_price c ON y.year = c.price_year
LEFT JOIN 
	view_vendulka_hruba_economies e ON y.year = e.economies_year;
