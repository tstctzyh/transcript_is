import Web3 from 'web3';

// const web3 = new Web3(window.web3.currentProvider)
let web3;
if(typeof window !== 'undefined' && typeof window.web3 !== 'undefined'){
    //metamask is running
    web3 = new Web3(window.web3.currentProvider)
}else{
    //on the browser or user not running metamask
    const provider = new Web3.providers.HttpProvider(
        'https://rinkeby.infura.io/v3/526a9724a50f49cda49d2e145024b857'
    )
    web3 = new Web3(provider)
}

export default web3