import React,{Component} from 'react';
import factory from '../ethereum/factory'

class StudentIndex extends Component{
  async componentDidMount(){
    const students = await factory.methods.getStudent().call()
    console.log(students)
  }

  render(){
    return <div>Welcome to Next.js!</div>
  }
}
  
export default StudentIndex