import React,{Component} from 'react'
import {Link} from '../../routes'
import { Card,Icon, Label, Table,Button } from 'semantic-ui-react'
import Student from '../../ethereum/student'

class StudentShow extends Component{

    static async getInitialProps(props){
        const std_block = Student(props.query.address)

        const std_data = await std_block.methods.getStudent().call();
        const register_data = await std_block.methods.getMyScore().call();

        return {c_add:props.query.address,std_data:std_data[0],register_data:register_data}
    }

    render(){
        return (
        <div>
            <Card fluid={true}>
                <Card.Content header={'Student Address. '+this.props.std_data['student_address']} />
                <Card.Content header={"First Name : "+this.props.std_data['name']} />
                <Card.Content header={"Last Name : "+this.props.std_data['lastname']} />
            </Card>
            
            <h3>Course Register</h3>
            <Table celled>
                <Table.Header>
                    <Table.Row>
                        <Table.HeaderCell>Year</Table.HeaderCell>
                        <Table.HeaderCell>Semester</Table.HeaderCell>
                        <Table.HeaderCell>Course</Table.HeaderCell>
                        <Table.HeaderCell>Score</Table.HeaderCell>
                        <Table.HeaderCell>Grade</Table.HeaderCell>
                    </Table.Row>
                </Table.Header>

                <Table.Body>
                    {
                        this.props.register_data && this.props.register_data.length>0 && this.props.register_data.map((item,key)=>{
                            return (
                            <Table.Row key={"reigster_"+key}>
                                <Table.Cell>{item.year}</Table.Cell>
                                <Table.Cell>{item.semester}</Table.Cell>
                                <Table.Cell>{item.course_id}</Table.Cell>
                                <Table.Cell>{item.score}</Table.Cell>
                                <Table.Cell>{item.grade}</Table.Cell>
                            </Table.Row>
                            )
                        })
                    }
                    
                </Table.Body>
                <Table.Footer fullWidth>
                    <Table.Row>
                    <Table.HeaderCell />
                    <Table.HeaderCell colSpan="4">
                        <Link href={"/student/"+this.props.c_add+"/add_course"}>
                            <Button
                            floated="right"
                            icon
                            labelPosition="left"
                            secondary
                            size="small"
                            >
                            <Icon name="clipboard list" /> Add Course
                            </Button>
                        </Link>
                    </Table.HeaderCell>
                    </Table.Row>
                </Table.Footer>

            </Table>
        </div>
        )
    }
}

export default StudentShow