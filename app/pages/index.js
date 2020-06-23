import React, { Component } from "react";
import {Link} from '../routes'
import factory from "../ethereum/factory";
import { Button, Icon, Table } from "semantic-ui-react";

class StudentIndex extends Component {
  static async getInitialProps() {
    const students = await factory.methods.getStudent().call();
    return { students };
  }

  render() {
    console.log(this.props.students);
    return (
      <div>
        <h3>Student List</h3>
        <Table compact celled>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell>Address</Table.HeaderCell>
              <Table.HeaderCell>Name</Table.HeaderCell>
              <Table.HeaderCell>Last Name</Table.HeaderCell>
              <Table.HeaderCell>View</Table.HeaderCell>
            </Table.Row>
          </Table.Header>

          <Table.Body>
            {this.props.students &&
              this.props.students.length > 0 &&
              this.props.students.map((item, key) => {
                // console.log("item",item);
                return (
                  <Table.Row key={"student_"+key}>
                    <Table.Cell>{item}</Table.Cell>
                    <Table.Cell>September 14, 2013</Table.Cell>
                    <Table.Cell>jhlilk22@yahoo.com</Table.Cell>
                    <Table.Cell>
                      <Button.Group basic size='small'>
                        <Link route={`/student/${item}`}>
                          <a><Button icon='eye' /></a>
                        </Link>
                       
                      </Button.Group>
                    </Table.Cell>
                  </Table.Row>
                );
              })}
          </Table.Body>

          <Table.Footer fullWidth>
            <Table.Row>
              <Table.HeaderCell />
              <Table.HeaderCell colSpan="4">
                <Link href="/student/create">
                <Button
                  floated="right"
                  icon
                  labelPosition="left"
                  primary
                  size="small"
                >
                  <Icon name="user" /> Add Student
                </Button>
                </Link>
              </Table.HeaderCell>
            </Table.Row>
          </Table.Footer>
        </Table>
      </div>
    );
  }
}

export default StudentIndex;
