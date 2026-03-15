with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('ecom', 'sales_customers') }}

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
