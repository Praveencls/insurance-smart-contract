## Ganache
Personal Ethereum Blockchain. (Local VM).

### Download & Install
Download: https://trufflesuite.com/ganache/

### Run Ganache
We can following these steps:
1. Open ganache, choose `Quickstart`. ![img](assets/ganache-launch.png)
2. We can see 10 address account simulator for each 100 eth. ![img](assets/ganache-account.png)
3. If we click on :key: `Key Button` We can see Account Information about the `Account Address` and `Private Key`. ![img](assets/ganache-account-info.png)
4. Here is importent configuration about workspacename, server hostname, port number, gas price, can watch here. ![img](assets/ganache-configuration.png)

## Metamask
A crypto wallet & gateway to blockchain apps.  We need to install metamask for our browser wallet. Chrome provides browser extension for this.

### Install browser extension and Register
choose `Metamask`. ![img](assets/metamask-browser-extension.png)

### Ganache connect to Metamask

After we running the Ganache. We can connect the network to the metamask.

Following these steps:
1. Open the Metamask. And Click on dropdown Network. ![img](assets/metamask-networks.png)
2. Choose `Add Network` and will redirect to these settings. ![img](assets/metamask-network-config.png)
3. Choose `Add a network manually` and will open these form network. ![img](assets/metamask-add-network-manually.png)
4. Input the network settings for `Ganache`, you can follow these input. ![img](assets/metamask-add-network-ganache.png)
   1.  Network Name: `Ganache`
   2.  New RPC URL: `HTTP://127.0.0.1:7545`
   3.  Chain ID: `1337`
   4.  Currency Symbol: `ETH`
5. Save, and we can see the Network Ganache already added. ![img](assets/metamask-network-ganache.png)

### Import Ganache Account to Metamask
We want to import the Ganache Account to metamask, we can follow these steps:
1. Open the account section, and choose `Import Account`. ![img](assets/metamask-import-account.png)
2. It will show the form import account. ![img](assets/metamask-form-account.png)
3. Copy the `Private Key` on Ganache before, then copy it to the metamask private key form. ![img](assets/ganache-account-info.png)
4. After that, click `Import` button. We will see the `Account Address` and `Balance` are same like as in `Ganache Account`. ![img](assets/metamask-ganache-account-imported.png) We can adding multiple accounts from Ganache to Metamask.

### Send ETH between Account
After We have 2 imported account. We can simulate to send ETH between account.

Follow these steps:
1. In metamask, Click on `Send`. Then it will redirect to form send. ![img](assets/metamask-send.png)
2. Fill the inputs with the different account address. It will be like this. ![img](assets/metamask-send-to-account-3.png)
3. Then we set the `Amount`, and click send. For example 5 ETH. It will redirect to `Confirmation Page`. ![img](assets/metamask-send-confirmation.png)
4. After we submit `Confirm`. We will redirect to `Transaction Queue Section`. ![img](assets/metamask-transaction-queue.png) 
5. After waiting for the pending, the transaction will be updated to History Section. ![img](assets/metamask-transaction-history.png)
6. Congratulations, we have successfully send the coin ! You can see also in Ganache Balance are updated. ![img](assets/ganache-after-transaction.png)

## Smart Contract Remix to Ganache

First, we need to create the smart contract.
```solidity
pragma solidity ^0.8.0;

contract JobPortal {
   
}
```

Step to deploy the contract:
1. Run the `Ganache` and choose `Quick Start`. Then we see the accounts ![img](assets/ganache-account.png)
2. Open Remix Browser, and select the localhost. ![img](assets/remix-local.png)
3. In Remix, open tab Deploy then choose Environment `External HTTP Provider`. ![img](assets/remix-external-http-provider.png)
4. Update the url & port to follow the Ganache `RPC Server`. Which in this case is `http://127.0.0.1:7545` ![img](assets/ganache-rpc-server.png)
5. After connected, we've got the same account in `remix account` and `ganache account`. ![img](assets/remix-account-same.png) ![img](assets/ganache-account-same.png)
6. In Remix, we `Deploy` the smart contract to some account. And we can see the contract. ![img](assets/remix-deployed.png)
7. In Ganache, we can see our contract in `Blocks` tab: ![img](assets/ganache-deployed-blocks.png) And in the `Transactions` tab: ![img](assets/ganache-deployed-transactions.png)
8. We can run all contracts here. : ![img](assets/Deployed-Contracts.png)
    Get properties: - Owner : ![img](assets/Owner.png)
                    - Policy Count : ![img](assets/PolicyCount.png)
                    - Policy detail by Id : ![img](assets/PolicyById.png)
    Functions -  AuthorizeInsurer : ![img](assets/AuthorizeInsurer.png)
              -  Issue Policy : ![img](assets/IssuePolicy.png)


