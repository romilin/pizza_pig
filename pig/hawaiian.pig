IMPORT 'loaders.pig';

order_details = load_order_details($order_details);
orders = load_orders($orders);
pizzas = load_pizzas($pizzas);
-- pizzas_types = load_pizzas_types($pizzas_types);

