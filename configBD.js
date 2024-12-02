require('dotenv').config(); // Carregue o dotenv antes de acessar as variáveis de ambiente
const mysql = require('mysql');

// Configuração do banco de dados
const connection = mysql.createConnection({
    host: process.env.BD_HOST,
    port: process.env.BD_PORT,
    user: process.env.BD_USER, 
    password: process.env.BD_PASSWORD, 
    database: process.env.BD_NAME 
});

// Conexão com o banco de dados
connection.connect((err) => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        throw err;
    }
    console.log('Conexão bem-sucedida ao banco de dados');
});

module.exports = { connection };
