with

locations as (

    select * from `workspace`.`dbt_project_stage`.`stg_locations`

)

select * from locations