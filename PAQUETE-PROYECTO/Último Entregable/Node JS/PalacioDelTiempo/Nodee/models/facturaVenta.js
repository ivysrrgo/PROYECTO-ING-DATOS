const { text } = require('body-parser');
const mongoose = require('mongoose');
const facturaVentaSchema = new mongoose.Schema({
  descripcionFact: String,
  docClienteFK: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Cliente',
    required: true
  },
  docUsuarioFK: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Usuario',
    required: true
  },
  //almacenar más de un producto con el código de stock
  productos: [
    {
      codigoStock: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Stock',
        required: true
      },
      cantidadProd: {
        type: Number,
        required: true
      }
    }
  ],
  totalFactura: Number,
  fEntrega: Date,
  fReparto: Date,
  estadoPago: String,
  estadoFactura: Boolean,
  iva: Number,
  medioPago: String,
  direccionEnv: String,
  precioEnv: Number
});

module.exports = mongoose.model('facturaVenta', facturaVentaSchema);