IMPORT 'loaders.pig';

order_details = load_order_details($order_details);
orders = load_orders($orders);
pizzas = load_pizzas($pizzas);
-- pizzas_types = load_pizzas_types($pizzas_types);

-- Jointure
pizzas-order_details = JOIN pizzas BY (pizza_id), order_details BY (pizza_id);
pizzas-order_details = FOREACH pizzas-order_details GENERATE 
    pizza_type_id               AS pizza_type_id,
    order_id                    AS order_id,
    quantity                    AS quantity,
    price                       AS price;

pizzas-order_details-orders = JOIN pizzas-order_details BY (order_id), orders BY (order_id);
pizzas-order_details-orders = FOREACH pizzas-order_details-orders GENERATE
    date            AS date,
    pizza_type_id   AS pizza_type_id,
    quantity        AS quantity;
    price           AS price;


-- Filtre sur les donnees
pizzas_hawaiian = FILTER pizzas-order_details-orders BY (pizza_type_id == "hawaiian");

-- Remodelage de la table
pizzas_hawaiian = FOREACH pizzas_hawaiian GENERATE
    SUBSTRING(date, 5, 7)   AS month,
    quantity                AS quantity,
    quantity*price          AS money;

-- Groupe par mois
pizzas_hawaiian_month_grp = GROUP pizzas_hawaiian BY month;
pizzas_hawaiian_month = FOREACH pizzas_hawaiian_month_grp GENERATE {
    group                           AS month,
    SUM(pizzas_hawaiian.quantity)   AS quantity,
    SUM(pizzas_hawaiian.money)      AS money;
} 

final_data = ORDER pizzas_hawaiian_month BY month ASC;

STORE final_data INTO 'directory' USING PigStorage(',');