import React, { Component } from "react"
import factory from "../../ethereum/factory"
import web3 from "../../ethereum/web3"
import { Button, Form,Message } from 'semantic-ui-react'
import {Router} from '../../routes'

class CreateStudent extends Component {
    
    constructor(props) {
        super(props);
        this.state = {
            firstname: "",
            lastname:"",
            errorMessage:"",
            loading:false,
        };
        
      }

    handleChange = (input,e)=>{
        this.setState({[input]:e.target.value})
    }

    handleSubmitStudent = async ()=>{
        if(this.state.firstname!="" && this.state.lastname!=""){
            this.setState({loading:true,errorMessage:''})

            try{
                const accounts = await web3.eth.getAccounts();
                const addstd =await factory.methods.createStudent(this.state.firstname,this.state.lastname).send({
                    from:accounts[0]
                });
                Router.pushRoute('/')
            } catch(err) {
                this.setState({errorMessage:err.message})
            }
            
            this.setState({loading:false})
        }
    }

    render(){
        return (
            <div>
                <h3>Add Student</h3>
                <Message error header="Something went wrong!" content={this.state.errorMessage} hidden={this.state.errorMessage!="" ? false : true} />
                    
                <Form>
                    <Form.Field>
                    <label>First Name</label>
                    <input onChange={(e)=>this.handleChange("firstname",e)} value={this.state.firstname} placeholder='First Name' />
                    </Form.Field>
                    <Form.Field>
                    <label>Last Name</label>
                    <input onChange={(e)=>this.handleChange("lastname",e)} value={this.state.lastname} placeholder='Last Name' />
                    </Form.Field>
                    <Button primary loading={this.state.loading} type='button' onClick={()=>this.handleSubmitStudent()}>Submit</Button>
                </Form>
            </div>
        )
    }
}

export default CreateStudent