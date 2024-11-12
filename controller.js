const{connection} = require ('./configBD')
const {app} = require ('./app')
const { addCondition, addRelativeDateCondition } = require('./utils');
const bcrypt = require('bcrypt');

// Listar todos as manuntenções
app.get('/manutencao', (req, res) => {
    connection.query('SELECT * FROM manutencao', (err, rows) => {
        if (err) {
            console.error('Erro ao executar a consulta:', err);
            res.status(500).send('Erro interno do servidor');
            return;
        }
        res.json(rows);
    });
});

// Endpoint de registro (cadastro de novo usuário)
app.post('/cadastro', (req, res) => {
    const { nomeUser, email, senha  } = req.body;
  
    // Verifica se o email já existe
    const query = 'SELECT * FROM cadastro WHERE email = ?';
    connection.query(query, [email], (err, results) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
  
      if (results.length > 0) {
        return res.status(400).json({ error: 'Email já cadastrado' });
      }
  
      // Hash da senha antes de salvar no banco
      bcrypt.hash(senha, 10, (err, hashedSenha) => {
        if (err) return res.status(500).json({ error: err.message });
  
        // Criação do novo usuário no banco de dados
        const insertQuery = 'INSERT INTO cadastro (nomeUser, email, senha) VALUES (?, ?, ?)';
        connection.query(insertQuery, [nomeUser,email, hashedSenha], (err, results) => {
          if (err) {
            return res.status(500).json({ error: err.message });
          }
  
          res.status(201).json({ message: 'Usuário criado com sucesso' });
        });
      });
    });
  });  

// Listar todos os profissionais
app.get('/profissional', (req, res) => {
    connection.query('SELECT DISTINCT nome FROM manutencao', (err, rows) => {
        if (err) {
            console.error('Erro ao executar a consulta:', err);
            res.status(500).send('Erro interno do servidor');
            return;
        }
        res.json(rows);
    });
});

// Listar todos os lugares
app.get('/lugar', (req, res) => {
    connection.query('SELECT lugar nome FROM manutencao', (err, rows) => {
        if (err) {
            console.error('Erro ao executar a consulta:', err);
            res.status(500).send('Erro interno do servidor');
            return;
        }
        res.json(rows);
    });
});

// Buscar uma manutenção pelo ID
app.get('/manutencao/:id', (req, res) => {
    const manunId = req.params.id;
    connection.query('SELECT * FROM manutencao WHERE id = ?', [manunId], (err, rows) => {
        if (err) {
            console.error('Erro ao executar a consulta:', err);
            res.status(500).send('Erro interno do sistema');     
            return;
        }
        if (rows.length === 0) {
            res.status(404).send('Manutenção não encontrado');
            return;
        }
        res.json(rows[0]);
    });
});

// Cadastrar nova manutenção
app.post('/manutencao', (req, res) => {
    const { nome, data_manutencao, data_previsao, custo, detalhes, observacoes, lugar, tipo_manutencao, modelo_marca, tipo_conserto } = req.body;
    connection.query('INSERT INTO manutencao (nome, data_manutencao, data_previsao, custo, detalhes, observacoes, lugar, tipo_manutencao, modelo_marca, tipo_conserto) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [nome, data_manutencao, data_previsao, custo, detalhes, observacoes, lugar, tipo_manutencao, modelo_marca, tipo_conserto], (err, result) => {
        if (err) {
            console.error('Erro ao inserir a Manutenção:', err);
            res.status(500).send('Erro interno do sistema!');
            return;
        }
        res.status(201).send('Manutenção salva com sucesso');
    });
});


// Atualizar informações de uma manutençao
app.put('/manutencao/:id', (req, res) => {
    const manunID = req.params.id;
    const {nome, data_manutencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manutencao,modelo_marca,tipo_conserto} = req.body;
    connection.query('UPDATE manutencao SET nome = ?, data_manutencao = ?, data_previsao = ?, custo = ?, detalhes = ?, observacoes = ?, lugar = ?, tipo_manutencao = ?, modelo_marca = ?, tipo_conserto = ? WHERE id = ?', 
        [nome, data_manutencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manutencao,modelo_marca,tipo_conserto, manunID], (err, result) => {
        if (err) {
            console.error('Erro ao atualizar Manutenção:', err);
            res.status(500).send('Erro interno do servidor');
            return;
        }
        res.send('Manutenção atualizado com sucesso');
    });
});

// Filtrar manutenções
app.post('/filtro', (req, res) => {
    const { nome, lugar, tipo_manutencao, modelo_marca, periodo } = req.body; 

    let sql = 'SELECT * FROM manutencao WHERE 1=1'; 
    let values = [];

    // Adiciona condições de filtros adicionais usando a função importada
    ({ sql, values } = addCondition(sql, values, 'nome', nome));
    ({ sql, values } = addCondition(sql, values, 'lugar', lugar));
    ({ sql, values } = addCondition(sql, values, 'tipo_manutencao', tipo_manutencao));
    ({ sql, values } = addCondition(sql, values, 'modelo_marca', modelo_marca));

    // Adiciona filtro de data relativa usando a função importada
    if (periodo) {
        ({ sql, values } = addRelativeDateCondition(sql, values, 'data_manutencao', periodo));
    }

    // Ordena os resultados por data em ordem decrescente
    sql += ' ORDER BY data_manutencao DESC';

    // Executa a consulta com os valores dinamicamente gerados
    connection.query(sql, values, (err, rows) => {
        if (err) {
            console.error('Erro ao executar a consulta:', err);
            res.status(500).send('Erro interno do sistema');
            return;
        }
        if (rows.length === 0) {
            res.status(404).send('Manutenção não encontrada');
            return;
        }
        res.json(rows); 
    });
});

// Deletar uma manutenção
app.delete('/manutencao/:id', (req, res) => {
    const manunId = req.params.id;
    connection.query('DELETE FROM manutencao WHERE id = ?', [manunId], (err, result) => {
        if (err) {
            console.error('Erro ao deletar manutenção:', err);
            res.status(500).send('Erro interno do sistema');
            return;
        }
        res.send('Manutenção deletada com sucesso');
        });
    });
    
//Pagina não encontrada
app.get('*',(req,res) => {
    res.send(`Pagina não encontrada `);
});