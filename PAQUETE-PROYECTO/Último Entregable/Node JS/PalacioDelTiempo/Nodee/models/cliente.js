const { text } = require('body-parser');
const mongoose = require('mongoose');
const clienteSchema = new mongoose.Schema({
    docCliente: Number,
    nombreCliente: {
    type: String,
    required: true
  },
    estado: Boolean,
    correo: String,
    telefonoCliente: Number,
    direccionCliente: String,
    TipoCliente: String
});

module.exports = mongoose.model('Cliente', clienteSchema);