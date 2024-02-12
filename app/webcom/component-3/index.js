// Declare Class
class com extends HTMLElement {
  constructor() {
    super();

    // Retrieve template in DOM by ID 'demo-template'
    const template = document.getElementById('demo-template');
    const templateContent = template.content;

    // Setting a shadowRoot and append content
    this.attachShadow({mode: 'open'}).appendChild(
      templateContent.cloneNode(true)
    );
  }
}

// Declare element
customElements.define('com-3', com);
