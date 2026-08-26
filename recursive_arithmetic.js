// Recursive Arithmetic Operations
function succ(n) {
    return n + 1;
}

function pred(n) {
    return n - 1;
}

// 10 + 5 = 11 + 4
//        = 12 + 3
//        = 13 + 2
//        = 14 + 1
//        = 15 + 0
function add(m, n) {
    if (n == 0) return m
    else return add(succ(m), pred(n));
}

// 10 - 5 = 9 - 4
//        = 8 - 3
//        = 7 - 2
//        = 6 - 1
//        = 5 - 0
function sub(m, n) {
    if (n == 0) return m
    else return sub(pred(m), pred(n));
}

// 4 * 3 = 4 + (4 + (4 + (4 * 0)))
function mult(m, n) {
    if (n == 0) return 0
    else return add(m, mult(m, pred(n)));
}
// 20 / 5 = ((15) / 5) + 1
//        = ((10 / 5) + 1) + 1
//        = (((5 / 5) + 1) + 1) + 1
//        = ((((0 / 5) + 1) + 1) + 1) + 1
//        = ((((0) + 1) + 1) + 1) + 1
function div(m, n) {
    if (n == 0) {
        console.log("Illegale")
    } else if (m < n) return 0
    else return succ(div(sub(m, n), n))
}

// Test
const a = 10;
const b = 5;
console.log("Somma: ", add(a, b));
console.log("Sottrazione:", sub(a, b));
console.log("Moltiplicazione:", mult(a, b));
console.log("Divisione:", div(a, b));
