# Project_SQL
Projekt do Engeto Online Datové Akademie

## Zadání projektu
Úkolem tohoto projektu je vyčíst relevantní ekonomická data a následně vypracovat otázky.

Relevantní data jsou uložená do základních tabulek dle vzoru:
- t_{jmeno}{prijmeni}_project_SQL_primary_final
- t_{jmeno}{prijmeni}_project_SQL_secondary_final

Následně je potřeba zodpovědět na následující otázky:
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentruální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárust cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

## Řešení
Jako první je potřeba vytvořit zákaldní tabulky. Skripta pro vytoření těchto tabulek jsou následující:
- project_SQL_primary_final
- project_SQL_secondary_final

Data do základních tabulek byla vybraná z následujících rozsáhlejších tabulek:
- czechia_payroll (informace o mzdách - nejobsáhlejší tabulka)
- czechia_payroll_industry_branch (názvy odvětví)
- czechia_price (ceny potravin)
- czechia_price_category (názvy potravin)
- economies (HDP)

Skripta, díky kterým je možné odpovědět na pět základních otázek, jsou následující:
- project_SQL_question_1
- project_SQL_question_2
- project_SQL_question_3
- project_SQL_question_4
- project_SQL_question_5

Finální dokument odpovídá na všech pět otázek:
- Project_SQL_Průvodní zpráva

## Spouštění projektu
Pro spoušštění projektu je nejprve potřeba otevřít soubor "project_SQL_primary_final", kterým se vytvoří tabulka "t_Vendulka_Hruba_project_SQL_primary_final", se kterou se dále pracuje.

POZN.: soubor "project_SQL_secondary_final" a jím vytvořená tabulka "t_Vendulka_Hruba_project_SQL_secondary_final" nebyly nakonec použity, protože pro zodpovězení páté otázky to nebylo nutné. Jsou zde uvedené pouze pro splnění zadání.
