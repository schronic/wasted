// app/javascript/components/banner.js
import swal from 'sweetalert';

function cartEmptyCheckoutButton() {
  const cartButton = document.getElementById('cart-empty-button');


  if (cartButton && document.getElementById('reservations-size')) { // protect other pages
    const reservations = document.getElementById('reservations-size').dataset.reservationsSize

    if (reservations == 0) {
      cartButton.addEventListener('click', () => {
        swal({
          title: "Cart empty",
          text: "You must add items to cart before checking out",
          icon: "success"
        });
      });
    }
  }
}


export { cartEmptyCheckoutButton };
