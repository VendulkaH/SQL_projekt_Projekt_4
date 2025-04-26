-- KROK 1: Vytvoření VIEW pro meziroční růst cen potravin
CREATE OR REPLACE VIEW v_food_growth AS
SELECT 
    year_value,
    ROUND(AVG(value_food), 2) AS avg_food_price,
    ROUND(
        (
            AVG(value_food) - LAG(AVG(value_food)) OVER (ORDER BY year_value)
        ) / LAG(AVG(value_food)) OVER (ORDER BY year_value) * 100, 
        2
    ) AS food_growth_pct
FROM 
    data_academy_2024_09_26.t_Vendulka_Hruba_project_SQL_primary_final
WHERE 
    value_food IS NOT NULL
GROUP BY 
    year_value;

-- KROK 2: Vytvoření VIEW pro meziroční růst mezd (salary)
CREATE OR REPLACE VIEW v_salary_growth AS
SELECT 
    year_value,
    ROUND(AVG(value_salary), 2) AS avg_salary,
    ROUND(
        (
            AVG(value_salary) - LAG(AVG(value_salary)) OVER (ORDER BY year_value)
        ) / LAG(AVG(value_salary)) OVER (ORDER BY year_value) * 100, 
        2
    ) AS salary_growth_pct
FROM 
    data_academy_2024_09_26.t_Vendulka_Hruba_project_SQL_primary_final
WHERE 
    value_salary IS NOT NULL
GROUP BY 
    year_value;

-- KROK 3: Porovnání – roky, kdy růst cen potravin převýšil růst mezd (salary)
SELECT 
    f.year_value,
    f.food_growth_pct,
    s.salary_growth_pct,
    ROUND(f.food_growth_pct - s.salary_growth_pct, 2) AS growth_diff_pct
FROM 
    v_food_growth f
JOIN 
    v_salary_growth s ON f.year_value = s.year_value
WHERE 
    f.food_growth_pct IS NOT NULL
    AND s.salary_growth_pct IS NOT NULL
    -- AND (f.food_growth_pct - s.salary_growth_pct) > 10 -- Toto je podmínka pro zobrazení rozdílů větších než daná hodnota
ORDER BY 
    growth_diff_pct DESC;
