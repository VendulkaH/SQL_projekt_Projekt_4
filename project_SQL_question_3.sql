-- Je potřeba nejdříve vypočítat procentuální nárůst/pokles cen v jednotliých letech a následně za danou kategorii udělat průměr přes všechny tyto hodnoty

SELECT -- Tady už je ten druhý krok, kde se počítá průměr z hodnot za jednotlivé roky
    category_code,
    ROUND(AVG(food_price_change_percentage), 2) AS avg_yearly_change_pct
FROM ( -- Tady je potřeba vypočítat procentuální nárůst/pokles cen za jednotlivé roky
    SELECT 
        year_value,
        category_code,
        ROUND(AVG(value_food), 2) AS avg_food_price,
        CASE 
            WHEN LAG(AVG(value_food)) OVER (PARTITION BY category_code ORDER BY year_value) IS NOT NULL THEN 
                ROUND(
                    (
                        AVG(value_food) - LAG(AVG(value_food)) OVER (PARTITION BY category_code ORDER BY year_value)
                    ) / LAG(AVG(value_food)) OVER (PARTITION BY category_code ORDER BY year_value) * 100, 
                    2
                )
            ELSE NULL
        END AS food_price_change_percentage
    FROM 
        data_academy_2024_09_26.t_Vendulka_Hruba_project_SQL_primary_final AS tvhpspf 
    WHERE 
        year_value IS NOT NULL
        AND category_code IS NOT NULL
        AND value_food IS NOT NULL
    GROUP BY 
        year_value,
        category_code
	) AS yearly_changes
WHERE 
    food_price_change_percentage IS NOT NULL
GROUP BY 
    category_code
ORDER BY 
    avg_yearly_change_pct ASC;
