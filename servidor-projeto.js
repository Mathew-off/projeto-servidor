const express = require('express');
const mysql = require('mysql');
const app = express();
const port = 3000;
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
// Middleware para permitir que o Express interprete JSON
app.use(express.json());
// Listar todos as manuntenções
app.get('/manuntencao', (req, res) => {
    connection.query('SELECT * FROM manuntencao', (err, rows) => {
    if (err) {
    console.error('Erro ao executar a consulta:', err);
    res.status(500).send('Erro interno do servidor');
    return;
    }
    res.json(rows);
    });
    });
// Buscar uma manuntenção pelo ID
app.get('/manuntencao/:id', (req, res) => {
    const manunId = req.params.id;
    connection.query('SELECT * FROM manuntencao WHERE id = ?', [manunId], (err, rows) => {
    if (err) {
    console.error('Erro ao executar a consulta:', err);
    res.status(500).send('Erro interno do sistema');
    
    return;
    }
    if (rows.length === 0) {
    res.status(404).send('Manuntenção não encontrado');
    return;
    }
    res.json(rows[0]);
    });
    });
// Deletar uma manuntenção
app.delete('/manuntencao/:id', (req, res) => {
    const manunId = req.params.id;
    connection.query('DELETE FROM manuntencao WHERE id = ?', [manunId], (err, result) => {
    if (err) {
    console.error('Erro ao deletar manuntenção:', err);
    res.status(500).send('Erro interno do sistema');
    return;
    }
    
    res.send('Manuntenção deletada com sucesso');
    });
    });
// Criar um novo aluno
app.post('/manuntencao', (req, res) => {
    const { nome, data_manuntencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manuntencao,modelo_marca,tipo_conserto } = req.body;
    connection.query('INSERT INTO manuntencao (nome, data_manuntencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manuntencao,modelo_marca,tipo_conserto) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    [nome, data_manuntencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manuntencao,modelo_marca,tipo_conserto], (err, result) => {
    if (err) {
    console.error('Erro ao inserir a Manuntenção:', err);
    res.status(500).send('Erro interno do sistema!');
    return;
    }
    res.status(201).send('Manuntenção salva com sucesso');
    });
    });
//Pagina não encontrada
app.get('*',(req,res) => {
        res.send(`Pagina não encontrada `);
    });
// Iniciar o servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
    });
