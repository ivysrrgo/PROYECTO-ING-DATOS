const express = require('express');
const router = express.Router();
const Producto = require('../models/Producto');
const multer = require('multer');
const fs = require('fs');
const path = require('path');

const storage = multer.diskStorage({
    destination: "uploads",
    filename: (req, file, cb) => {
        return cb(null, `${Date.now()}${file.originalname}`);
    }
});

const upload = multer({ storage: storage });

// Ruta para añadir un nuevo producto
router.post('/add-producto', upload.single('imagen'), async (req, res) => {
    try {
        const {
            codigoProducto,
            nombreProducto,
            precioProducto,
            cantidadProducto,
            descripcionProducto,
            estadoProducto,
            categoriaProducto  // ← agregado aquí
        } = req.body;

        const nuevoProducto = new Producto({
            codigoProducto,
            nombreProducto,
            precioProducto,
            cantidadProducto,
            descripcionProducto,
            estadoProducto: estadoProducto === 'true' || estadoProducto === true,
            categoriaProducto  // ← agregado aquí
        });

        if (req.file) {
            nuevoProducto.imagen = req.file.filename;
        }

        await nuevoProducto.save();
        res.status(201).json({ success: true, message: 'Producto agregado exitosamente.' });
    } catch (error) {
        console.error('Error al agregar producto:', error);
        res.status(500).json({ success: false, message: 'Error del servidor.' });
    }
});


// Ruta para insertar varios productos
router.post('/insertarProduc', async (req, res) => {
    try {
        const productos = req.body;
        if (!Array.isArray(productos)) {
            return res.status(400).json({ mensaje: 'El cuerpo debe ser un arreglo de productos' });
        }

        const productosGuardados = await Producto.insertMany(productos);
        res.status(201).json(productosGuardados);
    } catch (error) {
        res.status(400).json({ mensaje: 'Error al guardar los productos', error });
    }
});

// Ruta para obtener todos los productos
router.get('/productos', async (req, res) => {
    try {
        const productos = await Producto.find();
        res.status(200).json(productos);  // ← devuelve directamente el array
    } catch (error) {
        res.status(500).json({ mensaje: 'Error al obtener los productos', error });
    }
});

// Eliminar un producto y su imagen
router.delete('/delete/:id', async (req, res) => {
    try {
        const producto = await Producto.findById(req.params.id);

        if (!producto) {
            return res.status(404).json({ mensaje: "Producto no encontrado" });
        }

        if (producto.imagen) {
            const rutaImagen = path.join(__dirname, '..', 'uploads', producto.imagen);
            console.log('Intentando eliminar la imagen en:', rutaImagen);
            try {
                await fs.promises.unlink(rutaImagen);
                console.log('Imagen eliminada:', producto.imagen);
            } catch (err) {
                console.warn('No se pudo eliminar la imagen:', err.message);
            }
        }

        await Producto.findByIdAndDelete(req.params.id);

        res.status(200).json({ mensaje: "Producto e imagen eliminados correctamente" });
    } catch (error) {
        res.status(500).json({ mensaje: "Error al eliminar producto", error: error.message });
    }
});


// Ruta para actualizar un producto (con posible imagen)
router.put('/update/:id', upload.single('imagen'), async (req, res) => {
    try {
        const producto = await Producto.findById(req.params.id);
        if (!producto) return res.status(404).json({ mensaje: "Producto no encontrado" });

        // Actualizar campos
        producto.codigoProducto = req.body.codigoProducto;
        producto.nombreProducto = req.body.nombreProducto;
        producto.categoriaProducto = req.body.categoriaProducto;
        producto.precioProducto = req.body.precioProducto;
        producto.cantidadProducto = req.body.cantidadProducto;
        producto.descripcionProducto = req.body.descripcionProducto;
        producto.estadoProducto = (req.body.estadoProducto === 'true' || req.body.estadoProducto === true);

        // Si envían una nueva imagen, eliminar la antigua y guardar la nueva
        if (req.file) {
            // eliminar imagen antigua si existe
            if (producto.imagen) {
                const rutaImagen = path.join(__dirname, '..', 'uploads', producto.imagen);
                try {
                    await fs.promises.unlink(rutaImagen);
                } catch (err) {
                    console.warn('No se pudo eliminar la imagen antigua:', err.message);
                }
            }
            producto.imagen = req.file.filename;
        }

        await producto.save();
        res.status(200).json({ mensaje: 'Producto actualizado correctamente' });

    } catch (error) {
        console.error(error);
        res.status(500).json({ mensaje: 'Error al actualizar producto', error });
    }
});

module.exports = router;
