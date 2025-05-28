import React, { useState, useEffect } from 'react';
import axios from "axios";
import "./Cliente.css";

const Cliente = () => {
  const url = "http://localhost:3000";
  const [clientes, setClientes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [searchTerm, setSearchTerm] = useState('');

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingCliente, setEditingCliente] = useState(null);
  const [formData, setFormData] = useState({
    docCliente: '',
    nombreCliente: '',
    estado: true,
    telefonoCliente: '',
    direccionCliente: ''
  });

  const [successMessage, setSuccessMessage] = useState('');

  const fetchClientes = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await axios.get(`${url}/cliente/clientes`);
      setClientes(response.data);
    } catch (err) {
      setError("Error al conectar con el servidor");
      console.error(err);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchClientes();
  }, []);

  if (loading) return <p>Cargando clientes...</p>;
  if (error) return <p style={{ color: 'red' }}>{error}</p>;

  const filteredClientes = clientes.filter(cliente => {
    const term = searchTerm.toLowerCase();
    return (
      (cliente.docCliente && cliente.docCliente.toString().toLowerCase().includes(term)) ||
      (cliente.nombreCliente && cliente.nombreCliente.toLowerCase().includes(term)) ||
      (cliente.telefonoCliente && cliente.telefonoCliente.toString().toLowerCase().includes(term)) ||
      (cliente.direccionCliente && cliente.direccionCliente.toLowerCase().includes(term))
    );
  });

  const handleAdd = () => {
    setEditingCliente(null);  // Nuevo cliente
    setFormData({
      docCliente: '',
      nombreCliente: '',
      estado: true,
      telefonoCliente: '',
      direccionCliente: ''
    });
    setSuccessMessage('');
    setIsModalOpen(true);
  };

  const handleEdit = (cliente) => {
    setEditingCliente(cliente);
    setFormData({
      docCliente: cliente.docCliente || '',
      nombreCliente: cliente.nombreCliente || '',
      estado: cliente.estado,
      telefonoCliente: cliente.telefonoCliente || '',
      direccionCliente: cliente.direccionCliente || ''
    });
    setSuccessMessage('');
    setIsModalOpen(true);
  };

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (editingCliente) {
        // Editar existente
        await axios.put(`${url}/cliente/clientes/${editingCliente._id}`, formData);
        setSuccessMessage('Cliente actualizado correctamente.');
      } else {
        // Crear nuevo
        await axios.post(`${url}/cliente/clientes`, formData);
        setSuccessMessage('Cliente agregado correctamente.');
      }
      fetchClientes();
      setTimeout(() => {
        setIsModalOpen(false);
        setSuccessMessage('');
      }, 2000);
    } catch (err) {
      alert('Error al guardar cliente');
      console.error(err);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setEditingCliente(null);
    setSuccessMessage('');
  };

  return (
    <div className='list'>
      <h2>Lista de Clientes</h2>

      <input
        type="text"
        placeholder="Buscar por documento, nombre, teléfono, dirección..."
        value={searchTerm}
        onChange={e => setSearchTerm(e.target.value)}
      />

      <button className="add" onClick={handleAdd} style={{ margin: '10px 0' }}>
        Agregar Cliente
      </button>

      <div className="list-table">
        <div className="list-table-format title">
          <b>Documento</b>
          <b>Nombre</b>
          <b>Teléfono</b>
          <b>Dirección</b>
          <b>Estado</b>
          <b>Acción</b>
        </div>
        {filteredClientes.length === 0 ? (
          <p>No se encontraron clientes que coincidan.</p>
        ) : (
          filteredClientes.map(cliente => (
            <div key={cliente._id} className='list-table-format'>
              <p>{cliente.docCliente || '-'}</p>
              <p>{cliente.nombreCliente}</p>
              <p>{cliente.telefonoCliente || '-'}</p>
              <p>{cliente.direccionCliente || '-'}</p>
              <p style={{ color: cliente.estado ? 'green' : 'red' }}>
                {cliente.estado ? "Activo" : "Inactivo"}
              </p>
              <p>
                <button className="edit" onClick={() => handleEdit(cliente)}>
                  Editar
                </button>
              </p>
            </div>
          ))
        )}
      </div>

      {isModalOpen && (
        <div className="modal-overlay">
          <div className="modal-content">
            <h3>{editingCliente ? 'Editar Cliente' : 'Agregar Cliente'}</h3>

            {successMessage && (
              <p style={{ color: 'green', marginBottom: '15px' }}>{successMessage}</p>
            )}

            <form onSubmit={handleSubmit}>
              <label>
                Documento:
                <input
                  type="number"
                  name="docCliente"
                  value={formData.docCliente}
                  onChange={handleChange}
                />
              </label>

              <label>
                Nombre:
                <input
                  type="text"
                  name="nombreCliente"
                  value={formData.nombreCliente}
                  onChange={handleChange}
                  required
                />
              </label>

              <label>
                Teléfono:
                <input
                  type="text"
                  name="telefonoCliente"
                  value={formData.telefonoCliente}
                  onChange={handleChange}
                />
              </label>

              <label>
                Dirección:
                <input
                  type="text"
                  name="direccionCliente"
                  value={formData.direccionCliente}
                  onChange={handleChange}
                />
              </label>

              <label style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                Estado:
                <input
                  type="checkbox"
                  name="estado"
                  checked={formData.estado}
                  onChange={handleChange}
                />
                {formData.estado ? "Activo" : "Inactivo"}
              </label>

              <div className="form-actions">
                <button type="button" className="cancel" onClick={handleCloseModal}>
                  Cancelar
                </button>
                <button type="submit" className="save">
                  Guardar
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default Cliente;
