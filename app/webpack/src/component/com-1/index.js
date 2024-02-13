// Declare Class
class com extends HTMLElement {
  constructor() {
    super();

    // Create a 'div' element and setting text value by element attribute 'text'
    const divElem = document.createElement('div');
    divElem.textContent = this.getAttribute('text');

    // Create a 'style' element
    const styleElem = document.createElement('style');
    styleElem.textContent = `
    div {
      color: gray;
    }
    `

    // Append content
    this.appendChild(styleElem);
    this.appendChild(divElem);
  }
}

// Declare element
customElements.define('com-1', com);

// Export class
export default com
