import $ from 'jquery';
import 'select2';

$('.select2').select2();

const price = document.getElementById("item_price")
price.value = ""
price.placeholder = "Price"

const quantity = document.getElementById("item_quantity")
quantity.value = ""
quantity.placeholder = "Quantity"

const types = document.getElementById("types")
types.value = ""
types.placeholder = "Types"

// Requiring CSS! Path is relative to ./node_modules
import 'select2/dist/css/select2.css';
