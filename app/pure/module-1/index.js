// Declare function

function show() {
    console.log( "Show M1.")
}

function add(p1, p2) {
    let ans = p1 + p2
    console.log( "M1 : " + ans )
}

// Export
const o = {
    show,
    add
}
window.m1 = o;
