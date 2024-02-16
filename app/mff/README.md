## 建立前端框架專案

### React

#### 建置專案

使用 [create-react-app](https://github.com/facebook/create-react-app) 工具來建立專案

+ 安裝 ```npm install -g create-react-app```
+ 使用 ```npx create-react-app react-app``` 建立專案 react-app
+ 進入 react-app 專案，執行 ```npm run start``` 啟動開發伺服器
+ 進入 react-app 專案，執行 ```npm run build``` 編譯專案

#### 開發環境

修復對應容器的開發伺服器異常：

+ 添加一個 .env.development 環境變數檔案供 ```npm run start``` 執行時宣告開發伺服器參數
    - 使用 ```HOST=0.0.0.0``` 修復指定接受全域名
    - 使用 ```PORT=8084``` 修復熱修復在 Socket 連線失敗
    - 使用 ```CHOKIDAR_USEPOLLING=true``` 或 ```WATCHPACK_POLLING=true``` 修復容器目錄監測異常，改為輪詢監測；此兩者差別是基於 react-script 5.x.x 版本之後
+ 參考文獻
    - [Adding Development Environment Variables In .env](https://create-react-app.dev/docs/adding-custom-environment-variables/#adding-development-environment-variables-in-env)
    - [Advanced Configuration](https://create-react-app.dev/docs/advanced-configuration)

#### Web Component

+ [React and Web Components](https://legacy.reactjs.org/docs/web-components.html)
    - [Custom HTML elements](https://react.dev/reference/react-dom/components#custom-html-elements)
    - [creating pure web component from react components](https://stackoverflow.com/questions/66970860)
    - [Convert Existing React Components into WebComponents](https://levelup.gitconnected.com/2b33b842ff9a)
    - [React to Web Component](https://github.com/bitovi/react-to-web-component)

基於 React 框架設計專案輸出的 JS 可以掛載為 Web Component，以便用於微前端的頁面整合，期設定需包括以下步驟：

+ 在 ```index.js``` 中，使用原生 HTMLElement 封裝 ReactDOM 的行為
+ 將 ```App.css``` 中的內容以多行撰寫形式改為變數寫在 ```App.js```
+ 在 index.html 中，將原本供元件索引的元件改為 Web Component 註冊的元件

詳細設定參考範例程式 [react-app](./react-app/src) 的程式，在此補充應注意的建置規則：

+ ShadowDOM 樣式遺失
由於 React 使用 ```import 'xxx.css'``` 會基於框架編譯流程被抽離為獨立檔案，這使得載入 css 也會是在外部，而非元件的 ShadowDOM 中；若要改變則需使用 style-component 或將樣式以變數寫入 ```App.js``` 中

### Vue

#### 建置專案

使用 [create-vue](https://vuejs.org/guide/quick-start.html#creating-a-vue-application) 工具來建立專案

+ 安裝 ```npm install -g create-vue```
+ 使用 ```npx create-vue vue-app``` 建立專案 vue-app
+ 進入 vue-app 專案，執行 ```npm run dev``` 啟動開發伺服器
+ 進入 vue-app 專案，執行 ```npm run build``` 編譯專案

#### 開發環境

修復對應容器的開發伺服器異常：

+ 使用 ```server.host: true``` 修復指定接受全域名
+ 使用 ```server.watch: { usePolling: true }``` 修復容器目錄監測異常，改為輪詢監測
+ 參考文獻
    - [Server Options](https://vitejs.dev/config/server-options.html)

詳細設定參考 [vite.config.js](./vue-app/vite.config.js)

#### Web Component

+ [Vue and Web Components](https://vuejs.org/guide/extras/web-components.html)
    - [vue-custom-element-example](https://github.com/ElMassimo/vue-custom-element-example/tree/main)
    - [@vue/web-component-wrapper](https://github.com/vuejs/vue-web-component-wrapper)

基於 Vue 框架設計專案輸出的 JS 可以掛載為 Web Component，以便用於微前端的頁面整合，期設定需包括以下步驟：

+ 在 ```main.js``` 中，將原本 createApp 的函數改為 defineCustomElement
+ 將原有 ```App.vue``` 改名為 ```App.ce.vue```，使其成為 Vue Single-File Components (SFCs)，
+ 將 SFC 交由 defineCustomElement 轉換為元件
+ 使用 customElements 註冊元件
+ 在 index.html 中，將原本供元件索引的元件改為 Web Component 註冊的元件

詳細設定參考範例程式 [vue-app](./vue-app/src) 的程式，在此補充應注意的建置規則：

+ 所有在 SFC 中的 style 會預設載入 customElement 的 shadow DOM style 標籤內

### Angular

使用 [angular/cli](https://angular.io/cli) 工具來建立專案

+ 安裝 ```npm install -g @angular/cli```
+ 使用 ```ng new angular-app --skip-git --skip-install --routing --style=scss --interactive=false``` 建立專案 angular-app
+ 進入 angular-app 專案，執行 ```npm run start -- --host 0.0.0.0``` 啟動開發伺服器
+ 進入 angular-app 專案，執行 ```npm run build``` 編譯專案

其他詳細運用可參考 [Angular command line interface](https://github.com/eastmoon/tutorial-js-angular/blob/main/repo/readme.md)

修復對應容器的開發伺服器異常：

+ 在 ```npm run start``` 執行時，添加以下參數至 package.json 中
    - 使用 ```--host 0.0.0.0``` 修復指定接受全域名
    - 使用 ```--port 8084``` 修復熱修復在 Socket 連線失敗
    - 使用 ```--poll 500``` 修復容器目錄監測異常，改為每 500ms 輪詢監測
+ 參考文獻
    - [ng serve - CLI](https://angular.io/cli/serve)

#### Web Component

+ [Angular elements overview](https://angular.io/guide/elements)
    - [Create custom element to wrap your Angular app in an angular element (web component)](https://gist.github.com/chriskitson/3c9d57c90f9ce7b052be959543606628)
    - [View encapsulation](https://angular.io/guide/view-encapsulation)

基於 Angular 框架設計專案輸出的 JS 可以掛載為 Web Component，以便用於微前端的頁面整合，期設定需包括以下步驟：

+ 在專案添加套件 ```ng add @angular/elements```
+ 避免使用 standalone 元件，採用元件 ( Component ) 與模組 ( Moudle ) 分離設定
+ 在 ```app.module.ts``` 設計如下
    - 建構函數中使用 createCustomElement 函數註冊元件
    - 移除 NgModule 中的 bootstrap 設定
+ 在 index.html 中，將原本供元件索引的元件改為 Web Component 註冊的元件

詳細設定參考範例程式 [angular-app](./angular-app/src) 的程式，在此補充應注意的建置規則：

+ 註冊元素使用 createCustomElement 函數
依據已知範例，由於 Angular 建議使用 createCustomElement 函數登記，但此函數其中一個參數是需要 Injector 物件，這導致該函數必需在建構方法或任何可以取回相依注入物件的函數中執行；這也導致註冊行為無法被提取至 ```main.ts``` 中，替代啟動流程。

+ 避免重複註冊
由於 live-reload 會刻意重複執行，這導致初始會重複執行，未避免這類狀況發生，應於註冊前利用 ```customElements.get()``` 來檢查元件是否已經註冊

+ 避免啟動繪製流程導致元件未登記
依據 Angular 框架原則，當 JS 檔案匯入會依據 ```main.ts``` 中的啟動條件執行啟動流程並繪製，而這起始繪製的元件便是 NgModule 中的 bootstrap 設定，此外 standalone 元件則預設會被用於繪製；在多次實驗與測試後，確認若僅需要被啟動流程執行但無需繪製後執行，則註冊元件需在 ```app.module.ts``` 建構函數，此外移除 bootstrap。

+ 避免使用路由
由於 Web Component 設計應考慮僅為簡易元件，路由管理不應在此元件中處理。

+ 設定 ShadowDOM
為避免元件內容樣式渲染至外部，建議元件本身應設定為 ```ViewEncapsulation.ShadowDom```。
