export const bindListener = () => {
  const controlsArray = document.querySelectorAll(".controls")

  controlsArray.forEach(control => {
    const quantity = control.querySelector(".quantity").dataset.itemQuantity
    const btnUp = control.querySelector(".up")
    const btnDown = control.querySelector(".down")
    let circle = control.querySelector(".circle")
    let updateQuantityText = control.querySelector(".update-quantity")
    console.log(updateQuantityText)


    circle.addEventListener('input', () => {
      if (circle.value > quantity) {
        circle.value = quantity
      } else if (circle.value < 0) {
        circle.value = 0
      }
    })

    btnUp.addEventListener('click',() => {
      if (circle.value < quantity) {
        circle.value = parseInt(circle.value, 10) + 1
      }
    })

    btnDown.addEventListener('click',() => {
      if (circle.value > 0) {
        circle.value = parseInt(circle.value, 10) - 1
      }
    })

    if (updateQuantityText.dataset.inCart == "true") {
      updateQuantityText.innerHTML = `
                                      <span style="text-align:center; margin-left: 42px; ">
                                      <span>
                                        Update Cart
                                      </span>
                                      <br>
                                      <span style="color: green; font-size: 14px; margin-left: 57px">
                                        (${circle.value} in cart)
                                      </span>
                                      </span>
                                      `
    } else {
      updateQuantityText.innerHTML = "<p>Quantity</p>"
    }


  })
}
