with

products as (

    select * from `workspace`.`dbt_project_stage`.`stg_products`

)

select * from products