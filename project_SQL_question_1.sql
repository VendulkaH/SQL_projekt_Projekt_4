SELECT 
    year_value,
    industry_branch_code,
    ROUND(AVG(value_salary), 2) AS avg_salary, -- v primární tabulce jsou stejné hodnoty vícekrát, takže to zprůměrujeme a tím odstraníme duplicitní data
    ROUND(
        	(AVG(value_salary) - LAG(AVG(value_salary)) OVER 
        		(
            	PARTITION BY industry_branch_code 
            	ORDER BY year_value
        		)
        	) 
        	/LAG(AVG(value_salary)) OVER 
        		(
            	PARTITION BY industry_branch_code 
            	ORDER BY year_value
        		) * 100, 2
        ) AS percentage_change
FROM 
    t_Vendulka_Hruba_project_SQL_primary_final
WHERE 
    industry_branch_code IS NOT NULL
GROUP BY 
    year_value,
    industry_branch_code
ORDER BY 
    industry_branch_code,
    year_value DESC;
