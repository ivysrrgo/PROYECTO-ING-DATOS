import React, { useContext, useState } from 'react';
import './Navbar.css';
import { assets } from '../../assets/assets';
import { Link } from 'react-router-dom';
import { StoreContext } from '../../context/StoreContext';

const Navbar = ({ setShowLogin, setLoginState }) => {
  const [menu, setMenu] = useState("home");
  const{getTotalCartAmount}=useContext(StoreContext);

  return (
    <div className="navbar">
      <Link to='/'><img src={assets.logo} alt="Logo" className="logo" /></Link>

      <ul className="navbar-menu">
        <Link to='/' className={menu === "home" ? "active" : ""} onClick={() => setMenu("home")}>Inicio</Link>
        <a href='#explore-menu' className={menu === "menu" ? "active" : ""} onClick={() => setMenu("menu")}>Productos</a>
        <a href='#footer' className={menu === "contact us" ? "active" : ""} onClick={() => setMenu("contact us")}>Contáctenos</a>
      </ul>

      <div className="navbar-right">
        <img src={assets.search_icon} alt="Buscar" className="icon" />

        <div className="basket-container">
          <Link to='/cart'><img src={assets.basket_icon} alt="Carrito" className="icon" /></Link>
          <div className={getTotalCartAmount()===0?"":"dot"}></div>
        </div>

        <button
          onClick={() => {
            setLoginState("Iniciar Sesión"); 
            setShowLogin(true);
          }}
        >
          Inicia Sesión
        </button>
      </div>
    </div>
  );
};

export default Navbar;

