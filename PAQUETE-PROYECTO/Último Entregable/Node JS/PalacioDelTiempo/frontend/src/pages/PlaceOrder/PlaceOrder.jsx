import React, { useContext } from "react";
import "./PlaceOrder.css";
import { StoreContext } from "../../context/StoreContext";

const PlaceOrder = () => {
  const { getTotalCartAmount } = useContext(StoreContext);

  return (
    <form className="place-order">
      <div className="place-order-left">
        <p className="title">Información de Envío</p>
        <div className="multi-fields">
          <input className="input" type="text" placeholder="Nombre" />
          <input className="input" type="text" placeholder="Apellido" />
        </div>
        <input className="input" type="email" placeholder="Correo" />
        <input className="input" type="text" placeholder="Dirección" />
        <input className="input" type="text" placeholder="Teléfono" />
      </div>

      <div className="place-order-right">
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
          <button type="submit">Continuar a Pagar</button>
        </div>
      </div>
    </form>
  );
};

export default PlaceOrder;
