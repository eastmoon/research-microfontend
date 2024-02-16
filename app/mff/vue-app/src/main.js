import { defineCustomElement } from 'vue'
import App from './App.ce.vue'

const elm = defineCustomElement(App)

customElements.define('app-vue-webcom', elm)
