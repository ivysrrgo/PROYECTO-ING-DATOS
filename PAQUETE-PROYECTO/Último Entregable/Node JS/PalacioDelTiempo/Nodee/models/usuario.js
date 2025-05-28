// usuarioSchema.js
const mongoose = require('mongoose');

const usuarioSchema = new mongoose.Schema({
  docUsuario: {
    type: String, // Mejor usar String para documentos que pueden tener ceros a la izquierda o caracteres especiales
    required: false
  },
  nombreUsuario: {
    type: String,
    required: true
  },
  apellidoUsuario: {
    type: String,
    required: true
  },
  estadoUsuario: {
    type: Boolean,
    default: true
  },
  correoUsuario: {
    type: String,
    required: true,
    unique: true
  },
  telefonoUsuario: {
    type: String, // Usar String para teléfonos
    required: false
  },
  direccionUsuario: {
    type: String,
    required: false
  },
  nickname: {
    type: String,
    required: false
  },
  password: {
    type: String,
    required: true
  },
  tipoUsuario: {
    type: String,
    enum: ['Administrador', 'Vendedor', 'Repartidor'],
    required: true
  }
});

module.exports = mongoose.model('Usuario', usuarioSchema);
