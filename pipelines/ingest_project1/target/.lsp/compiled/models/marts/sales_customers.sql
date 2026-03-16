with

customers as (

    select * from `workspace`.`dbt_project_stage`.`stg_sales_customers`

),

orders as (

    select * from `workspace`.`dbt_project_stage`.`stg_sales_transactions`

),

customer_orders_summary as (

    select
        orders.customer_id,

        count(distinct orders.transaction_id) as count_lifetime_orders,
        count(distinct orders.transaction_id) > 1 as is_repeat_buyer,
        sum(orders.unit_price*orders.quantity ) as unit_prices,
        sum(orders.quantity) as quantity

    from orders

    group by 1

),

joined as (

    select
        customers.*,

        customer_orders_summary.count_lifetime_orders,
        customer_orders_summary.unit_prices,
        customer_orders_summary.quantity,
        case
            when customer_orders_summary.is_repeat_buyer then 'returning'
            else 'new'
        end as customer_type

    from customers

    left join customer_orders_summary
        on customers.customer_id = customer_orders_summary.customer_id

)

select * from joined