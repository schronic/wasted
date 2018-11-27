// app/javascript/components/banner.js
import swal from 'sweetalert';

function cartEmptyCheckoutButton() {
  const swalCartButton = document.getElementById('cart-empty-button');
  if (swalCartButton) { // protect other pages
    swalCartButton.addEventListener('click', () => {
      swal({
        title: "Cart empty",
        text: "You must add items to cart before checking out",
        icon: "success"
      });
    });
  }
}

export { cartEmptyCheckoutButton };
