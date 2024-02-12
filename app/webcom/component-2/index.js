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
      color: black;
    }
    `

    // Setting a shadowRoot and append content
    const shadowRoot = this.attachShadow({mode: 'open'});
    shadowRoot.appendChild(styleElem);
    shadowRoot.appendChild(divElem);
  }
}

// Declare element
customElements.define('com-2', com);
