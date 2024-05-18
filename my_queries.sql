1.
SELECT concat(c.first_name, ' ', c.last_name) Name, avg(jrc.rating) 'Average Rating'
FROM cook C
INNER JOIN judge_rates_cook jrc ON jrc.cook_id=c.cook_id
GROUP BY c.cook_id;


SELECT n.title Cuisine, avg(jrc.rating) 'Average Rating'
FROM judge_rates_cook jrc
INNER JOIN episode_selection se ON se.episode_id = jrc.episode_id
INNER JOIN recipe r ON r.recipe_id = se.recipe_id
INNER JOIN cuisine n ON n.cuisine_id = r.cuisine_id
GROUP BY n.cuisine_id;

2.


SELECT concat(c.first_name, ' ', c.last_name) 'Cooks that know this cuisine'
FROM cook c
INNER JOIN cook_cuisine ck ON c.cook_id = ck.cook_id
INNER JOIN cuisine n ON n.cuisine_id = ck.cuisine_id
WHERE n.title = "english";


SELECT n.title, concat(c.first_name, ' ', c.last_name) 'Cooks who cooked this cusine this year'
FROM episode_selection se
INNER JOIN recipe r ON r.recipe_id = se.recipe_id
INNER JOIN cuisine n ON n.cuisine_id = r.cuisine_id
INNER JOIN cook c ON c.cook_id = se.cook_id
INNER JOIN episode e ON e.episode_id = se.episode_id
WHERE n.title = "french" AND e.year = "2018"
GROUP BY n.cuisine_id, c.first_name, c.last_name;

3.

SELECT concat(c.first_name, ' ', c.last_name) name, count(*) 'number of recipes'
FROM cook c
INNER JOIN recipe_cook rc ON rc.cook_id = c.cook_id
WHERE c.age < 30
GROUP BY c.cook_id, c.first_name, c.last_name
ORDER BY count(*) DESC;



4.

SELECT concat(first_name, ' ', last_name) 'Cooks who havent participated in an episode'
FROM cook
WHERE cook_id NOT IN (
    SELECT c.cook_id
    FROM cook c 
    INNER JOIN episode_judge ej on ej.cook_id = c.cook_id
);


7.

SELECT concat(c.first_name, ' ', c.last_name) 'Cooks who have participated in at least 5 less episodes that the cook with the most episodes', count(*) 'Number of episodes'
FROM cook c
INNER JOIN episode_selection se ON se.cook_id = c.cook_id
GROUP BY c.cook_id
HAVING count(*) <= -5 + (
    SELECT count(*)
    FROM cook c
    INNER JOIN episode_selection se ON se.cook_id = c.cook_id
    GROUP BY c.cook_id
    ORDER BY count(*) DESC LIMIT 1
)
ORDER BY count(*);

8.


SELECT e.episode_id, count(*) 
FROM episode e
INNER JOIN episode_selection se ON e.episode_id = se.episode_id
INNER JOIN recipe r ON r.recipe_id = se.recipe_id
INNER JOIN recipe_equipment re ON r.recipe_id = re.recipe_id
GROUP BY e.episode_id
ORDER BY count(*) DESC LIMIT 1;

9.

SELECT e.year, avg(r.carbo_portion*r.portions) 'Average gr of carbs per year'
FROM episode e
INNER JOIN episode_selection se ON e.episode_id = se.episode_id
INNER JOIN recipe r ON r.recipe_id = se.recipe_id
GROUP BY e.year;

12.

SELECT se.episode_id "Episode", sum(r.difficulty) "Total Difficulty"
FROM episode e
INNER JOIN episode_selection se ON se.episode_id = e.episode_id
INNER JOIN recipe r ON r.recipe_id = se.recipe_id
WHERE e.year = '2023'
GROUP BY se.episode_id
ORDER BY sum(r.difficulty) DESC LIMIT 1;


14. 

SELECT t.title, count(*)
FROM episode_selection se
INNER JOIN recipe r ON r.recipe_id = se.recipe_id
INNER JOIN recipe_theme re ON r.recipe_id = re.recipe_id
INNER JOIN theme t ON t.theme_id = re.theme_id
GROUP BY t.title
ORDER BY count(*) DESC LIMIT 1;
