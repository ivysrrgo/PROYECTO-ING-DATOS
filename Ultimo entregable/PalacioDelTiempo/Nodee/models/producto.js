const { text } = require('body-parser');
const mongoose = require('mongoose');
const ProductoSchema = new mongoose.Schema({
    codigoProducto: String,
    nombreProducto: String,
    precioProducto: Number,
    cantidadProducto: Number,
    descripcionProducto: String,
    estadoProducto: Boolean,
    imagen: {
    type: String, // solo el nombre de archivo
    default: ''
  }
});

module.exports = mongoose.model('Producto', ProductoSchema);