-- KROK 1: Vytvoření VIEW pro změny GDP (HDP) (pouze Česká republika, roky 2006–2018)
-- HDP (hrubý domácí produkt) a GDP (gross domestic product) jsou vlastně to samé — jen 
-- jedno je česká zkratka (HDP) a druhé anglická (GDP).
CREATE OR REPLACE VIEW v_gdp_changes AS
SELECT 
    `year`,
    GDP,
    ROUND(
        (GDP - LAG(GDP) OVER (ORDER BY `year`)) 
        / LAG(GDP) OVER (ORDER BY `year`) * 100, 2
    ) AS gdp_growth_pct
FROM 
    data_academy_2024_09_26.economies
WHERE GDP IS NOT NULL
  AND country = 'Czech Republic'
  AND `year` BETWEEN 2006 AND 2018;

-- KROK 2: Vytvoření VIEW pro změny cen potravin
CREATE OR REPLACE VIEW v_food_changes AS
SELECT 
    year_value,
    ROUND(AVG(value_food), 2) AS avg_food_price,
    ROUND(
        (AVG(value_food) - LAG(AVG(value_food)) OVER (ORDER BY year_value))
        / LAG(AVG(value_food)) OVER (ORDER BY year_value) * 100, 2
    ) AS food_growth_pct
FROM 
    data_academy_2024_09_26.t_Vendulka_Hruba_project_SQL_primary_final
WHERE value_food IS NOT NULL
GROUP BY year_value;

-- KROK 3: Vytvoření VIEW pro změny mezd
CREATE OR REPLACE VIEW v_salary_changes AS
SELECT 
    year_value,
    ROUND(AVG(value_salary), 2) AS avg_salary,
    ROUND(
        (AVG(value_salary) - LAG(AVG(value_salary)) OVER (ORDER BY year_value))
        / LAG(AVG(value_salary)) OVER (ORDER BY year_value) * 100, 2
    ) AS salary_growth_pct
FROM 
    data_academy_2024_09_26.t_Vendulka_Hruba_project_SQL_primary_final
WHERE value_salary IS NOT NULL
GROUP BY year_value;

-- KROK 4: Hlavní výběr dat – porovnání stejný vs. následující rok
-- POZN.: sy = same year; ny = next year
SELECT 
    sy.reference_year,
    sy.gdp_growth_pct AS gdp_growth_same_year,
    sy.food_growth_pct AS food_growth_same_year,
    sy.salary_growth_pct AS salary_growth_same_year,
    ny.food_growth_pct AS food_growth_next_year,
    ny.salary_growth_pct AS salary_growth_next_year
FROM (
    SELECT 
        g.`year` AS reference_year,
        g.gdp_growth_pct,
        f.food_growth_pct,
        s.salary_growth_pct
    FROM 
        v_gdp_changes g
    LEFT JOIN v_food_changes f ON g.`year` = f.year_value
    LEFT JOIN v_salary_changes s ON g.`year` = s.year_value
) AS sy
LEFT JOIN (
    SELECT 
        g.`year` AS reference_year,
        g.gdp_growth_pct,
        f.food_growth_pct,
        s.salary_growth_pct
    FROM 
        v_gdp_changes g
    LEFT JOIN v_food_changes f ON f.year_value = g.`year` + 1
    LEFT JOIN v_salary_changes s ON s.year_value = g.`year` + 1
) AS ny ON sy.reference_year = ny.reference_year
-- WHERE 
    -- sy.gdp_growth_pct >= 5 -- Podmínka výrazného vzrůstu HDP - Jako dolní hranice vzrůstu HDP bylo zvloeno 5 %
ORDER BY 
    sy.reference_year;
