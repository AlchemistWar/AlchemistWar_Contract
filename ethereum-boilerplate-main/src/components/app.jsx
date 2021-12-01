import { useEffect } from "react";
import { useMoralis } from "react-moralis";
import { Router, Location, Redirect } from '@reach/router';
import React from 'react';
/* import { BrowserRouter as Router, Switch, Route, Redirect } from "react-router-dom";
import Account from "components/Account";
import Chains from "components/Chains";
import TokenPrice from "components/TokenPrice";
import ERC20Balance from "components/ERC20Balance";
import ERC20Transfers from "components/ERC20Transfers";
import InchDex from "components/InchDex";
import NFTBalance from "components/NFTBalance";
import Wallet from "components/Wallet"; */
import { Layout, Tabs } from "antd";
import "antd/dist/antd.css";
/* import NativeBalance from "components/NativeBalance"; */
/* import "./style.css"; */
/* import QuickStart from "components/QuickStart";
import Contract from "components/Contract/Contract";
import Text from "antd/lib/typography/Text";
import Ramper from "components/Ramper";
import MenuItems from "./components/MenuItems"; */
import Home2 from './pages/home2';
import Wallet from './pages/wallet';
import Key from './pages/key';
import Gacha from "./pages/Gacha";
import ScrollToTopBtn from './menu/ScrollToTop';

import { createGlobalStyle } from 'styled-components';
import Header from './menu/header'; 
const GlobalStyles = createGlobalStyle`
  :root {
    scroll-behavior: unset;
  }
`;
const { Footer } = Layout;



export const ScrollTop = ({ children, location }) => {
  React.useEffect(() => window.scrollTo(0,0), [location])
  return children
}

const PosedRouter = ({ children }) => (
  <Location>
    {({ location }) => (
      <div id='routerhang'>
        <div key={location.key}>
          <Router location={location}>
            {children}
          </Router>
        </div>
      </div>
    )}
  </Location>
);




const App = ({ isServerInfo }) => {
    const { isWeb3Enabled, enableWeb3, isAuthenticated, isWeb3EnableLoading } = useMoralis();
  
    useEffect(() => {
      if (isAuthenticated && !isWeb3Enabled && !isWeb3EnableLoading) enableWeb3();
      // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [isAuthenticated, isWeb3Enabled]);
  
    return (
        <div className="wraper">
        <GlobalStyles />
          <Header/>
            <PosedRouter>
            <ScrollTop path="/">
              <Home2 exact path="/">
                <Redirect to="/home2" />
              </Home2>
              <Wallet path="/wallet" />
              <Key path="/key" />
              <Gacha path="/gacha" />
              </ScrollTop>
            </PosedRouter>
          <ScrollToTopBtn />
          
        </div>
    );
};

export default App;