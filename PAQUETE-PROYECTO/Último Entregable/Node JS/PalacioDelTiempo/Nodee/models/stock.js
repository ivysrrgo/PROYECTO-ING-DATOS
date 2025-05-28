const { text } = require('body-parser');
const mongoose = require('mongoose');
const StockSchema = new mongoose.Schema({

    idProductoFK: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Producto'
    },
    cantidadDisponible: Number,
    estadoStock: Boolean

});

module.exports = mongoose.model('Stock', StockSchema);