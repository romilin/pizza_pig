#!/bin/bash

order_details=""
orders=""
pizzas=""
pizzas_types=""

script="hawaiian.pig"
params="-p order_details=$order_details -p orders=$orders -p pizzas=$pizzas -p pizzas_types=$pizzas_types"

pig -F $params $script