import React, { useState, useEffect } from 'react';
import axios from "axios";
import "./List.css";

const List = () => {
  const url = "http://localhost:3000";
  const [list, setList] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [searchTerm, setSearchTerm] = useState('');  // Estado para búsqueda
  const [minPrice, setMinPrice] = useState('');      // Estado para filtro de precio mínimo

  const [editingProduct, setEditingProduct] = useState(null);
  const [formData, setFormData] = useState({
    codigoProducto: '',
    nombreProducto: '',
    precioProducto: '',
    cantidadProducto: '',
    descripcionProducto: '',
    estadoProducto: false,
    imagenFile: null,
  });

  const fetchList = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await axios.get(`${url}/producto/productos`);
      setList(response.data);
    } catch (err) {
      setError("Error al conectar con el servidor");
      console.error(err);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchList();
  }, []);

  const handleDelete = async (id, nombreProducto) => {
    if (window.confirm(`¿Estás seguro que quieres eliminar el producto "${nombreProducto}"?`)) {
      try {
        await axios.delete(`${url}/producto/delete/${id}`);
        setList(list.filter(item => item._id !== id));
      } catch (error) {
        alert("Error al eliminar el producto");
        console.error(error);
      }
    }
  };

  const openEditForm = (item) => {
    setEditingProduct(item);
    setFormData({
      codigoProducto: item.codigoProducto || '',
      nombreProducto: item.nombreProducto || '',
      precioProducto: item.precioProducto || '',
      cantidadProducto: item.cantidadProducto || '',
      descripcionProducto: item.descripcionProducto || '',
      estadoProducto: item.estadoProducto || false,
      imagenFile: null,
    });
  };

  const closeEditForm = () => {
    setEditingProduct(null);
    setFormData({
      codigoProducto: '',
      nombreProducto: '',
      precioProducto: '',
      cantidadProducto: '',
      descripcionProducto: '',
      estadoProducto: false,
      imagenFile: null,
    });
  };

  const handleChange = (e) => {
    const { name, value, type, checked, files } = e.target;
    if (type === 'checkbox') {
      setFormData(prev => ({ ...prev, [name]: checked }));
    } else if (type === 'file') {
      setFormData(prev => ({ ...prev, imagenFile: files[0] }));
    } else {
      setFormData(prev => ({ ...prev, [name]: value }));
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const data = new FormData();
      data.append('codigoProducto', formData.codigoProducto);
      data.append('nombreProducto', formData.nombreProducto);
      data.append('precioProducto', formData.precioProducto);
      data.append('cantidadProducto', formData.cantidadProducto);
      data.append('descripcionProducto', formData.descripcionProducto);
      data.append('estadoProducto', formData.estadoProducto);

      if (formData.imagenFile) {
        data.append('imagen', formData.imagenFile);
      }

      await axios.put(`${url}/producto/update/${editingProduct._id}`, data, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });

      alert("Producto actualizado con éxito");
      closeEditForm();
      fetchList();
    } catch (error) {
      alert("Error al actualizar el producto");
      console.error(error);
    }
  };

  if (loading) return <p>Cargando productos...</p>;
  if (error) return <p style={{ color: 'red' }}>{error}</p>;

  // Filtrar por nombre y por precio mínimo
  const filteredList = list.filter(item => {
    const term = searchTerm.toLowerCase();
    const matchesName = item.nombreProducto.toLowerCase().includes(term);
    const meetsPrice = minPrice === '' || item.precioProducto >= parseFloat(minPrice);
    return matchesName && meetsPrice;
  });

  return (
    <div className='list add flex-col'>
      <h2>Lista de Productos</h2>

      {/* Contenedor inputs búsqueda + filtro precio */}
      <div style={{ display: 'flex', gap: '10px', flexWrap: 'wrap', marginBottom: '15px' }}>
        <input
          type="text"
          placeholder="Buscar por nombre..."
          value={searchTerm}
          onChange={e => setSearchTerm(e.target.value)}
          style={{ padding: '8px', width: '100%', maxWidth: '400px' }}
        />
        <input
          type="number"
          placeholder="Precio mínimo"
          value={minPrice}
          onChange={e => setMinPrice(e.target.value)}
          style={{ padding: '8px', width: '100%', maxWidth: '200px' }}
          min="0"
          step="0.01"
        />
      </div>

      <div className="list-table">
        <div className="list-table-format title">
          <b>Imagen</b>
          <b>Nombre</b>
          <b>Precio</b>
          <b>Cantidad</b>
          <b>Descripción</b>
          <b>Estado</b>
          <b>Acción</b>
        </div>
        {filteredList.length === 0 ? (
          <p>No se encontraron productos que coincidan.</p>
        ) : (
          filteredList.map(item => {
            const imageUrl = item.imagen ? `${url}/uploads/${item.imagen}` : null;
            return (
              <div key={item._id || item.id} className='list-table-format'>
                {imageUrl ? (
                  <img
                    src={imageUrl}
                    alt={item.nombreProducto}
                    width="100"
                    onError={(e) => {
                      e.target.style.display = 'none';
                      e.target.insertAdjacentHTML('afterend', '<span style="color:gray;">No tiene imagen</span>');
                    }}
                  />
                ) : (
                  <span style={{ color: "gray" }}>No tiene imagen</span>
                )}

                <p>{item.nombreProducto}</p>
                <p>${item.precioProducto}</p>
                <p>{item.cantidadProducto}</p>
                <p>{item.descripcionProducto}</p>
                <p style={{ color: item.estadoProducto ? 'green' : 'red' }}>
                  {item.estadoProducto ? "Activo" : "Inactivo"}
                </p>

                <div className="action-buttons">
                  <button onClick={() => handleDelete(item._id, item.nombreProducto)}>X</button>
                  <button onClick={() => openEditForm(item)}>Editar</button>
                </div>
              </div>
            );
          })
        )}
      </div>

      {editingProduct && (
        <div className="modal">
          <div className="modal-content">
            <h3>Editar Producto: {editingProduct.nombreProducto}</h3>
            {editingProduct.imagen && (
              <div style={{ marginBottom: '15px' }}>
                <label>Imagen actual:</label><br />
                <img
                  src={`${url}/uploads/${editingProduct.imagen}`}
                  alt={editingProduct.nombreProducto}
                  style={{ maxWidth: '150px', maxHeight: '150px', borderRadius: '8px' }}
                />
              </div>
            )}
            <form onSubmit={handleSubmit} encType="multipart/form-data">
              <label>Código Producto:</label>
              <input
                type="text"
                name="codigoProducto"
                value={formData.codigoProducto}
                onChange={handleChange}
              />

              <label>Nombre Producto:</label>
              <input
                type="text"
                name="nombreProducto"
                value={formData.nombreProducto}
                onChange={handleChange}
                required
              />

              <label>Precio:</label>
              <input
                type="number"
                name="precioProducto"
                value={formData.precioProducto}
                onChange={handleChange}
                step="0.01"
                min="0"
              />

              <label>Cantidad:</label>
              <input
                type="number"
                name="cantidadProducto"
                value={formData.cantidadProducto}
                onChange={handleChange}
                min="0"
              />

              <label>Descripción:</label>
              <textarea
                name="descripcionProducto"
                value={formData.descripcionProducto}
                onChange={handleChange}
              />

              <label>
                <input
                  type="checkbox"
                  name="estadoProducto"
                  checked={formData.estadoProducto}
                  onChange={handleChange}
                />
                Activo
              </label>

              <label>Cambiar imagen:</label>
              <input
                type="file"
                name="imagen"
                accept="image/*"
                onChange={handleChange}
              />

              <div style={{ marginTop: '15px' }}>
                <button type="submit">Guardar Cambios</button>
                <button type="button" onClick={closeEditForm} style={{ marginLeft: '10px' }}>Cancelar</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default List;
