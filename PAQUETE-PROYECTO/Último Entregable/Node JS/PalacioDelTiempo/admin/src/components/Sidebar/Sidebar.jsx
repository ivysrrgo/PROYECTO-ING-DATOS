import React from 'react'
import "./Sidebar.css";
import { assets } from '../../assets/assets';
import { NavLink } from 'react-router-dom';

const Sidebar = () => {
  return (
    <div className='sidebar'>
      <div className="sidebar-options">
        {/* Grupo Productos */}
        <p className="sidebar-group-title">Productos</p>
        <NavLink to='/add' className="sidebar-option">
          <img src={assets.add_icon} alt="" />
          <p>Agregar Producto</p>
        </NavLink>
        <NavLink to='/list' className="sidebar-option">
          <img src={assets.order_icon} alt="" />
          <p>Listar Productos</p>
        </NavLink>

        {/* Separador */}
        <hr className="sidebar-separator" />

        {/* Grupo Usuarios */}
        <p className="sidebar-group-title">Usuarios</p>
        <NavLink to='/user' className="sidebar-option">
          <img src={assets.user_icon} alt="" />
          <p>Usuarios</p>
        </NavLink>

        {/* Separador */}
        <hr className="sidebar-separator" />
        {/* Grupo Clientes */}
        <p className="sidebar-group-title">Clientes</p>
        <NavLink to='/cliente' className="sidebar-option">
          <img src={assets.user_icon} alt="" />
          <p>Cliente</p>
        </NavLink>
      </div>
    </div>
  )
}

export default Sidebar;

