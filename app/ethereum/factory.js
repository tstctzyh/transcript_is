import web3 from './web3'
import StudentFactory from './build/StudentFactory.json'

const instance = new web3.eth.Contract(
    JSON.parse(StudentFactory.interface),
    '0xEAa97335231F324E5157f1AD3947E1bbeAD4fD13'
)

export default instance