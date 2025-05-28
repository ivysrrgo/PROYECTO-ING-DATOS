import React, { useState, useEffect } from 'react';
import axios from "axios";
import "./User.css";

const User = () => {
  const url = "http://localhost:3000";
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [searchTerm, setSearchTerm] = useState(''); // búsqueda

  // Estado para controlar modal
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingUser, setEditingUser] = useState(null);
  const [formData, setFormData] = useState({
    nombreUsuario: '',
    apellidoUsuario: '',
    correoUsuario: '',
    telefonoUsuario: '',
    direccionUsuario: '',
    nickname: '',
    tipoUsuario: '',
    estadoUsuario: true,
    docUsuario: ''
  });

  // Estado para mensaje de éxito
  const [successMessage, setSuccessMessage] = useState('');

  const fetchUsers = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await axios.get(`${url}/usuario/usuarios`);
      setUsers(response.data);
    } catch (err) {
      setError("Error al conectar con el servidor");
      console.error(err);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  if (loading) return <p>Cargando usuarios...</p>;
  if (error) return <p style={{ color: 'red' }}>{error}</p>;

  const filteredUsers = users.filter(user => {
    const term = searchTerm.toLowerCase();
    return (
      (user.docUsuario && user.docUsuario.toLowerCase().includes(term)) ||
      user.nombreUsuario.toLowerCase().includes(term) ||
      user.apellidoUsuario.toLowerCase().includes(term) ||
      user.correoUsuario.toLowerCase().includes(term) ||
      (user.nickname && user.nickname.toLowerCase().includes(term))
    );
  });

  const handleEdit = (user) => {
    setEditingUser(user);
    setFormData({
      nombreUsuario: user.nombreUsuario || '',
      apellidoUsuario: user.apellidoUsuario || '',
      correoUsuario: user.correoUsuario || '',
      telefonoUsuario: user.telefonoUsuario || '',
      direccionUsuario: user.direccionUsuario || '',
      nickname: user.nickname || '',
      tipoUsuario: user.tipoUsuario || '',
      estadoUsuario: user.estadoUsuario,
      docUsuario: user.docUsuario || ''
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
      await axios.put(`${url}/usuario/usuarios/${editingUser._id}`, formData);
      setSuccessMessage('Usuario actualizado correctamente.');
      fetchUsers(); // refrescar lista
      setTimeout(() => {
        setIsModalOpen(false);
        setSuccessMessage('');
      }, 2000); // cierra modal y borra mensaje después de 2 segundos
    } catch (err) {
      alert('Error al actualizar usuario');
      console.error(err);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setEditingUser(null);
    setSuccessMessage('');
  };

  return (
    <div className='list add flex-col'>
      <h2>Lista de Usuarios</h2>

      {/* Barra de búsqueda */}
      <input
        type="text"
        placeholder="Buscar por documento, nombre, apellido, correo, nickname..."
        value={searchTerm}
        onChange={e => setSearchTerm(e.target.value)}
        style={{ marginBottom: '15px', padding: '8px', width: '100%', maxWidth: '400px' }}
      />

      <div className="list-table">
        <div className="list-table-format title">
          <b>Documento</b>
          <b>Nombre</b>
          <b>Apellido</b>
          <b>Correo</b>
          <b>Teléfono</b>
          <b>Dirección</b>
          <b>Nickname</b>
          <b>Tipo</b>
        </div>
        {filteredUsers.length === 0 ? (
          <p>No se encontraron usuarios que coincidan.</p>
        ) : (
          filteredUsers.map(user => (
            <div key={user._id} className='list-table-format'>
              <p>{user.docUsuario || '-'}</p>
              <p>{user.nombreUsuario}</p>
              <p>{user.apellidoUsuario}</p>
              <p>{user.correoUsuario}</p>
              <p>{user.telefonoUsuario || '-'}</p>
              <p>{user.direccionUsuario || '-'}</p>
              <p>{user.nickname || '-'}</p>
              <p>{user.tipoUsuario || '-'}</p>
              <p style={{ color: user.estadoUsuario ? 'green' : 'red' }}>
                {user.estadoUsuario ? "Activo" : "Inactivo"}
              </p>
              <p>
                <button
                  onClick={() => handleEdit(user)}
                  style={{
                    padding: '5px 10px',
                    cursor: 'pointer',
                    borderRadius: '4px',
                    border: '1px solid #007bff',
                    backgroundColor: '#007bff',
                    color: 'white'
                  }}
                >
                  Editar
                </button>
              </p>
            </div>
          ))
        )}
      </div>

      {/* Modal para editar usuario */}
      {isModalOpen && (
        <div className="modal-overlay" style={{
          position: 'fixed',
          top:0, left:0, right:0, bottom:0,
          backgroundColor: 'rgba(0,0,0,0.5)',
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          zIndex: 9999
        }}>
          <div style={{
            backgroundColor: 'white',
            padding: '20px',
            borderRadius: '8px',
            width: '90%',
            maxWidth: '500px',
            maxHeight: '90vh',
            overflowY: 'auto'
          }}>
            <h3>Editar Usuario</h3>

            {/* Mensaje de éxito */}
            {successMessage && (
              <p style={{ color: 'green', marginBottom: '15px' }}>{successMessage}</p>
            )}

            <form onSubmit={handleSubmit}>
              <label>
                Documento:
                <input
                  type="text"
                  name="docUsuario"
                  value={formData.docUsuario}
                  onChange={handleChange}
                />
              </label>

              <label>
                Nombre:
                <input
                  type="text"
                  name="nombreUsuario"
                  value={formData.nombreUsuario}
                  onChange={handleChange}
                  required
                />
              </label>

              <label>
                Apellido:
                <input
                  type="text"
                  name="apellidoUsuario"
                  value={formData.apellidoUsuario}
                  onChange={handleChange}
                  required
                />
              </label>

              <label>
                Correo:
                <input
                  type="email"
                  name="correoUsuario"
                  value={formData.correoUsuario}
                  onChange={handleChange}
                  required
                />
              </label>

              <label>
                Teléfono:
                <input
                  type="text"
                  name="telefonoUsuario"
                  value={formData.telefonoUsuario}
                  onChange={handleChange}
                />
              </label>

              <label>
                Dirección:
                <input
                  type="text"
                  name="direccionUsuario"
                  value={formData.direccionUsuario}
                  onChange={handleChange}
                />
              </label>

              <label>
                Nickname:
                <input
                  type="text"
                  name="nickname"
                  value={formData.nickname}
                  onChange={handleChange}
                />
              </label>

              <label>
                Tipo:
                <select
                  name="tipoUsuario"
                  value={formData.tipoUsuario}
                  onChange={handleChange}
                  required
                >
                  <option value="">-- Seleccione --</option>
                  <option value="Administrador">Administrador</option>
                  <option value="Vendedor">Vendedor</option>
                  <option value="Repartidor">Repartidor</option>
                </select>
              </label>

              <label style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                Estado:
                <input
                  type="checkbox"
                  name="estadoUsuario"
                  checked={formData.estadoUsuario}
                  onChange={handleChange}
                />
                {formData.estadoUsuario ? "Activo" : "Inactivo"}
              </label>

              <div style={{ marginTop: '15px', display: 'flex', justifyContent: 'flex-end', gap: '10px' }}>
                <button type="button" onClick={handleCloseModal} style={{ padding: '6px 12px' }}>
                  Cancelar
                </button>
                <button type="submit" style={{
                  padding: '6px 12px',
                  backgroundColor: '#007bff',
                  color: 'white',
                  border: 'none',
                  cursor: 'pointer',
                  borderRadius: '4px'
                }}>
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

export default User;
