with

supplies as (

    select * from `workspace`.`dbt_project_stage`.`stg_supplies`

)

select * from supplies