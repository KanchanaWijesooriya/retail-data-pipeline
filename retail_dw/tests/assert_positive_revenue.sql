select *
from {{ ref('fct_monthly_sales') }}
where total_items_revenue < 0