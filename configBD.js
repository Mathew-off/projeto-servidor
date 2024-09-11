const mysql = require('mysql');
// Configuração do banco de dados

const connection = mysql.createConnection({
    host: 'localhost',
    port: 3306, // Porta padrão do MySQL
    user: 'root',
    password: '', // Substitua 'sua_senha' pela senha do seu banco de dados
    database: 'controladores_de_temperatura'
    });
// Conexão com o banco de dados
connection.connect((err) => {
    if (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    throw err;
    }
    console.log('Conexão bem-sucedida ao banco de dados');
    });
module.exports = {connection}