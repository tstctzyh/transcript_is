import web3 from './web3'
import StudentFactory from './build/StudentFactory.json'

const instance = new web3.eth.Contract(
    JSON.parse(StudentFactory.interface),
    '0xe5d53Dd820fb27f4b59F2E32F30cde4fca9167E9'
)

export default instance