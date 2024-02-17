console.log("Hello World!");

function loadJSON(filename, callback) {
    var xobj = new XMLHttpRequest();
    xobj.overrideMimeType("application/json");
    xobj.open('GET', filename, true);
    xobj.onreadystatechange = function () {
          if (xobj.readyState == 4 && xobj.status == "200") {
            // Required use of an anonymous callback as .open will NOT return a value but simply returns undefined in asynchronous mode
            callback(xobj.responseText);
          }
    };
    xobj.send(null);
}

function webcom(path) {
    let root = document.querySelector("head");
    loadJSON(`${path}/asset-manifest.json`, ( restext ) => {
        var res = JSON.parse(restext)
        if ( res["entrypoints"] !== undefined ) {
            res["entrypoints"].forEach((item, i) => {
                if ( item.endsWith(".js") ) {
                    console.log(`insert: <script src=${path}/${item} type='module'></script>`)
                    let elm = document.createElement("script");
                    elm.src = `${path}/${item}`;
                    elm.type = 'module';
                    root.appendChild(elm);
                }
                if ( item.endsWith(".css") ) {
                    console.log(`insert: <link href="${path}/${item}" rel="stylesheet">`)
                    let elm = document.createElement("link");
                    elm.href = `${path}/${item}`;
                    elm.rel = 'stylesheet';
                    root.appendChild(elm);

                }
            });
        }
    })
}

webcom('./assets/vue-app');
webcom('./assets/react-app');
webcom('./assets/angular-app');
