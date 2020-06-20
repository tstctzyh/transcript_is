const assert = require('assert')
const ganache = require('ganache-cli')
const Web3 = require('web3')

const provider = ganache.provider({gasLimit:6000000});
const web3 = new Web3(provider)

const compliedStudentFactory=require('../ethereum/build/StudentFactory.json')
const compliedStudents=require('../ethereum/build/Student.json')

let accounts;
let factory;
let studentAddress;
let student;

beforeEach(async ()=>{
    accounts = await web3.eth.getAccounts()
    factory = await new web3.eth.Contract(JSON.parse(compliedStudentFactory.interface))
        .deploy({data:compliedStudentFactory.bytecode,arguments:['Hi there!']})
        .send({from:accounts[0],gas:'6000000'})
        factory.setProvider(provider);
        
    await factory.methods.createStudent('nick','supakorn').send({
        from:accounts[0],
        gas:'6000000'
    })

    const addresses = await factory.methods.getStudent().call()
    studentAddress = addresses[0]
    student = await new web3.eth.Contract(
        JSON.parse(compliedStudents.interface),
        studentAddress
    )
})

describe('Students',()=>{
    it('deploy a factory and a student',()=>{
        assert.ok(factory.options.address);
        assert.ok(student.options.address);
    })

    it('marks caller as owner students',async ()=>{
        const me_student = await student.methods.getStudent().call()
        assert.equal(accounts[0],me_student[0]['student_address'])
    })

    it('allow student to register course',async ()=>{
        await student.methods.registerScore(2020,1,'CI8001',80,'A').send({
            from:accounts[0],
            gas:'6000000'
        })

        const my_score=await student.methods.getMyScore().call()
    })

    it('Show All Student',async ()=>{
        const all_students = await factory.methods.getStudent().call()
        // console.log(all_students)

        let std_address = all_students[0]
        let student_data = await new web3.eth.Contract(
            JSON.parse(compliedStudents.interface),
            std_address
        )
        const student_call = await student_data.methods.getStudent().call()
        console.log(student_call)
    })
})