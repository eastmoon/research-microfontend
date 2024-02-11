# research-microfontend

## 簡介

微前端 ( Micro Frontend ) 是一種架構樣式 ( Architecture Pattern )，其設計原理源自於 Micro Services，目的是將整體前端應用程式分解，使其達到耦合鬆散與獨立部屬。

![](./doc/img/monolith-frontback-microservices.png)
> from [Micro Frontends - extending the microservice idea to frontend development](https://micro-frontends.org/)，Monolithic Frontends

由如上圖所示，從早期的 Monoith 系統至 Microservice 的演變，這過程中前端 ( Frontend ) 考量用戶操作的流暢度仍保留單頁應用程式 ( SPA、Single Page Application ) 設計，這導致當前端開發功能越多越複雜時，將使前端本身就成為一個難以維護的 Monoith 系統；而若考量 Microservice 設計概念，則應如下圖，基於垂直組織化，將前端與後端視為單一系統的模塊區分，在最終不改變用戶操作流暢度的前提下，做到動態掛入服務模組。

![](./doc/img/verticals-headline.png)
> from [Micro Frontends - extending the microservice idea to frontend development](https://micro-frontends.org/)，Organisation in Verticals

然而，微服務 ( Micro Services ) 透過 API Gateway 可以使其看似一體，而微前端 ( Micro Fontend ) 則必須在瀏覽器端看似一體，可近年因為前端框架 React、Vue、Angular 的崛起，使得前端編譯後的程式是否可混合使用，這是一個值得令人深思的架構議題；但這樣的設計概念，對大型前端專案而言具有以下優勢：

+ 分步版本重構
+ 分散編譯時間
+ 分次載入系統
+ 分批更新軟體

在已知的做法中，共有一下方法達到微前端設計：

+ Single-Spa
+ Webpack Module Federation
+ Iframes and Web Components
+ Custom Solutions and Integration with Existing Frameworks

## 設計議題

### JavaScript

基於 JavaScript 的設計原理，以 iframe、web component 概念建立範本，並注意以下可能問題：

+ 多個封裝、分次載入運作
+ 同名爭議

### Webpack

基於 Webpack Module Federation 設計原理，建立不同前端框架的範本混用：

+ React 不同版本
+ React、Vue、Angular 框架混用

其設計應注意以下可能問題：

+ 多個封裝、分次載入運作
+ 一個頁面動態載入多個框架程式是否會有 JS 衝突
+ 如何正確呼叫到指定框架的內容

### Single-Spa

基於前述範本，使用 Single-Spa 框架。

## 文獻

+ [A Comprehensive Guide to Micro Frontend Architecture](https://medium.com/appfoster/a-comprehensive-guide-to-micro-frontend-architecture-cc0e31e0c053)
    - [Web Components - MDN ](https://developer.mozilla.org/en-US/docs/Web/API/Web_components)
        + [Micro Frontends - extending the microservice idea to frontend development](https://micro-frontends.org/)
        + [Web Component 學習筆記](https://johnnywang1994.github.io/book/articles/js/web-component.html)
    - [HTML <iframe> Tag - w3schools](https://www.w3schools.com/tags/tag_iframe.ASP)
        + [The Strengths and Benefits of Micro Frontends](https://www.toptal.com/front-end/micro-frontends-strengths-benefits)
    - [Module Federation - Webpack](https://webpack.js.org/concepts/module-federation/)
        + [微服務很夯，那你有聽過微前端嗎？初探 Micro Frontends 程式架構](https://medium.com/starbugs/e0a8469be601)
        + [[architecture] Micro-Frontends](https://pjchender.dev/system-design-and-architecture/architecture-udemy-microfrontend/)
+ [single-spa](https://single-spa.js.org/)
    - [Concept: Microfrontends](https://single-spa.js.org/docs/microfrontends-concept/)
