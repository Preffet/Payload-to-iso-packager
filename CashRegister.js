function checkCashRegister(price, cash, cid) {
//calculate the change
let neededChange = (cash - price).toFixed(2);
let change = [];
//create a copy of the array
let cidCopy = cid.slice(0);
//map the bills to their values
let moneyArr = [
["PENNY", 0.01],
["NICKEL", 0.05],
["DIME", 0.10],
["QUARTER", 0.25],
["ONE", 1],
["FIVE", 5],
["TEN", 10],
["TWENTY", 20],
["ONE HUNDRED", 100]
];
//iterate through an array without reversing it
for(let i = 8; i >= 0; i--) {
let j = 0;
let k = cid[i][1];
    for(neededChange; neededChange >= moneyArr[i][1] && k > 0; neededChange = (neededChange - moneyArr[i][1]).toFixed(2)) {
        j++;
        change[i] = [moneyArr[i][0], Number((moneyArr[i][1] * j).toFixed(2))]; 
        cid[i] = [cid[i][0], (cid[i][1] - moneyArr[i][1]).toFixed(2)]; //decement cash in the drawer
        k -= moneyArr[i][1];
    }
}
//reverse the array, clean up null and empty values
change = (change.filter(function(x) { return x })).reverse();
//check if all the change was given, check if
//status should be open or closed
if(neededChange == 0) { 
for(let l = 0; l < cid.length; l++) {
    if(cid[l][1] > 0) { //if any cash is left in drawer, return OPEN
        return(({status: "OPEN", change: change}));}
    else if(cid[l][1] == 0 && l == cid.length -1) { //if cash in drawer is stil at 0 return CLOSED
        return(({status: "CLOSED", change: cidCopy}))
    }}}
    else{return(({status: "INSUFFICIENT_FUNDS", change: []}));}}

checkCashRegister(19.5, 20, [["PENNY", 1.01], ["NICKEL", 2.00], ["DIME", 3.10], ["QUARTER", 4.00], ["ONE", 30], ["FIVE", 15], ["TEN", 50], ["TWENTY", 60], ["ONE HUNDRED", 100]]);