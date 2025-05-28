const express = require('express');
const router = express.Router();
const facturaVenta = require('../models/facturaVenta');

// Crear factura
router.post('/', async (req, res) => {
  try {
    const nuevaFactura = new facturaVenta(req.body);
    const facturaGuardada = await nuevaFactura.save();
    res.status(201).json({ mensaje: 'Factura creada', facturaId: facturaGuardada._id });
  } catch (error) {
    console.error('Error al crear la factura:', error);
    res.status(500).json({ error: 'Error al crear la factura' });
  }
});

// Subtotal desde productos.productoFK.precio
router.get('/:id/subtotal', async (req, res) => {
  try {
    const factura = await facturaVenta.findById(req.params.id)
      .populate({
        path: 'productos.codigoStock',
        populate: {
          path: 'productoFK',
          model: 'Producto'
        }
      });

    if (!factura) return res.status(404).json({ error: 'Factura no encontrada' });

    const subtotal = factura.productos.reduce((acc, prod) => {
      const precioUnitario = prod.codigoStock?.productoFK?.precio || 0;
      return acc + precioUnitario * prod.cantidadProd;
    }, 0);

    res.json({ subtotal });
  } catch (error) {
    console.error('Error al obtener el subtotal:', error);
    res.status(500).json({ error: 'Error al obtener el subtotal' });
  }
});

// Total con IVA (19%)
router.get('/:id/total', async (req, res) => {
  try {
    const factura = await facturaVenta.findById(req.params.id)
      .populate({
        path: 'productos.codigoStock',
        populate: {
          path: 'productoFK',
          model: 'Producto'
        }
      });

    if (!factura) return res.status(404).json({ error: 'Factura no encontrada' });

    const subtotal = factura.productos.reduce((acc, prod) => {
      const precioUnitario = prod.codigoStock?.productoFK?.precio || 0;
      return acc + precioUnitario * prod.cantidadProd;
    }, 0);

    const total = subtotal * 1.19;
    res.json({ total });
  } catch (error) {
    console.error('Error al obtener el total:', error);
    res.status(500).json({ error: 'Error al obtener el total' });
  }
});

module.exports = router;
