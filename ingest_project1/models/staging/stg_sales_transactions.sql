with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('bronze', 'sales_transactions') }}

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
