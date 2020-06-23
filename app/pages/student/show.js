import React,{Component} from 'react'
import Student from '../../ethereum/student'

class StudentShow extends Component{

    static async getInitialProps(props){
        // console.log(props.query.address)
        const std_block = Student(props.query.address)

        const std_data = await std_block.methods.getStudent().call();
        
        return {std_data:std_data[0]}
    }

    render(){
        return (
        <div>
            <h3>Name : {this.props.std_data['name']}</h3>
            <h3>LastName : {this.props.std_data['lastname']}</h3>
        </div>
        )
    }
}

export default StudentShow