//requiring path and fs modules
const path = require('path');
const fs = require('fs');
const glob = require("glob");

//joining path of directory
const distPath = path.join(__dirname, 'dist');
const contentPath = path.join(distPath, 'browser');
let afiles = {}
let aentrypoints = []

// retrieve entrypoints
// use output information from stats.json and check file exist or not.
if ( fs.existsSync(path.join(distPath, 'stats.json')) ) {
    const info = require("./dist/stats.json");
    for (const [key, value] of Object.entries(info)) {
        if ( key === "outputs" ) {
            Object.keys(value).map ( file => {
                  if (fs.existsSync(path.join(contentPath, file))) {
                      aentrypoints.push(file);
                  }
            });
        }
    }
}

// retrieve all file in publish directory
const files = glob.sync(path.join(contentPath, "/**/*"));
//listing all files using forEach
files.forEach(file => {
    if ( fs.lstatSync(file).isFile() ) {
        // Retrieve file name without hash
        let fpath = file.replace(contentPath + "/", "");
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
fs.writeFileSync( path.join(contentPath, "asset-manifest.json"), JSON.stringify(assets) );
