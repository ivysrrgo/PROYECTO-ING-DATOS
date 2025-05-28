// Archivo: routes/cliente.js

const express = require('express');
const router = express.Router();
const Cliente = require('../models/cliente');  // Cambiar nombre a Cliente

// Insertar varios clientes
router.post('/clientes/insertarClientes', async (req, res) => {
    try {
        const clientes = req.body; // array de clientes
        const result = await Cliente.insertMany(clientes);
        res.status(201).json(result);
    } catch (error) {
        console.error('Error al insertar clientes:', error);
        res.status(500).json({ error: 'Error al insertar clientes' });
    }
});

// Obtener todos los clientes
router.get('/clientes', async (req, res) => {
    try {
        const clientes = await Cliente.find();
        res.status(200).json(clientes);
    } catch (error) {
        console.error('Error al obtener clientes:', error);
        res.status(500).json({ error: 'Error al obtener clientes' });
    }
});

// Crear nuevo cliente
router.post('/clientes', async (req, res) => { 
  try {
    const nuevoCliente = new Cliente(req.body);
    const savedCliente = await nuevoCliente.save();
    res.status(201).json(savedCliente);
  } catch (error) {
    console.error('Error al crear cliente:', error);
    res.status(500).json({ error: 'Error al crear cliente' });
  }
});

// Actualizar cliente por ID
router.put('/clientes/:id', async (req, res) => {
  try {
    const updatedCliente = await Cliente.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!updatedCliente) {
      return res.status(404).json({ error: 'Cliente no encontrado' });
    }
    res.json(updatedCliente);
  } catch (error) {
    console.error('Error al actualizar cliente:', error);
    res.status(500).json({ error: 'Error al actualizar cliente' });
  }
});

module.exports = router;
