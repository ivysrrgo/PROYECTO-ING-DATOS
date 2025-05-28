import './FoodItem.css';
import { assets } from '../../assets/assets';
import React, { useContext } from 'react';
import { StoreContext } from '../../context/StoreContext';

const FoodItem = ({ id, name, price, description, image }) => {
  const { cartItems, addToCart, removeFromCart, url } = useContext(StoreContext);

  // Construye la URL completa de la imagen
  const imageUrl = image ? `${url}/uploads/${image}` : assets.placeholder_image;

  return (
    <div className="food-item">
      <div className="food-item-img-container">
        <img className="food-item-image" src={image} alt={name} />
        {!cartItems[id]
          ? <img
              className='add'
              onClick={() => addToCart(id)}
              src={assets.add_icon_white}
              alt="Agregar"
            />
          : <div className='food-item-counter'>
              <img onClick={() => removeFromCart(id)} src={assets.remove_icon_red} alt="Quitar" />
              <p>{cartItems[id]}</p>
              <img onClick={() => addToCart(id)} src={assets.add_icon_green} alt="Agregar" />
            </div>
        }
      </div>
      <div className="food-item-info">
        <div className="food-item-name-rating">
          <p>{name}</p>
          <img src={assets.rating_starts} alt="Estrellas de calificación" />
        </div>
        <p className="food-item-desc">{description}</p>
        <p className="food-item-price">$COP {price}</p>
      </div>
    </div>
  );
};

export default FoodItem;