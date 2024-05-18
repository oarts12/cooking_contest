TRUNCATE TABLE episode_selection;
TRUNCATE TABLE episode_judge;
TRUNCATE TABLE judge_rates_cook;

CALL insert_episode_selection();
CALL insert_episode_judge();
CALL insert_judge_rates_cook();

select count(*) from episode_selection;
select count(*) from episode_judge;
select count(*) from judge_rates_cook;
