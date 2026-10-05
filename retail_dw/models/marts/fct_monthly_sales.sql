with order_items as (

    select * from {{ ref('int_order_items_enriched') }}

),

orders as (

    select * from {{ ref('int_orders_enriched') }}

),

payments as (

    select * from {{ ref('int_order_payments_summary') }}

),

order_item_totals as (

    select
        order_id,
        count(*) as items_in_order,
        sum(price) as items_revenue,
        sum(freight_value) as total_freight

    from order_items
    group by order_id

),

joined as (

        select
        date_trunc(date(orders.order_purchase_timestamp), month) as order_month,
        orders.customer_state,
        orders.order_status,

        count(distinct orders.order_id) as number_of_orders,
        round(sum(order_item_totals.items_revenue), 2) as total_items_revenue,
        round(sum(order_item_totals.total_freight), 2) as total_freight_revenue,
        round(sum(payments.total_payment_value), 2) as total_payment_value

    from orders
    left join order_item_totals
        on orders.order_id = order_item_totals.order_id
    left join payments
        on orders.order_id = payments.order_id

    group by order_month, customer_state, order_status

)

select * from joined
order by order_month, customer_state