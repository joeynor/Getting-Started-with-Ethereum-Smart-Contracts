const SHA256 = require("crypto-js/sha256");

class Block {
    constructor(data, previousHash) {
    this.data = data;
    this.timestamp = Date.now(); 
    this.previousHash = previousHash;
    this.hash = this.getHash();
} 

getHash() {
    return SHA256(this.previousHash + this.timestamp + JSON.stringify(this.data)).toString();
    }
}

class Blockchain { 
    constructor() {
        this.blockchain = [new Block("Genesis Block", '')]; 
    }
    getLastBlock() {
        return this.blockchain[this.blockchain.length-1];
    }   
    createBlock(data) {
        this.blockchain.push(new Block(data, this.getLastBlock().hash));
    }
    isBlockchainValid() {
        for (let i=1; i<this.blockchain.length; i++) {
            let currentBlock = this.blockchain[i]; 
            let previousBlock = this.blockchain[i-1];
            if ((currentBlock.previousHash !== previousBlock.hash) || (currentBlock.hash !== currentBlock.getHash())) 
            { 
                return false;
            } 
        }
        return true; }
    }

myChain = new Blockchain();
console.log('\n-----\nNew blockchain created'); 
console.log(myChain);

myChain.createBlock("first initial 100 usd"); 
console.log('\n-----\nAdded 1st block'); 
console.log(myChain);

myChain.createBlock("my second 200 usd");
console.log('\n-----\nAdded 2nd block'); 
console.log(myChain);

console.log('Is the chain valid: ' + myChain.isBlockchainValid());

myChain.blockchain[1].data = "my bogus";
myChain.blockchain[1].hash = myChain.blockchain[1].getHash();
myChain.blockchain[2].previousHash = myChain.blockchain[1].hash;
myChain.blockchain[2].hash = myChain.blockchain[2].getHash();
console.log(myChain);


console.log('Is the chain valid: ' + myChain.isBlockchainValid());

