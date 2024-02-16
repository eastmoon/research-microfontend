import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

class WebCom extends HTMLElement {
  connectedCallback() {
    const mountPoint = this.attachShadow({ mode: 'open' })
    const root = ReactDOM.createRoot(mountPoint);
    root.render(
      <React.StrictMode>
        <App />
      </React.StrictMode>
    );
  }
}
customElements.define('app-react-webcom', WebCom);
