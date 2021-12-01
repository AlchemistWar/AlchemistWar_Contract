import React from "react";
import ReactDOM from "react-dom";
//import App from "./App";
import App from './components/app.jsx';
import { MoralisProvider } from "react-moralis";
import "./index.css";
import QuickStart from "components/QuickStart";
import { MoralisDappProvider } from "./providers/MoralisDappProvider/MoralisDappProvider";
import store from './store';
import { Provider } from 'react-redux'
import "./assets/animated.css";
import '../node_modules/font-awesome/css/font-awesome.min.css'; 
import '../node_modules/elegant-icons/style.css';
import '../node_modules/et-line/style.css';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import '../node_modules/bootstrap/dist/js/bootstrap.js';
import './assets/style.scss';
import * as serviceWorker from './serviceWorker';
require('dotenv').config()

/** Get your free Moralis Account https://moralis.io/ */

const APP_ID = process.env.REACT_APP_MORALIS_APPLICATION_ID;
const SERVER_URL = process.env.REACT_APP_MORALIS_SERVER_URL;





const Application = () => {
  const isServerInfo = APP_ID && SERVER_URL ? true : false;
  if (isServerInfo)
    return (
      <MoralisProvider appId={APP_ID} serverUrl={SERVER_URL}>
        <MoralisDappProvider>
          <App isServerInfo/>
        </MoralisDappProvider>
      </MoralisProvider>
    );
  else {
    return (
      <div style={{ display: "flex", justifyContent: "center" }}>
		      <App isServerInfo />
      </div>
    );
  }
};

/* ReactDOM.render(
  // <React.StrictMode>
  <Application />,
  // </React.StrictMode>,
  document.getElementById("root")
); */
ReactDOM.render(
	<Provider store={store}>
		<Application />
	</Provider>, 
	document.getElementById('root'));
serviceWorker.unregister();