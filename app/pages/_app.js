import React from "react";
import { Container } from "semantic-ui-react";
import Header from "./layout/header";
import "semantic-ui-css/semantic.min.css";

export default function MyApp({ Component, pageProps }) {
  return (
    <Container>
      <Header />
      <Component {...pageProps} />
      <h1>Footer</h1>
    </Container>
  );
}
