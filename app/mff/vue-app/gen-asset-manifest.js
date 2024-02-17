//requiring path and fs modules
const path = require('path');
const fs = require('fs');
const glob = require("glob");

//joining path of directory
const distPath = path.join(__dirname, 'dist');
const vitePath = path.join(distPath, '.vite');
let afiles = {}
let aentrypoints = []

// retrieve entrypoints
// use output information from stats.json and check file exist or not.
if ( fs.existsSync(path.join(vitePath, 'manifest.json')) ) {
    const info = require(path.join(vitePath, 'manifest.json'));
    for (const [key, value] of Object.entries(info)) {
        if ( key === "index.html" ) {
            if ( value["file"] !== undefined ) {
                aentrypoints.push(value["file"]);
            }
            if ( value["css"] !== undefined ) {
                aentrypoints.push(value["css"]);
            }
        }
    }
}

// retrieve all file in publish directory
const files = glob.sync(path.join(distPath, "/**/*"));
//listing all files using forEach
files.forEach(file => {
    if ( fs.lstatSync(file).isFile() ) {
        // Retrieve file name without hash
        let fpath = file.replace(distPath + "/", "");
        let name = fpath.replace(/-[^-]*\./g, ".");
        if ( name.endsWith('.js') || name.endsWith('.css' ) ) {
            name = name.replace(/.*\//g, "");
        }
        afiles[name]=fpath;
    }
});

// Write all asset-manifest.json
const assets = {
    files: afiles,
    entrypoints: aentrypoints
}
fs.writeFileSync( path.join(distPath, "asset-manifest.json"), JSON.stringify(assets) );
