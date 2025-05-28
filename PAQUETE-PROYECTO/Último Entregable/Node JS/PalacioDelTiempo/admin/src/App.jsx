import React from 'react';
import Navbar from './components/Navbar/Navbar'; // Ajusta la ruta según tu estructura
import Sidebar from './components/Sidebar/Sidebar'; // Ajusta también esta si aplica
import { Routes,Route } from 'react-router-dom';
import Add from './pages/Add/Add'
import List from './pages/List/List';
import User from './pages/Usuarios/User';
import Cliente from './pages/Cliente/Cliente';


const App = () => {
  return (
    <div>
      <Navbar />
      <hr />
      <div className="app-content">
        <Sidebar />
        <Routes>
          <Route path="/add" element={<Add/>}/>
          <Route path="/list" element={<List/>}/>
          <Route path="/user" element={<User/>}/>
          <Route path="/cliente" element={<Cliente/>}/>
        </Routes>
      </div>
    </div>
  );
};

export default App;
