const HDWalletProvider = require('truffle-hdwallet-provider')
const Web3 = require('web3')
// const {interface,bytecode} = require('./compile')
const compileFactory = require('./build/StudentFactory.json')

const provider = new HDWalletProvider(
  'quantum forget mimic diagram side garden cheap hope park tag viable angry',
  'https://rinkeby.infura.io/v3/526a9724a50f49cda49d2e145024b857'
)

const web3=new Web3(provider)

const deploy = async ()=>{
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account', accounts[0])

  const result = await new web3.eth.Contract(JSON.parse(compileFactory.interface))
        .deploy({data:'0x'+compileFactory.bytecode})
        .send({from:accounts[0],gas:'6000000'});

      console.log('Contract deployed to ',result.options.address);
};
deploy();
