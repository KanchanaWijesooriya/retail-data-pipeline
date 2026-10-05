with payments as (

    select * from {{ ref('stg_order_payments') }}

),

aggregated as (

    select
        order_id,
        count(*) as number_of_payments,
        sum(payment_value) as total_payment_value,
        max(payment_installments) as max_installments,
        string_agg(distinct payment_type, ', ') as payment_types_used

    from payments
    group by order_id

)

select * from aggregated