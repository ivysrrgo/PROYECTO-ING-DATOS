require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');

const port = process.env.PORT;
const mongoUri = process.env.MONGO_URI;

// Rutas
const clienteRoutes = require('./routes/clienteRoutes');
const facturaVentaRoutes = require('./routes/facturaVentaRoutes');
const usuarioRoutes = require('./routes/usuarioRoutes');
const productoRoutes = require('./routes/productoRoutes');
const stockRoutes = require('./routes/stockRoutes');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Servir archivos estáticos desde /uploads
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Conexión a MongoDB
mongoose.connect(mongoUri, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => {
  console.log('Conectado a MongoDB');
}).catch(err => {
  console.error('Error al conectar a MongoDB', err);
});

// Uso de rutas
app.use('/cliente', clienteRoutes);
app.use('/facturaVenta', facturaVentaRoutes);
app.use('/usuario', usuarioRoutes);
app.use('/producto', productoRoutes);
app.use('/stock', stockRoutes);

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
