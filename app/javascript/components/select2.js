import $ from 'jquery';
import 'select2';

$('.select2').select2({
  placeholder: "Types"
});


if (document.getElementById("item_price")) {
  const price = document.getElementById("item_price")
  price.value = ""
  price.placeholder = "Price"
}

if (document.getElementById("item_quantity")) {
  const quantity = document.getElementById("item_quantity")
quantity.value = ""
quantity.placeholder = "Quantity"
}

if (document.getElementById("start_date")) {
  const start = document.getElementById("start_date")
start.value = ""
start.label = ""
start.placeholder = "Pick up time"
}

if (document.getElementById("end_date")) {
  const end = document.getElementById("end_date")
end.value = ""
end.placeholder = "Expiration"
}

// Requiring CSS! Path is relative to ./node_modules
import 'select2/dist/css/select2.css';
