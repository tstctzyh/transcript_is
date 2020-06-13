const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

const buildPath=path.resolve(__dirname,'build');
fs.removeSync(buildPath);

const studentPath = path.resolve(__dirname,'contracts','Students.sol')
const source = fs.readFileSync(studentPath,'utf8')
const output = solc.compile(source,1).contracts
// fs.outputJsonSync(
//   path.resolve(buildPath,'Students.json'),
//   output
// )
fs.ensureDirSync(buildPath)
for (let contract in output){
  // console.log(contract)
  fs.outputJsonSync(
    path.resolve(buildPath,contract.replace(':','')+'.json'),
    output[contract]
  )
}
