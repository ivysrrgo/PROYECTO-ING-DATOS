const express = require('express');
const router = express.Router();
const Stock = require('../models/stock'); // <-- ESTA LÍNEA FALTABA

// Ruta para insertar varios stock
router.post('/insertarStock', async (req, res) => {
    try {
        const stock = req.body; 
        const result = await Stock.insertMany(stock);
        res.status(201).json(result);
    } catch (error) {
        console.error('Error al insertar stock:', error);
        res.status(500).json({ error: 'Error al insertar stock' });
    }
});

// Ruta para obtener todos los stock
router.get('/stock', async (req, res) => {
    try {
        const stock = await Stock.find();
        res.status(200).json(stock);
    } catch (error) {
        console.error('Error al obtener stock:', error);
        res.status(500).json({ error: 'Error al obtener stock' });
    }
});
// Ruta para consultar stock de un producto específico
router.get('/stock/:idProductoFK', async (req, res) => {
    try {
        const { idProductoFK } = req.params;
        const stock = await Stock.findOne({ idProductoFK: idProductoFK });
        if (stock) {
            res.status(200).json(stock);
        } else {
            res.status(404).json({ message: 'Stock no encontrado para ese producto' });
        }
    } catch (error) {
        console.error('Error al obtener stock del producto:', error);
        res.status(500).json({ error: 'Error al obtener stock del producto' });
    }
});

// Ruta para inactivar un stock por su ID (sin { new: true })
router.put('/stock/inactivar/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const stock = await Stock.findByIdAndUpdate(
            id,
            { estadoStock: false }
        );
        if (stock) {
            res.status(200).json({ message: 'Stock inactivado exitosamente' });
        } else {
            res.status(404).json({ message: 'Stock no encontrado' });
        }
    } catch (error) {
        console.error('Error al inactivar stock:', error);
        res.status(500).json({ error: 'Error al inactivar stock' });
    }
});

// Actualizar stock por ID
router.put('/stock/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { cantidadDisponible, estadoStock } = req.body;

    const stockActualizado = await Stock.findByIdAndUpdate(
      id,
      { cantidadDisponible, estadoStock },
      // { new: true } // Opcional para devolver el documento actualizado
    );

    if (!stockActualizado) {
      return res.status(404).json({ message: 'Stock no encontrado' });
    }

    res.status(200).json({ message: 'Stock actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar stock:', error);
    res.status(500).json({ error: 'Error al actualizar stock' });
  }
});

module.exports = router;
