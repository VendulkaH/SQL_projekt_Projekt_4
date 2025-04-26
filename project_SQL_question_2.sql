-- Vypočítáno pro každé odvětví zvlášť
SELECT 
    year_value,
    industry_branch_code,
    value_salary,
    category_code,
    value_food,
    CASE
        WHEN category_code = 114201 THEN ROUND(value_salary / value_food, 2) -- Mléko
        WHEN category_code = 111301 THEN ROUND(value_salary / value_food, 2) -- Chléb
        ELSE NULL
    END AS food_quantity
FROM 
    data_academy_2024_09_26.t_Vendulka_Hruba_project_SQL_primary_final AS tvhpspf
WHERE 
    year_value IS NOT NULL 
    AND 
    industry_branch_code IS NOT NULL 
    AND 
    value_salary IS NOT NULL 
    AND 
    category_code IS NOT NULL 
    AND 
    value_food IS NOT NULL
    AND 
    category_code IN (114201, 111301)
    AND 
    year_value IN (2006, 2018)
ORDER BY
    year_value ASC,
    industry_branch_code,
    category_code;




-- Vypočítáno pro průměrnou mzdu v ČR napříč všemi odvětvími
SELECT 
    year_value,
    category_code,
    ROUND(AVG(value_salary), 2) AS avg_salary_all_branches,
    ROUND(AVG(value_food), 2) AS avg_food_price,
    ROUND(AVG(value_salary) / AVG(value_food), 2) AS food_quantity
FROM 
    data_academy_2024_09_26.t_Vendulka_Hruba_project_SQL_primary_final
WHERE 
    year_value IN (2006, 2018)
    AND 
    category_code IN (114201, 111301) -- Mléko = 114201; Chléb = 111301
    AND 
    value_salary IS NOT NULL
    AND 
    value_food IS NOT NULL
GROUP BY 
    year_value,
    category_code
ORDER BY 
    year_value,
    category_code;