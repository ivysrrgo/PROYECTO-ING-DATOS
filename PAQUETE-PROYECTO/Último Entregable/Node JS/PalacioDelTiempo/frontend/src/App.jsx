import React, { useState } from 'react';
import Navbar from './components/Navbar/Navbar';
import { Route, Routes } from 'react-router-dom';
import Home from './pages/Home/home';
import Cart from './pages/Cart/Cart';
import PlaceOrder from './pages/PlaceOrder/PlaceOrder';
import Footer from './components/Footer/Footer'; 
import LoginPopup from './components/LoginPopup/LoginPopup';
import StoreContextProvider from './context/StoreContext'; // Asegúrate de que la ruta es correcta

const App = () => {
  const [showLogin, setShowLogin] = useState(false);
  const [loginState, setLoginState] = useState("Iniciar Sesión");

  return ( 
    <StoreContextProvider>
      {showLogin && (
        <LoginPopup setShowLogin={setShowLogin} initialState={loginState} />
      )}
      <div className="app">
        <Navbar setShowLogin={setShowLogin} setLoginState={setLoginState} />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/cart" element={<Cart />} />
          <Route path="/order" element={<PlaceOrder />} />
        </Routes>
      </div>
      <Footer />
    </StoreContextProvider>
  );
};

export default App;
