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

// Consultar clientes por nombre (búsqueda parcial, insensible a mayúsculas)
router.get('/clientes/nombre/:nombre', async (req, res) => {
    try {
        const { nombre } = req.params;

        const clientes = await Cliente.find({
            nombreCliente: { $regex: nombre, $options: 'i' } // 'i' = No importan las mayusulas
        });

        if (clientes.length === 0) {
            return res.status(404).json({ message: 'No se encontraron clientes con ese nombre' });
        }

        res.status(200).json(clientes);
    } catch (error) {
        console.error('Error al consultar clientes por nombre:', error);
        res.status(500).json({ error: 'Error al consultar clientes por nombre' });
    }
});


// Consultar cliente por número de documento
router.get('/clientes/documento/:docCliente', async (req, res) => {
    try {
        const { docCliente } = req.params;
        const cliente = await Cliente.findOne({ docCliente: docCliente });

        if (!cliente) {
            return res.status(404).json({ message: 'Cliente no encontrado' });
        }

        res.status(200).json(cliente);
    } catch (error) {
        console.error('Error al consultar cliente por documento:', error);
        res.status(500).json({ error: 'Error al consultar cliente por documento' });
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

// Ruta para inactivar un cliente por ID
router.put('/clientes/inactivar/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const cliente = await Cliente.findByIdAndUpdate(
      id,
      { estado: false }
    );

    if (cliente) {
      res.status(200).json({ message: 'Cliente inactivado exitosamente' });
    } else {
      res.status(404).json({ message: 'Cliente no encontrado' });
    }
  } catch (error) {
    console.error('Error al inactivar cliente:', error);
    res.status(500).json({ error: 'Error al inactivar cliente' });
  }
});


module.exports = router;
