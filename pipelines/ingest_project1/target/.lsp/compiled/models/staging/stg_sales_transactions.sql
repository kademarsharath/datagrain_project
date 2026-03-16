with

source as (

    -- 
    select * from `workspace`.`dbt_project_raw`.`sales_transactions`

),

renamed as (

    select

        ----------  ids
        transactionID as transaction_id,
        customerID as customer_id,

        ---------- measures
        unitPrice as unit_price,
        quantity as quantity,
        totalPrice as total_price

    from source

)

select * from renamed