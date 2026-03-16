with

source as (

    -- 
    select * from `workspace`.`dbt_project_raw`.`sales_customers`

),

renamed as (

    select

        ----------  ids
        customerID as customer_id,

        ---------- text
        first_name as customer_first_name,
        last_name as customer_last_name

    from source

)

select * from renamed