const express = require('express');
const cors = require('cors');
const port = 3000;
const app = express();
require('dotenv').config();
// Iniciar o servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
    });

// Middleware para CORS
app.use(cors());

// Middleware para permitir que o Express interprete JSON
app.use(express.json());
module.exports = {app}