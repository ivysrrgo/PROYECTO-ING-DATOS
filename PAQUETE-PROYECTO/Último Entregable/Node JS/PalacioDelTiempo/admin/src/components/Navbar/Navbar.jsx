import React from 'react'
import "./Navbar.css";
import { assets } from '../../assets/assets';

const Navbar = () => {
  return (
    <div className='navbar'>
  <div className='navbar-left'>
    <img className='logo' src={assets.logo} alt="Logo" />
  </div>
  <div className='navbar-right'>
    <img className='profile' src={assets.profile_image} alt="Perfil" />
    <span className='admin-label'>Admin panel</span>
  </div>
</div>

  )
}

export default Navbar
