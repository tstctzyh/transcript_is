import React, { Component } from "react";
import factory from "../ethereum/factory";
import { Button, Checkbox, Icon, Table } from "semantic-ui-react";
// import "semantic-ui-css/semantic.min.css";

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
            </Table.Row>
          </Table.Header>

          <Table.Body>
            {this.props.students &&
              this.props.students.length > 0 &&
              this.props.students.map((key, item) => {
                console.log(item);
                return (
                  <Table.Row>
                    <Table.Cell>John Lilki</Table.Cell>
                    <Table.Cell>September 14, 2013</Table.Cell>
                    <Table.Cell>jhlilk22@yahoo.com</Table.Cell>
                  </Table.Row>
                );
              })}
          </Table.Body>

          <Table.Footer fullWidth>
            <Table.Row>
              <Table.HeaderCell />
              <Table.HeaderCell colSpan="4">
                <Button
                  floated="right"
                  icon
                  labelPosition="left"
                  primary
                  size="small"
                >
                  <Icon name="user" /> Add Student
                </Button>
              </Table.HeaderCell>
            </Table.Row>
          </Table.Footer>
        </Table>
      </div>
    );
  }
}

export default StudentIndex;
