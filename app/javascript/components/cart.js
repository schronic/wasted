// app/javascript/components/banner.js
import swal from 'sweetalert';

function cartEmptyCheckoutButton() {
  const cartButton = document.getElementById('cart-empty-button');
  if (cartButton) { // protect other pages
    cartButton.addEventListener('click', () => {
      swal({
        title: "Cart empty",
        text: "You must add items to cart before checking out",
        icon: "success"
      });
    });
  }
}


export { cartEmptyCheckoutButton };
