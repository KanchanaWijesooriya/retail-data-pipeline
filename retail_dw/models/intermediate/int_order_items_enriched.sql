with order_items as (

    select * from {{ ref('stg_order_items') }}

),

products as (

    select * from {{ ref('stg_products') }}

),

product_translation as (

    select * from {{ ref('stg_product_category_translation') }}

),

sellers as (

    select * from {{ ref('stg_sellers') }}

),

joined as (

    select
        order_items.order_id,
        order_items.order_item_id,
        order_items.product_id,
        order_items.seller_id,
        order_items.price,
        order_items.freight_value,
        order_items.shipping_limit_date,

        products.product_category_name,
        product_translation.product_category_name_english,
        products.product_weight_g,

        sellers.seller_city,
        sellers.seller_state

    from order_items
    left join products
        on order_items.product_id = products.product_id
    left join product_translation
        on products.product_category_name = product_translation.product_category_name
    left join sellers
        on order_items.seller_id = sellers.seller_id

)

select * from joined