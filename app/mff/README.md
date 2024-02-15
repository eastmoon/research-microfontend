## 建立前端框架專案

### React

使用 [create-react-app](https://github.com/facebook/create-react-app) 工具來建立專案

+ 安裝 ```npm install -g create-react-app```
+ 使用 ```npx create-react-app react-app``` 建立專案 react-app
+ 進入 react-app 專案，執行 ```npm run start``` 啟動開發伺服器
+ 進入 react-app 專案，執行 ```npm run build``` 編譯專案

### Vue

使用 [create-vue](https://vuejs.org/guide/quick-start.html#creating-a-vue-application) 工具來建立專案

+ 安裝 ```npm install -g create-vue```
+ 使用 ```npx create-vue vue-app``` 建立專案 vue-app
+ 進入 vue-app 專案，執行 ```npm run dev``` 啟動開發伺服器
+ 進入 vue-app 專案，執行 ```npm run build``` 編譯專案

修復對應容器的開發伺服器異常：

+ 使用 ```server.host: true``` 修復指定接受全域名
+ 使用 ```server.watch: { usePolling: true }``` 修復容器目錄監測異常，改為輪詢監測
+ 參考文獻
    - [Server Options](https://vitejs.dev/config/server-options.html)

詳細設定參考 [vite.config.js](./vue-app/vite.config.js)

### Angular

使用 [angular/cli](https://angular.io/cli) 工具來建立專案

+ 安裝 ```npm install -g @angular/cli```
+ 使用 ```ng new angular-app --skip-git --skip-install --routing --style=scss --interactive=false``` 建立專案 angular-app
+ 進入 angular-app 專案，執行 ```npm run start -- --host 0.0.0.0``` 啟動開發伺服器
+ 進入 angular-app 專案，執行 ```npm run build``` 編譯專案

其他詳細運用可參考 [Angular command line interface](https://github.com/eastmoon/tutorial-js-angular/blob/main/repo/readme.md)
