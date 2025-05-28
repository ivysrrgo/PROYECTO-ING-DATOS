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
module.exports = router;
