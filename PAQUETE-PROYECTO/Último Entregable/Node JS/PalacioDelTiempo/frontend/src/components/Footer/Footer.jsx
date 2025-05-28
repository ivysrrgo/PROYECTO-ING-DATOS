import React from 'react'
import './Footer.css'
import { assets } from '../../assets/assets'

const Footer = () => {
  return (
    <div className='footer' id='footer'>
      <div className="footer-content">
        <div className="footer-content-left">
            <img src={assets.logo} alt="" />
            <p>Más que accesorios, ofrecemos piezas que elevan tu estilo 
                y marcan tu esencia. Desde relojes de diseño hasta gafas con carácter 
                y estuches funcionales, cada detalle está pensado para quienes 
                valoran la elegancia en lo cotidiano.</p>
            <div className="footer-social-icons">
                <img src={assets.facebook_icon} alt="" />
                <img src={assets.twitter_icon} alt="" />
                <img src={assets.linkedin_icon} alt="" />
            </div>
        </div>
        <div className="footer-content-center">
            <h2>Compañía</h2>
            <ul>
                <li>Home</li>
                <li>About Us</li>
                <li>Delivery</li>
                <li>Privacy Policy</li>
            </ul>
        </div>
        <div className="footer-content-right">
            <h2>Contáctenos</h2>
            <ul>
                <li>+57 123 456 7890</li>
                <li>palacioTiempo@gmail.com</li>
            </ul>
        </div>
      </div>
    <hr />
    <p className='footer-copyright'>©2025 Palacio del Tiempo. Todos los derechos reservados.</p>
    <p className='footer-copyright'>Hecho con ❤️ por el equipo de desarrollo de Palacio del Tiempo</p>
    </div>
  )
}

export default Footer
