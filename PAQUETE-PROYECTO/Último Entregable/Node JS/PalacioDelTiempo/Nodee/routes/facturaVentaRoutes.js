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

// Ruta para actualizar estadoPago de una factura
router.put('/facturas/actualizar-estado-pago/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { estadoPago } = req.body;

    if (!estadoPago) {
      return res.status(400).json({ error: 'Debe enviar el nuevo estado de pago' });
    }

    const factura = await facturaVenta.findByIdAndUpdate(
      id,
      { estadoPago: estadoPago }
    );

    if (factura) {
      res.status(200).json({ message: 'Estado de pago actualizado correctamente' });
    } else {
      res.status(404).json({ message: 'Factura no encontrada' });
    }
  } catch (error) {
    console.error('Error al actualizar estado de pago:', error);
    res.status(500).json({ error: 'Error al actualizar estado de pago' });
  }
});

// Consultar facturas por estado de pago
router.get('/facturas/estado-pago/:estado', async (req, res) => {
  try {
    const { estado } = req.params;

    const facturas = await facturaVenta.find({ estadoPago: estado });

    if (facturas.length === 0) {
      return res.status(404).json({ message: 'No se encontraron facturas con ese estado de pago' });
    }

    res.status(200).json(facturas);
  } catch (error) {
    console.error('Error al consultar facturas por estado de pago:', error);
    res.status(500).json({ error: 'Error al consultar facturas por estado de pago' });
  }
});


// Consultar todas las facturas ordenadas por totalFactura descendente
router.get('/facturas/orden-total-desc', async (req, res) => {
  try {
    const facturas = await facturaVenta.find().sort({ totalFactura: -1 });
    res.status(200).json(facturas);
  } catch (error) {
    console.error('Error al obtener facturas ordenadas:', error);
    res.status(500).json({ error: 'Error al obtener facturas ordenadas' });
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

// Ruta para actualizar información de una factura por su ID
router.put('/factura/actualizar/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body; 
        const factura = await facturaVenta.findByIdAndUpdate(
            id,
            updates
        );
        if (factura) {
            res.status(200).json({ message: 'Factura actualizada exitosamente' });
        } else {
            res.status(404).json({ message: 'Factura no encontrada' });
        }
    } catch (error) {
        console.error('Error al actualizar factura:', error);
        res.status(500).json({ error: 'Error al actualizar factura' });
    }
});

// Ruta para consultar los productos enviados en una venta
router.get('/factura/productos/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const factura = await facturaVenta.findById(id)
            .populate('productos.codigoStock'); // Trae la info del Stock referenciado

        if (factura) {
            res.status(200).json({
                productos: factura.productos
            });
        } else {
            res.status(404).json({ message: 'Factura no encontrada' });
        }
    } catch (error) {
        console.error('Error al consultar productos de la factura:', error);
        res.status(500).json({ error: 'Error al consultar productos de la factura' });
    }
});


// Ruta para inactivar una factura por su ID
router.put('/factura/inactivar/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const factura = await facturaVenta.findByIdAndUpdate(
            id,
            { estadoFactura: false }
        );
        if (factura) {
            res.status(200).json({ message: 'Factura inactivada exitosamente' });
        } else {
            res.status(404).json({ message: 'Factura no encontrada' });
        }
    } catch (error) {
        console.error('Error al inactivar factura:', error);
        res.status(500).json({ error: 'Error al inactivar factura' });
    }
});
module.exports = router;
