import React, { useContext } from 'react';
import './Cart.css';
import { StoreContext } from '../../context/StoreContext';
import { useNavigate } from 'react-router-dom';

const Cart = () => {
  const { cartItems, food_list, removeFromCart, getTotalCartAmount } = useContext(StoreContext);
  const navigate = useNavigate();

  return (
    <div className='cart'>
      <div className="cart-items">
        <div className="cart-items-title">
          <p>Ítems</p>
          <p>Título</p>
          <p>Precio</p>
          <p>Cantidad</p>
          <p>Total</p>
          <p>Remover</p>
        </div>
        <br />
        <hr />
        {food_list.map((item, index) => {
          if (cartItems[item._id] > 0) {
            return (
              <div className='cart-items-item' key={index}>
                <img src={item.image} alt={item.name} />
                <p>{item.name}</p>
                <p>$COP {item.price}</p>
                <p>{cartItems[item._id]}</p>
                <p>$COP {item.price * cartItems[item._id]}</p>
                <button onClick={() => removeFromCart(item._id)}>x</button>
              </div>
            );
          }
          return null;
        })}
      </div>
      <div className="cart-bottom">
        <div className="cart-total">
          <h2>Total de Factura</h2>
          <div>
            <div className="cart-total-details">
              <p>Subtotal</p>
              <p>$COP {getTotalCartAmount().toFixed(2)}</p>
            </div>
            <hr />
            <div className="cart-total-details">
              <p>IVA</p>
              <p>19%</p>
            </div>
            <hr />
            <div className="cart-total-details">
              <b>Total</b>
              <b>$COP {(getTotalCartAmount() * 1.19).toFixed(2)}</b>
            </div>
            <hr />
          </div>
          <button onClick={() => navigate('/order')}>Continuar</button>
        </div>
      </div>
    </div>
  );
};

export default Cart;


