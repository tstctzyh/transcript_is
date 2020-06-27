import React, { Component } from "react"
import factory from "../../ethereum/factory"
import web3 from "../../ethereum/web3"
import { Button, Form,Message,Dropdown } from 'semantic-ui-react'
import Student from '../../ethereum/student'
import {Router} from '../../routes'

class AddCourse extends Component {

    static async getInitialProps(props){
        const std_block = Student(props.query.address)
        const std_data = await std_block.methods.getStudent().call();

        return {c_add:props.query.address,std_block:std_block,std_data:std_data[0]}
    }

    constructor(props) {
        super(props);
        this.state = {
            year: "",
            semester:1,
            course_id:"",
            score:"",
            grade:"",
            errorMessage:"",
            loading:false,
        };
        
      }

    handleChange = (input,e)=>{
        this.setState({[input]:e.target.value})
    }

    handleChangeDropdown = (input,data)=>{
        this.setState({[input]:data.value})
    }

    handleSubmitCourse = async ()=>{
        // // if(this.state.firstname!="" && this.state.lastname!=""){
            this.setState({loading:true,errorMessage:''})
            try{
                const accounts = await web3.eth.getAccounts();
                const addscore =await Student(this.props.c_add).methods.registerScore(this.state.year,this.state.semester,this.state.course_id,this.state.score,this.state.grade).send({
                    from:accounts[0]
                });
                // console.log(addstd)
                Router.pushRoute('/student/'+this.props.c_add)
            } catch(err) {
                this.setState({errorMessage:err.message})
            }
            
            this.setState({loading:false})
        // }
    }

    yearDropdown = ()=>{
        var date_set = []
        for (var i=new Date().getFullYear(); i>2000;i--){
            var date_list = {
                key:i,
                text:i,
                value:i
            }
            date_set.push(date_list)
        }

        return date_set
    }

    

    render(){
        return (
            <div>
                <h3>{this.props.std_data[1]} {this.props.std_data[2]} : Add Course</h3>
                <Message error header="Something went wrong!" content={this.state.errorMessage} hidden={this.state.errorMessage!="" ? false : true} />
                    
                <Form>
                    <Form.Field>
                    <label>year</label>
                    {/* <input onChange={(e)=>this.handleChange("year",e)} value={this.state.year} placeholder='Year' /> */}
                    <Dropdown
                        placeholder='Select Year'
                        fluid
                        selection
                        options={this.yearDropdown()}
                        onChange={(e,data)=>this.handleChangeDropdown("year",data)}
                        value={this.state.year}
                    />
                    </Form.Field>
                    <Form.Field>
                    <label>Semester</label>
                    <input type="number" min="1" max="4" maxLength="1"  onChange={(e)=>this.handleChange("semester",e)} value={this.state.semester} placeholder='Semester' />
                    </Form.Field>
                    <Form.Field>
                    <label>Course ID</label>
                    <input onChange={(e)=>this.handleChange("course_id",e)} value={this.state.course_id} placeholder='Course ID' />
                    </Form.Field>
                    <Form.Field>
                    <label>Score</label>
                    <input type="number" onChange={(e)=>this.handleChange("score",e)} value={this.state.score} placeholder='Score' />
                    </Form.Field>
                    <Form.Field>
                    <label>Grade</label>
                    <input onChange={(e)=>this.handleChange("grade",e)} value={this.state.grade} placeholder='Grade' />
                    </Form.Field>
                    <Button primary loading={this.state.loading} type='button' onClick={()=>this.handleSubmitCourse()}>Submit</Button>
                </Form>
            </div>
        )
    }
}

export default AddCourse