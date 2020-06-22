import React, { Component } from "react";
import { Menu } from "semantic-ui-react";

class Header extends Component {
  state = {};

  handleItemClick = (e, { name }) => this.setState({ activeItem: name });
  render() {
    const { activeItem } = this.state;

    return (
      <Menu>
        <Menu.Item name="transcript_app">Transcript</Menu.Item>
        <Menu.Item
          name="home"
          active={activeItem === "home"}
          onClick={this.handleItemClick}
        >
          Home
        </Menu.Item>
      </Menu>
    );
  }
}

export default Header;
