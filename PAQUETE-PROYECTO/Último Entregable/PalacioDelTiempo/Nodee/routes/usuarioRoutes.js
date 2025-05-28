  // routes/usuarios.js
  const express = require('express');
  const router = express.Router();
  const bcrypt = require('bcrypt');
  const jwt = require('jsonwebtoken');
  const Usuario = require('../models/Usuario');
  require('dotenv').config();

  const JWT_SECRET = process.env.JWT_SECRET;

  // Insertar varios usuarios
  router.post('/insertarUsuarios', async (req, res) => {
    try {
      const usuarios = req.body;
      if (!Array.isArray(usuarios)) {
        return res.status(400).json({ mensaje: 'El cuerpo debe ser un arreglo de usuarios' });
      }

      const usuariosEncriptados = await Promise.all(
        usuarios.map(async (usuario) => {
          const hashedPassword = await bcrypt.hash(usuario.password, 10);
          return { ...usuario, password: hashedPassword };
        })
      );

      const usuariosGuardados = await Usuario.insertMany(usuariosEncriptados, { ordered: false });
      res.status(201).json(usuariosGuardados);
    } catch (error) {
      res.status(400).json({ mensaje: 'Error al guardar los usuarios', error });
    }
  });

  // Obtener todos los usuarios
  router.get('/usuarios', async (req, res) => {
    try {
      const usuarios = await Usuario.find().select('-password');
      res.status(200).json(usuarios);
    } catch (error) {
      res.status(500).json({ mensaje: 'Error al obtener los usuarios', error });
    }
  });

 // Registro
