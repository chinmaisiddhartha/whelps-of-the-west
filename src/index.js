import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import { MoralisProvider } from "react-moralis";

ReactDOM.render(
  <React.StrictMode>
    <MoralisProvider serverUrl="https://xbcuskvil9fl.usemoralis.com:2053/server" appId="hLfjcZIEZQMH8RO0OUyLQHuFaAwft21cDuGlKhE8">
      <App />
    </MoralisProvider>
  </React.StrictMode>,
  document.getElementById("root")
);