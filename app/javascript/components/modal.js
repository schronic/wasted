export const bindListener = () => {
  const controlsArray = document.querySelectorAll(".controls")

  controlsArray.forEach(control => {
    const quantity = control.querySelector(".quantity").dataset.itemQuantity
    const btnUp = control.querySelector(".up")
    const btnDown = control.querySelector(".down")
    let circle = control.querySelector(".circle")

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
  })
}
