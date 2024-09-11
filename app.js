const express = require('express');
const port = 3000;
const app = express();

// Iniciar o servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
    });
// Middleware para permitir que o Express interprete JSON
app.use(express.json());
module.exports = {app}