import web3 from './web3'
import Student from './build/Student.json'

export default (address)=>{
    return new web3.eth.Contract(
        JSON.parse(Student.interface),
        address
    )
}