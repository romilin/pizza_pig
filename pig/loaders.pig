DEFINE load_order_details(table_location) RETURNS order_details {
    $order_details = LOAD $table_location USING PigStorage(',') AS (
        order_details_id:int,
        order_id:int,
        pizza_id:chararray,
        quantity:int
    );
}

DEFINE load_orders(table_location) RETURNS orders {
    $orders = LOAD $table_location USING PigStorage(',') AS (
        order_id:int,
        date:chararray,
        time:chararray
    );
}

DEFINE load_pizzas(table_location) RETURNS pizzas {
    $pizzas = LOAD $table_location USING PigStorage(',') AS (
        pizza_id:chararray,
        pizza_type_id:chararray
        size:chararray,
        price:float
    );
}

DEFINE load_pizzas_types(table_location) RETURNS pizzas_types {
    $pizzas_types = LOAD $table_location USING PigStorage(',') AS (
        pizza_type_id:chararray
        name:chararray,
        category:chararray,
        ingredients:chararray
    );
}