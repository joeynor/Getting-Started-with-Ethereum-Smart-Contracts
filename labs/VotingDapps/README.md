Note: there is a problem with node 17, uninstall and install node14
Installing ganache-cli is optional, you can also install ganache-ui which is the GUI version of ganache-cli. 
Go to https://trufflesuite.com/ganache/ to download a copy and install and run quick start. 
If you use ganache with the GUI version, you dont have to install and run ganache-cli.

# Getting started with ganache-cli

1. open your powershell terminal as administrator mode in windows or any shell in Linux/MAC
2. run the command below to install ganache-cli solc and web3, if you are running ganache as a desktop application, do not include ganache-cli

```
npm install ganache-cli solc web3

## example for installing without ganache on global
npm install solc web3 

## example for installing without ganache on local
npm install --local solc web3 

```

3. after installation, run the ganache cli or ganache desktop app
If ur using windows and ganache command line:

```
.\node_modules\.bin\ganache-cli.cmd
```
or some Unix/Posix terminal:

```
./node_modules/.bin/ganache-cli
```

4. You should be seeing the following an output that is similar to the one below

```
Ganache CLI v6.12.2 (ganache-core: 2.13.2)
eth_accounts
net_version

Available Accounts
==================
(0) 0x4c46D4827484fB4E21903Dd11BAeD2a4486732C4 (100 ETH)
(1) 0xCAE58B0163dE4d76AdA2C4DC1Ab57FBFDbA3fecE (100 ETH)
(2) 0xae029D0CFB0114136947a8D4E1917A7A0b984050 (100 ETH)
(3) 0x3CBF6a650A6346301CA6E802FC7c84F3ee9526D2 (100 ETH)
(4) 0x87451487cFA56360ead1Fc92E421263fE2e3fa51 (100 ETH)
(5) 0xb67cE109bB719efE7497Af80686eDcADb55cF797 (100 ETH)
(6) 0xDa8884ab49DdDBC3117dB37857471BF967e3b94B (100 ETH)
(7) 0x5b65FbaEFcc5861014cDaEA9C88A19160eea6083 (100 ETH)
(8) 0xc7A631969821b47e1140053B594A841E4Eb0ee7F (100 ETH)
(9) 0x020BfC0856a7404624859837F10e5dE718F8D920 (100 ETH)

Private Keys
==================
(0) 0xf48323b642f84e3deb218ec722150754974465787a8b06344a433f971baf29c3
(1) 0x04fa8cd7983a7b4c4d7118a2c436688248f3fe6496aabbda203641aa78809e22
(2) 0xb7a27be5f5f098c98649eb42cdfe4ff9a4bf7dbd62a0d4aeabb712ef38967aa0
(3) 0x063474804698fa08a72eb2b1e8ab9189ac736a17150b27e3934a7e5dec834add
(4) 0xb3f60c8bb04e2156e1b9510468516cc043d0d4d9fedac01284e1b25794ffd8a9
(5) 0xd64f781d147c5fdfd5bb5463f5c2a8be099c5b7932789da7a82c4ab4cd9d0855
(6) 0x0dfc655e225b43e442f208e9aabf2b3e1c26a2c2987ae5cc2b6a91852e3c1a99
(7) 0x2429d205b49ac5b309703a7634eede16bc9977a045aaa4f24cf8b8ae92dcbc09
(8) 0x1896851371866220676bfa93222fedcb34ed55a8efdd9763b9375d3a3189e748
(9) 0x91bbdf581ca49a945b048df7a6c04c8e9205cf10d38fb60fb3478cea63ec6fa0

HD Wallet
==================
Mnemonic:      post burden lesson mercy misery pioneer glove final concert check anger ski
Base HD Path:  m/44'/60'/0'/0/{account_index}

Gas Price8545
==================
20000000000

Gas Limit
==================
6721975

Call Gas Limit
==================
9007199254740991

Listening on 127.0.0.1:8545
```

**take note that this is a server now running blockchain and listening on port 8545 of your local machine**

# Connecting Remix

1. Open the https://remix.ethereum.org
2. Click on the **DEPLOY & RUN TRANSACTIONS** icon
3. Then choose **Web 3 Provider**
4. You should see all the addresses and wallet address balances being updated on remix, and your server responding to these requests
5. Technically now, you can deploy any smart contract on your own private ganache blockchain

# Compiling the Voting Contract

1. compile contract, get the Voting.sol from this repository
2. use the command 

for windows:

```
.\node_modules\.bin\solcjs.cmd --abi --bin Voting.sol
```

for linux/mac:

```
./node_modules/.bin/solcjs --abi --bin Voting.sol
```

3. Run node, with the command below to enter node shell

```
node
```

4. enter these commands in node

Loading the compiled bytecode and abi file into node, 
```
bytecode = fs.readFileSync('./Voting_sol_Voting.bin').toString()

abi = JSON.parse(fs.readFileSync('./Voting_sol_Voting.abi').toString())
```
Importing the Web3 library and creating an instance 
```
Web3 = require('web3')

web3 = new Web3("http://localhost:8545")
```

Preparing the deployed contract handler

```
deployedContract = new web3.eth.Contract(abi)
```

Checking what accounts we can use to deploy
```
web3.eth.getAccounts(console.log) 
```
*the command above should return a list of 10 wallet addresses*

Creating a list of candidates
```
listOfCandidates = ['Rama', 'Nick', 'Jose']
```

5. Deploying the smart contract on the blockchain

Make sure to change the from wallet address to one of your wallet address
```
deployedContract.deploy({
data: bytecode,
arguments: [listOfCandidates.map(name => web3.utils.asciiToHex(name))]
}).send({
from: '0x6959738B6e787F6F13353D8e47357FB71e36C7E5',
gas: 1500000,
gasPrice: web3.utils.toWei('0.00003', 'ether')
}).then((newContractInstance) => {
try {
	deployedContract.options.address = newContractInstance.options.address
	console.log(newContractInstance.options.address)
	} catch(err) {
		next(err);
}
})
```
The command above, if successful, should return the contract address

Issue this command if you forget your contract address
```
deployedContract.options.address
```

# Interacting with your deployed contract

To interact with your contract, you can use the contract handler to call methods in the contract, lets call the **totalVotesFor** method
```
deployedContract.methods.totalVotesFor(web3.utils.asciiToHex('Rama')).call().then((count) => console.log(count))
```
The command above should output the total votes received so far for the candidate 'Rama' as shown below. 
```
Output
Promise { <pending> }
> 0
```
Time to vote for a candidate, run the command below, but make sure you change the from address to a valid wallet adderss
```
deployedContract.methods.voteForCandidate(web3.utils.asciiToHex('Rama')).send({from: '0xE7D1Fb6c79d51372eCB69A16BDFb19820C568100'}).then((f) => console.log(f))
``` 
Now check again how many votes you have for Rama or others you have voted for

# Running it on the browser as a dApp

1. You will need 2 files, get index.html and index.js from this repository
2. Edit the index.js to change the contract address and the abi file 
3. Once done, open index.html on the browser

Congratulations, you have just build you own decentralized app

**note if you are trying to deploy the contract on remix, it requires an input during deployment. This is because the constructor expects and array of bytes32. Make sure to change input to hex and pad it with 0s to cater for that..
