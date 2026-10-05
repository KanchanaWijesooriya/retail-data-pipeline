with source as (

    select * from {{ source('retail_raw', 'product_category_translation') }}

),

renamed as (

    select
        product_category_name,
        product_category_name_english

    from source

)

select * from renamed