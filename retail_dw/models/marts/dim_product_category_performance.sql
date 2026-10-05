with order_items as (

    select * from {{ ref('int_order_items_enriched') }}

),

aggregated as (

    select
        coalesce(product_category_name_english, 'unknown') as product_category,

        count(distinct order_id) as number_of_orders,
        count(*) as number_of_items_sold,
        round(sum(price), 2) as total_revenue,
        round(avg(price), 2) as average_item_price

    from order_items
    group by product_category

)

select * from aggregated
order by total_revenue desc