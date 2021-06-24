window.addEventListener('load',() => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    addTaxDom.innerHTML = Math.trunc(priceInput.value / 10);
    profitDom.innerHTML = Math.trunc(priceInput.value * 0.9);
  })
});