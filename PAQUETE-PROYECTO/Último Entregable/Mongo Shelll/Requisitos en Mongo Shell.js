//Inactivar un Stock(RQF003)
db.Stock.updateOne({codigoStock:5},{$set:{estadoStock:0}})

//Generar Factura (RQF006)
db.facturaVenta.insertOne({codigoFactura: 2, totalFactura: 50000,  iva: 10000, fEntrega: new Date("2025-12-15"),  fReparto: new Date("2025-12-16"), estadoPago: "Pendiente",  medioPago: "Tarjeta", direccionEnv: "Calle 101 #10-12", precioEnv: 5000,  descripcionFact: "Factura por productos de oficina",estadoFactura: 1,  idClienteFK: ObjectId("682bd9f282d45eb1e6097698"), idUsuarioFK: ObjectId("682bd80582d45eb1e609770a"), cantidad: 2 });

//Hacer Visualización de las Facturas
db.facturaVenta.aggregate([
  {
    // Unir la Cliente con facturaVenta por idClienteFK
    $lookup: {
      from: "Cliente",                   
      localField: "idClienteFK",          
      foreignField: "_id",                
      as: "clienteDetalles"               
    }
  },
  {
    // Unir la Usuario con facturaVenta por idUsuarioFK
    $lookup: {
      from: "Usuario",                  
      localField: "idUsuarioFK",          
      foreignField: "_id",             
      as: "usuarioDetalles"               
    }
  },
  {
    // acceder a los campos directamente
    $unwind: "$clienteDetalles"
  },
  {
    // acceder a los campos directamente
    $unwind: "$usuarioDetalles"
  },
  {
    // campos que queremos factura, cliente y usuario
    $project: {
      _id: 0,
      codigoFactura: 1,
      totalFactura: 1,
      iva: 1,
      estadoPago: 1,
      medioPago: 1,
      direccionEnv: 1,
      descripcionFact: 1,
      fEntrega: 1,
      fReparto: 1,
      clienteNombre: { $concat: ["$clienteDetalles.nombreCliente", " ", "$clienteDetalles.apellidoCliente"] },
      clienteDoc: "$clienteDetalles.docCliente",
      usuarioNombre: { $concat: ["$usuarioDetalles.nombreUsuario", " ", "$usuarioDetalles.apellidoUsuario"] },
      usuarioDoc: "$usuarioDetalles.docUsuario"
    }
  }
]);

//Inactiva Factura (RQF007)
db.facturaVenta.updateOne({codigoFactura:1},{$set:{estadoFactura:0}});

//Consultar envío por fecha de reparto (RQF013)
db.facturaVenta.find({fReparto:{$gte:new Date("2025-12-01"),$lte:new Date("2025-12-31")}});

//Consultar venta por fecha de entrega (RQF016)
db.facturaVenta.find({fEntrega:{$gte:new Date("2025-12-01"),$lte:new Date("2025-12-31")}});

//Consultar factura por email (RQF017)
db.facturaVenta.aggregate([{$lookup:{from:"Cliente",localField:"idClienteFK",foreignField:"_id",as: "clienteDetalles"}},{$match:{"clienteDetalles.correoCliente":"luciaperez@hotmail.com"}}]);

//Consultar el total de las facturas de manera descendente (RQF018)
db.facturaVenta.find().sort({totalFactura:-1});

//Inactivar clientes (RQF022)
db.Cliente.updateOne({docCliente:1023456788},{$set:{estadoCliente:false}});;

//Modificar estado de pago Factura (RQF023)
db.facturaVenta.updateOne({codigoFactura:21},{$set:{estadoPago:"Pendiente"}});

//Asignar tipo de cliente (RQF024)
db.Cliente.updateOne({docCliente:1023456788},{$set:{tipoCliente:"Jurídico"}});

//Consultar clientes con más productos comprados (RQF026)
db.facturaVenta.aggregate([{$unwind:"$productos"},{$group:{id:"$idClienteFK",totalComprado:{$sum:"$productos.cantidad"}}},{$sort:{totalComprado:-1}},{$limit:5}]);

//Consultar factura por estado de pago (RQF027)
db.facturaVenta.find({estadoPago:"Completado"});

//Inactivar usuario (RQF029)
db.Usuario.updateOne({docUsuario:52123456},{$set:{estadoUsuario:false}});

//Modificar factura (RQF030)
db.facturaVenta.updateOne({codigoFactura:32},{$set:{fReparto:new Date("2025-04-13")}});

//Actualización de Stock (RQF031)
db.Stock.updateOne({codigoStock:31},{$set:{cantidadDisponible:20}});


