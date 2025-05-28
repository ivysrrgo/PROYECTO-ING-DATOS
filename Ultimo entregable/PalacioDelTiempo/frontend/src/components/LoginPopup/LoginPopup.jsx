import React, { useState, useEffect, useContext } from 'react';
import './LoginPopup.css';
import { assets } from '../../assets/assets';
import { StoreContext } from '../../context/StoreContext';
import axios from 'axios';

const LoginPopup = ({ setShowLogin, initialState }) => {
  const { url, setToken } = useContext(StoreContext);
  const [currState, setCurrState] = useState("Registrarse");

  const [data, setData] = useState({
    docUsuario: "",           // Nuevo campo agregado
    nombreUsuario: "",
    apellidoUsuario: "",
    correoUsuario: "",
    password: "",
    telefonoUsuario: "",
    direccionUsuario: "",
    nickname: "",
    tipoUsuario: "Vendedor",
    nuevaPassword: "", // para cambio de clave
  });

  const onChangeHandler = (event) => {
    const { name, value } = event.target;
    setData((prevData) => ({ ...prevData, [name]: value }));
  };

  const onSubmit = async (event) => {
    event.preventDefault();

    try {
      let newUrl;

      if (currState === "Iniciar Sesión") {
        newUrl = `${url}/usuario/login`;
      } else if (currState === "Registrarse") {
        newUrl = `${url}/usuario/register`;
      } else if (currState === "Cambiar Contraseña") {
        newUrl = `${url}/usuario/change-password`;
      }

      const response = await axios.post(newUrl, data);

      if (currState === "Iniciar Sesión") {
        if (response.data.token) {
          setToken(response.data.token);
          localStorage.setItem("token", response.data.token);
          setShowLogin(false);
        } else {
          alert(response.data.mensaje || "Credenciales incorrectas");
        }
      } else if (currState === "Registrarse") {
        if (response.data.mensaje === "Usuario registrado exitosamente") {
          alert("Usuario registrado exitosamente");
          setShowLogin(false);
        } else {
          alert(response.data.mensaje || "Error al registrar usuario");
        }
      } else if (currState === "Cambiar Contraseña") {
        alert(response.data.mensaje || "Cambio realizado");
        setShowLogin(false);
      }
    } catch (err) {
      console.error(err);
      alert(err.response?.data?.mensaje || "Ocurrió un error al procesar tu solicitud");
    }
  };

  useEffect(() => {
    if (initialState) {
      setCurrState(initialState);
    }
  }, [initialState]);

  return (
    <div className="login-popup">
      <form onSubmit={onSubmit} className="login-popup-container">
        <div className="login-popup-title">
          <h2>{currState}</h2>
          <img onClick={() => setShowLogin(false)} src={assets.cross_icon} alt="Cerrar" />
        </div>

        <div className="login-popup-inputs">
          {currState === "Registrarse" && (
            <>
              <input
                name="docUsuario"
                onChange={onChangeHandler}
                value={data.docUsuario}
                type="text"
                placeholder="Documento de Identidad"
                required
              />
              <input
                name="nombreUsuario"
                onChange={onChangeHandler}
                value={data.nombreUsuario}
                type="text"
                placeholder="Nombre"
                required
              />
              <input
                name="apellidoUsuario"
                onChange={onChangeHandler}
                value={data.apellidoUsuario}
                type="text"
                placeholder="Apellido"
                required
              />
              <input
                name="telefonoUsuario"
                onChange={onChangeHandler}
                value={data.telefonoUsuario}
                type="text"
                placeholder="Teléfono"
                required
              />
              <input
                name="direccionUsuario"
                onChange={onChangeHandler}
                value={data.direccionUsuario}
                type="text"
                placeholder="Dirección"
                required
              />
              <input
                name="nickname"
                onChange={onChangeHandler}
                value={data.nickname}
                type="text"
                placeholder="Nickname"
                required
              />
              <select
                name="tipoUsuario"
                onChange={onChangeHandler}
                value={data.tipoUsuario}
                required
              >
                <option value="Vendedor">Vendedor</option>
                <option value="Administrador">Administrador</option>
                <option value="Repartidor">Repartidor</option>
              </select>
            </>
          )}

          {(currState !== "Cambiar Contraseña") && (
            <>
              <input
                name="correoUsuario"
                onChange={onChangeHandler}
                value={data.correoUsuario}
                type="email"
                placeholder="Correo electrónico"
                required
              />
              <input
                name="password"
                onChange={onChangeHandler}
                value={data.password}
                type="password"
                placeholder="Contraseña"
                required
              />
            </>
          )}

          {currState === "Cambiar Contraseña" && (
            <>
              <input
                name="correoUsuario"
                onChange={onChangeHandler}
                value={data.correoUsuario}
                type="email"
                placeholder="Correo electrónico"
                required
              />
              <input
                name="password"
                onChange={onChangeHandler}
                value={data.password}
                type="password"
                placeholder="Contraseña Actual"
                required
              />
              <input
                name="nuevaPassword"
                onChange={onChangeHandler}
                value={data.nuevaPassword}
                type="password"
                placeholder="Nueva Contraseña"
                required
              />
            </>
          )}
        </div>

        <button type="submit">
          {currState === "Registrarse"
            ? "Crear una Cuenta"
            : currState === "Cambiar Contraseña"
            ? "Cambiar Contraseña"
            : "Iniciar Sesión"}
        </button>

        {currState !== "Cambiar Contraseña" && (
          <div className="login-popup-condition">
            <input type="checkbox" required />
            <p>Para continuar, acepta las políticas de privacidad</p>
          </div>
        )}

        <p>
          {currState === "Registrarse"
            ? "¿Ya tienes una cuenta?"
            : currState === "Iniciar Sesión"
            ? "¿No tienes una cuenta?"
            : "¿Volver a inicio?"}
          <span
            onClick={() =>
              setCurrState(
                currState === "Registrarse"
                  ? "Iniciar Sesión"
                  : currState === "Iniciar Sesión"
                  ? "Registrarse"
                  : "Iniciar Sesión"
              )
            }
            style={{ color: "#49557e", cursor: "pointer", marginLeft: "5px" }}
          >
            {currState === "Registrarse"
              ? "Inicia Sesión"
              : currState === "Iniciar Sesión"
              ? "Regístrate"
              : "Inicia Sesión"}
          </span>
        </p>

        <p style={{ marginTop: "10px" }}>
          {currState !== "Cambiar Contraseña" && (
            <span
              onClick={() => setCurrState("Cambiar Contraseña")}
              style={{ color: "#49557e", cursor: "pointer" }}
            >
              ¿Quieres cambiar tu clave?
            </span>
          )}
        </p>
      </form>
    </div>
  );
};

export default LoginPopup;
