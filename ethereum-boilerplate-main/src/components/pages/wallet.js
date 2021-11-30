import {React, useState} from 'react';
import Wallet from '../components/wallet';
import Footer from '../components/footer';
import Account from "components/Account";
import { createGlobalStyle } from 'styled-components';
import Particle from '../components/Particle';
import SliderMainParticle from '../components/SliderMainParticle';
import { useMoralis } from "react-moralis";
const GlobalStyles = createGlobalStyle`
  header#myHeader .logo .d-block{
    display: none !important;
  }
  header#myHeader .logo .d-none{
    display: block !important;
  }
  .navbar .mainside a{
    background: #8364e2;
    &:hover{
      box-shadow: 2px 2px 20px 0px #8364e2;
    }
  }
  .item-dropdown{
    .dropdown{
      a{
        &:hover{
          background: #8364e2;
        }
      }
    }
  }
  .btn-main{
    background: #8364e2;
    &:hover{
      box-shadow: 2px 2px 20px 0px #8364e2;
    }
  }
  p.lead{
    color: #a2a2a2;
  }
  .navbar .navbar-item .lines{
    border-bottom: 2px solid #8364e2;
  }
  .jumbotron.no-bg{
    height: 100vh;
    overflow: hidden;
    background-repeat: repeat;
    background-size: cover;
    background-position: bottom;
    background-repeat: no-repeat;
  }
  #tsparticles{
    top: 0;
  }
  .text-uppercase.color{
    color: #8364e2;
  }
  .de_count h3 {
    font-size: 36px;
    margin-bottom: 0px;
  }
  .de_count h5{
    font-size: 14px;
    font-weight: 500;
  }
  h2 {
    font-size: 30px;
  }
  .box-url{
    text-align: center;
    h4{
      font-size: 16px;
    }
  }
  .de_countdown{
    border: solid 2px #8364e2;
  }
  .author_list_pp, .author_list_pp i, 
  .nft_coll_pp i, .feature-box.style-3 i, 
  footer.footer-light #form_subscribe #btn-subscribe i, 
  #scroll-to-top div{
    background: #8364e2;
  }
  footer.footer-light .subfooter .social-icons span i{
    background: #403f83;
  }
  .author_list_pp:hover img{
    box-shadow: 0px 0px 0px 2px #8364e2;
  }
  .nft__item_action span{
    color: #8364e2;
  }
  .feature-box.style-3 i.wm{
    color: rgba(131,100,226, .1);
  }
  @media only screen and (max-width: 1199px) {
    .navbar{
      
    }
    .navbar .menu-line, .navbar .menu-line1, .navbar .menu-line2{
      background: #fff;
    }
    .item-dropdown .dropdown a{
      color: #fff !important;
    }
  .box-login{
    border-radius: 3px;
    padding: 40px 160px;
  }
  .box-login2{
    border-radius: 1px;
    padding: 40px 90px;
  }
  }
`;

const styles = {
  account: {
    height: "42px",
    padding: "0 15px",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    width: "fit-content",
    borderRadius: "12px",
    backgroundColor: "rgb(244, 244, 244)",
    cursor: "pointer",
  },
  text: {
    color: "#21BF96",
  },
};


function CheckAuthenticate() {
  const { authenticate, isAuthenticated, logout, isAuthenticating, signup, user, setUserData, userError, isUserUpdating } = useMoralis();

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [email, setEmail] = useState("");


  if (!isAuthenticated) {
    return (
      <div
        onClick={() => authenticate({ signingMessage: "Sign In Metamask" })}
      >
        <div className='container'>
          <div className="box-login">
            <h3 className="mb10">Authenticate to Metamask!</h3>
            <p className="btn-main inline lead">Authenticate</p>
          </div>
        </div>
        
        
      </div>
    );
  }

  return (
    <section className='jumbotron breadcumb no-bg' >
    <div className='mainbreadcumb'>
      <div className='container'>
        <div className='row m-10-hor'>
          <div className='col-12'>
            
              <div
                onClick={() => logout()} disabled={isAuthenticating}
              >
                <div className='container'>
                  <div className="box-login2">
                    <p className="btn-main inline lead">LogOut</p>
                  </div>
                </div>
        
        
              </div>
        
        
            <h1 className='text-center'>Setup email address</h1>
            <div className="box-login">
              {userError && <p>{userError.message}</p>}
              <h3 className="mb10">Sign up</h3>
              <form name="contactForm" id='contact_form' className="form-border" action='#'>

                  <div className="field-set">
                      <input type='text' name='email' id='email' className="form-control" placeholder="email" value={email} onChange={(e) => setEmail(e.currentTarget.value)}/>
                  </div>
                
                 <div className="field-set">
                      <input type='password' name='password' id='password' className="form-control" placeholder="password" value={password} onChange={(e) => setPassword(e.currentTarget.value)}/>
                  </div>
              
                <div className="field-set">
                  <input type='submit' id='send_message' value='Submit' className="btn-main inline lead" onClick={() => setUserData({
                    username: email,
                    email: email,
                    password: password,
                  })} disabled={isUserUpdating}/>
                  
                </div>
                <div className="clearfix"></div>  
                  <ul className="list s3">
{/*                       <li>Login with:</li>
                      <li><span >Facebook</span></li>
                      <li><span >Google</span></li> */}
                  </ul>
                  <div className="spacer-half"></div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    </section>
  );
}


function Test() {
  const { authenticate, isAuthenticated, user, logout } = useMoralis();

  if (!isAuthenticated) {
    return (
      <div>
        <button onClick={() => authenticate()}>Authenticate</button>
      </div>
    );
  }

  return (
    <div>
      <h1>Welcome {user.get("username")}</h1>
    </div>
  );
}

const wallet= () => (
<div>
<GlobalStyles/>

  <section className="jumbotron no-bg" style={{backgroundImage: `url(${'./img/background/Background_01.png'})`}}>
    <CheckAuthenticate/>
  </section>
  

  {/* <section className='container'>
    <Wallet/>
  </section> */}

  <Footer />

</div>

);
export default wallet;