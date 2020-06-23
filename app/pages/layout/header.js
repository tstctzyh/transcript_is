import React, { Component } from "react";
import {Link,Router} from '../../routes'
import { Menu } from "semantic-ui-react";

class Header extends Component {
  state = {};

  handleItemClick = (e, { name }) => {
    this.setState({ activeItem: name })
    Router.push('/'+name)
  };
  render() {
    const { activeItem } = this.state;

    return (
      <Menu>
        <Link route="/">
          <a>
            <Menu.Item name="transcript_app">
              Transcript
            </Menu.Item>
          </a>
        </Link>
        <Menu.Item
          name="index"
          active={activeItem === "index"}
          onClick={this.handleItemClick}
        >
          Home
        </Menu.Item>
      </Menu>
    );
  }
}

export default Header;
