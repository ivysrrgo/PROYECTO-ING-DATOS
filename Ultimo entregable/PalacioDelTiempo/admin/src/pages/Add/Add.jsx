import React, { useState } from 'react';
import './Add.css';
import { assets } from '../../assets/assets';
import axios from "axios";

const Add = () => {
    const url = "http://localhost:3000";
    const [image, setImage] = useState(false);
    const [data, setData] = useState({
        codigoProducto: "",
        nombreProducto: "",
        descripcionProducto: "",
        precioProducto: "",
        cantidadProducto: 1,
        categoriaProducto: "",
        estadoProducto: true
    });

    const onChangeHandler = (event) => {
        const name = event.target.name;
        const value = event.target.type === "number"
            ? Number(event.target.value)
            : event.target.type === "checkbox"
                ? event.target.checked
                : event.target.value;

        setData(data => ({ ...data, [name]: value }));
    };

    const onSubmitHandler = async (event) => {
        event.preventDefault();
        const formData = new FormData();
        formData.append("codigoProducto", data.codigoProducto);
        formData.append("nombreProducto", data.nombreProducto);
        formData.append("descripcionProducto", data.descripcionProducto);
        formData.append("categoriaProducto", data.categoriaProducto);
        formData.append("precioProducto", Number(data.precioProducto));
        formData.append("cantidadProducto", Number(data.cantidadProducto));
        formData.append("estadoProducto", data.estadoProducto);
        formData.append("imagen", image);

        try {
            const response = await axios.post(`${url}/producto/add-producto`, formData);
            if (response.data.success) {
                setData({
                    codigoProducto: "",
                    nombreProducto: "",
                    descripcionProducto: "",
                    precioProducto: "",
                    cantidadProducto: 1,
                    categoriaProducto: "",
                    estadoProducto: true
                });
                setImage(false);
                alert("Producto agregado exitosamente");
            } else {
                alert("Error al agregar el producto");
            }
        } catch (error) {
            console.error("Error al enviar el producto:", error);
            alert("Error al enviar el producto");
        }
    };

    return (
        <div className='add'>
            <form className='flex-col' onSubmit={onSubmitHandler}>
                <div className="add-img-upload flex-col">
                    <p>Cargar Imagen</p>
                    <label htmlFor="image">
                        <img
                            src={image ? URL.createObjectURL(image) : assets.upload_area}
                            alt="preview"
                            className={image ? 'uploaded' : 'placeholder'}
                        />
                    </label>
                    <input
                        onChange={(e) => setImage(e.target.files[0])}
                        type="file"
                        id="image"
                        hidden
                        required
                        accept="image/*"
                    />
                </div>

                <div className="add-product-code flex-col">
                    <p>Código Producto</p>
                    <input onChange={onChangeHandler} value={data.codigoProducto} type="text" name="codigoProducto" placeholder='Escriba código' required />
                </div>

                <div className="add-product-name flex-col">
                    <p>Nombre Producto</p>
                    <input onChange={onChangeHandler} value={data.nombreProducto} type="text" name="nombreProducto" placeholder='Escriba nombre' required />
                </div>

                <div className="add-product-description flex-col">
                    <p>Descripción Producto</p>
                    <textarea onChange={onChangeHandler} value={data.descripcionProducto} name="descripcionProducto" rows="6" placeholder='Escriba descripción' required></textarea>
                </div>

                <div className="add-category flex-col">
                    <p>Categoría</p>
                    <select onChange={onChangeHandler} value={data.categoriaProducto} name="categoriaProducto" required>
                        <option value="">Seleccione categoría</option>
                        <option value="Gafas">Gafas</option>
                        <option value="Estuches">Estuches</option>
                        <option value="Relojes">Relojes</option>
                        <option value="Accesorios">Accesorios</option>
                    </select>
                </div>

                <div className="add-quantity-price flex-row">
                    <div className="add-quantity flex-col">
                        <p>Cantidad</p>
                        <input onChange={onChangeHandler} value={data.cantidadProducto} type="number" name="cantidadProducto" min="1" placeholder='Cantidad' required />
                    </div>
                    <div className="add-price flex-col">
                        <p>Precio</p>
                        <input onChange={onChangeHandler} value={data.precioProducto} type="number" name='precioProducto' placeholder='$COP 20000' required />
                    </div>
                </div>

                <div className="add-status flex-col">
                    <p>Estado</p>
                    <select onChange={onChangeHandler} value={data.estadoProducto} name="estadoProducto" required>
                        <option value={true}>Activo</option>
                        <option value={false}>Inactivo</option>
                    </select>
                </div>

                <button type='submit' className='add-button'>Agregar</button>
            </form>
        </div>
    );
};

export default Add;
