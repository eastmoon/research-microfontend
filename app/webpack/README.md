## Webpack 專案簡介

## 安裝 pnpm 套件管理工具

使用 ```npm install -g pnpm``` 指令安裝該套件，此套件會用於初始化 Webpack 專案
## 安裝 Webpack

+ [Installation - Webpack](https://webpack.js.org/api/node/#installation)
+ [package.json - node.js](https://docs.npmjs.com/cli/v10/configuring-npm/package-json)

使用 ```npm install --save-dev webpack``` 指令，下載 webpack 套件並建置 ```package.json```檔案；若有需要可以修改部分 ```package.json``` 檔案以符合設計需要。

## 建立配置檔案

+ [Configuration - Webpacck](https://webpack.js.org/configuration/)

若要初始化服務與模組，使用 ```npx webpack init``` 來選擇需要的內容；本範例選擇如下：

+ 使用 webpack-cli
+ 使用 webpack-cli/generators
+ 使用 es6
+ 使用 webpack-dev-server
+ 使用建立對應 bundle 的 HTML 檔案
+ 不使用 PWA 支援
+ 使用 CSS loader
+ 不使用 PostCSS
+ 所有狀態都會輸出 CSS 獨立檔案
+ 使用 prettier 工具
+ 使用 pnpm

系統會建立一個 ```webpack.config.js``` 檔案於 ```package.json``` 所在目錄，此檔案是 webpack 預設使用的配置檔。

倘若要修改名稱，例如 ```prod.config.js```，對應的編譯指令需改為 ```webpack --config prod.config.js```。

## 開發伺服器

使用 ```npm run serve``` 啟動開發伺服器，讓開發中有任何程式異動皆會自動再編譯，並依據設定的連結埠導出內容，詳細設定參考 [devServer - Webpack](https://webpack.js.org/configuration/dev-server/)。

考量容器使用需要，需在 ```webpack.config.js``` 修改 devServer 如下內容，以此確保所有來源 IP 皆可讓伺服器處理，並對應正確的容器連結埠口，讓 live-reload 可正常運作。

```
devServer: {
    host: '0.0.0.0',
    port: 8082
},
```

為開啟 live-reload 則請基於要監控的檔案進行相關設定。

```
devServer: {
    watchFiles: ['src/**/*.js', 'src/**/*.html'],
    liveReload: true,
},
```

此外，由於容器特性，對基於 inode 的檔案監測會出現異常，對於監控選項需額外添加設定，詳細設定參考 [watchOptions - Webpack](https://webpack.js.org/configuration/watch/#watchoptions)。

```
module.exports = {
  watchOptions: {
    aggregateTimeout: 500,
    poll: 1000,
  },
}
```

## 編譯專案

使用 ```npm run build``` 編譯專案內容，相關編譯設定會根據 ```webpack.config.js``` 改變，預設匯出目錄為 dist。
