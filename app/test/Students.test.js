const assert = require('assert')
const ganache = require('ganache-cli')
const Web3 = require('web3')
const web3 = new Web3(ganache.provider())

const compliedStudents=require('../ethereum/build/Student.json')

let accounts;
let students;

beforeEach(async ()=>{
    accounts = await web3.eth.getAccounts()
    students = await new web3.eth.Contract(JSON.parse(compliedStudents.interface))
        .deploy({data:compliedStudents.bytecode})
        .send({from:accounts[0],gas:'1000000'})

    await students.methods.addStudent('nick','supakorn').send({
        from:accounts[0],
        gas:'1000000'
    })

    await students.methods.
})