router.post('/register', async (req, res) => {
  try {
    const {
      docUsuario,          // <-- Agregado aquí
      nombreUsuario,
      apellidoUsuario,
      correoUsuario,
      password,
      telefonoUsuario,
      direccionUsuario,
      nickname,
      estadoUsuario = true,
      tipoUsuario
    } = req.body;

    // Validar el correo electrónico formato
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(correoUsuario)) {
      return res.status(400).json({ mensaje: 'Formato de correo electrónico inválido' });
    }

    // Validar contraseña fuerte
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
    if (!passwordRegex.test(password)) {
      return res.status(400).json({ mensaje: 'Contraseña débil. Debe tener mínimo 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.' });
    }

    // Validar documento de identidad único (opcional pero recomendado)
    if (docUsuario) {
      const docExistente = await Usuario.findOne({ docUsuario });
      if (docExistente) {
        return res.status(400).json({ mensaje: 'El Documento de Identidad ya está registrado' });
      }
    }

    // Verificar si el correo ya está registrado
    const usuarioExistente = await Usuario.findOne({ correoUsuario });
    if (usuarioExistente) {
      return res.status(400).json({ mensaje: 'El correo ya está registrado' });
    }

    // Encriptar la contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    // Crear un nuevo usuario
    const nuevoUsuario = new Usuario({
      docUsuario,      // <-- Guardar docUsuario
      nombreUsuario,
      apellidoUsuario,
      correoUsuario,
      password: hashedPassword,
      telefonoUsuario,
      direccionUsuario,
      nickname,
      estadoUsuario,
      tipoUsuario
    });

    await nuevoUsuario.save();
    res.status(201).json({ mensaje: 'Usuario registrado exitosamente' });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al registrar el usuario', error });
  }
});


  // Login
  router.post('/login', async (req, res) => {
    try {
      const { correoUsuario, password } = req.body;

      const usuario = await Usuario.findOne({ correoUsuario });
      if (!usuario) {
        return res.status(400).json({ mensaje: 'Correo o contraseña incorrectos' });
      }

      const passwordValida = await bcrypt.compare(password, usuario.password);
      if (!passwordValida) {
        return res.status(400).json({ mensaje: 'Correo o contraseña incorrectos' });
      }

      const token = jwt.sign(
        { id: usuario._id, correo: usuario.correoUsuario, tipo: usuario.tipoUsuario },
        JWT_SECRET,
        { expiresIn: '2h' }
      );

      const usuarioSinPassword = usuario.toObject();
      delete usuarioSinPassword.password;

      res.status(200).json({ mensaje: 'Inicio de sesión exitoso', token, usuario: usuarioSinPassword });
    } catch (error) {
      res.status(500).json({ mensaje: 'Error al iniciar sesión', error });
    }
  });

  // Middleware de autenticación
  function verificarToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    if (!authHeader) return res.status(401).json({ mensaje: 'Token no proporcionado' });

    const token = authHeader.split(' ')[1];
    if (!token) return res.status(401).json({ mensaje: 'Token mal formado' });

    try {
      const decoded = jwt.verify(token, JWT_SECRET);
      req.usuario = decoded;
      next();
    } catch (error) {
      res.status(401).json({ mensaje: 'Token inválido' });
    }
  }

  // Ruta protegida de ejemplo
  router.get('/perfil', verificarToken, async (req, res) => {
    try {
      const usuario = await Usuario.findById(req.usuario.id).select('-password');
      if (!usuario) return res.status(404).json({ mensaje: 'Usuario no encontrado' });
      res.status(200).json(usuario);
    } catch (error) {
      res.status(500).json({ mensaje: 'Error al obtener perfil', error });
    }
  });


  // Cambiar contraseña
  router.post('/change-password', async (req, res) => {
    try {
      const { correoUsuario, password, nuevaPassword } = req.body;

      const usuario = await Usuario.findOne({ correoUsuario });
      if (!usuario) {
        return res.status(400).json({ mensaje: 'Usuario no encontrado' });
      }

      const passwordValida = await bcrypt.compare(password, usuario.password);
      if (!passwordValida) {
        return res.status(400).json({ mensaje: 'Contraseña actual incorrecta' });
      }

      // Validar nueva contraseña fuerte
      const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
      if (!passwordRegex.test(nuevaPassword)) {
        return res.status(400).json({ mensaje: 'La nueva contraseña es débil. Debe tener mínimo 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.' });
      }

      const hashedNuevaPassword = await bcrypt.hash(nuevaPassword, 10);
      usuario.password = hashedNuevaPassword;

      await usuario.save();

      res.status(200).json({ mensaje: 'Contraseña cambiada exitosamente' });
    } catch (error) {
      res.status(500).json({ mensaje: 'Error al cambiar la contraseña', error });
    }
  });

  router.put('/usuarios/:id', async (req, res) => {
  try {
    const usuario = await Usuario.findById(req.params.id);
    if (!usuario) return res.status(404).json({ mensaje: 'Usuario no encontrado' });

    const {
      docUsuario,
      nombreUsuario,
      apellidoUsuario,
      estadoUsuario,
      correoUsuario,
      telefonoUsuario,
      direccionUsuario,
      nickname,
      password,
      tipoUsuario
    } = req.body;

    // Validar correo si se actualiza
    if (correoUsuario && correoUsuario !== usuario.correoUsuario) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(correoUsuario)) {
        return res.status(400).json({ mensaje: 'Formato de correo electrónico inválido' });
      }
      // Verificar si el correo ya está en uso por otro usuario
      const correoExistente = await Usuario.findOne({ correoUsuario });
      if (correoExistente && correoExistente._id.toString() !== req.params.id) {
        return res.status(400).json({ mensaje: 'El correo ya está registrado por otro usuario' });
      }
      usuario.correoUsuario = correoUsuario;
    }

    if (docUsuario !== undefined) usuario.docUsuario = docUsuario;
    if (nombreUsuario !== undefined) usuario.nombreUsuario = nombreUsuario;
    if (apellidoUsuario !== undefined) usuario.apellidoUsuario = apellidoUsuario;
    if (estadoUsuario !== undefined) usuario.estadoUsuario = estadoUsuario;
    if (telefonoUsuario !== undefined) usuario.telefonoUsuario = telefonoUsuario;
    if (direccionUsuario !== undefined) usuario.direccionUsuario = direccionUsuario;
    if (nickname !== undefined) usuario.nickname = nickname;
    if (tipoUsuario !== undefined) usuario.tipoUsuario = tipoUsuario;

    // Validar y actualizar contraseña si viene
    if (password) {
      const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
      if (!passwordRegex.test(password)) {
        return res.status(400).json({ mensaje: 'La contraseña es débil. Debe tener mínimo 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.' });
      }
      usuario.password = await bcrypt.hash(password, 10);
    }

    await usuario.save();

    const usuarioObj = usuario.toObject();
    delete usuarioObj.password;

    res.status(200).json({ mensaje: 'Usuario actualizado correctamente', usuario: usuarioObj });

  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al actualizar usuario', error });
  }
});

  module.exports = router;
