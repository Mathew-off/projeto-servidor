const { format, subDays, subMonths } = require('date-fns');
const{connection} = require ('./configBD')
const {app} = require ('./app')

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
    const { nome, data_manutencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manutencao,modelo_marca,tipo_conserto } = req.body;
    connection.query('INSERT INTO manutencao (nome, data_manutencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manutencao,modelo_marca,tipo_conserto) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [nome, data_manutencao, data_previsao, custo,detalhes,observacoes,lugar,tipo_manutencao,modelo_marca,tipo_conserto], (err, result) => {
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
app.post('/filtro', (req , res) => {
    const { nome, lugar, tipo_manutencao, modelo_marca, periodo } = req.body; 
    // Inicializa a consulta e os valores
    let sql = 'SELECT * FROM manutencao WHERE 1=1'; // "1=1" é uma condição sempre verdadeira para facilitar a concatenação
    let values = [];

    // Função auxiliar para adicionar condições dinamicamente
    const addCondition = (field, value) => {
        if (value) {
            sql += ` AND ${field} = ?`;
            values.push(value);
        }
};
    
// Adiciona condições de filtros adicionais
addCondition('nome', nome);
addCondition('lugar', lugar);
addCondition('tipo_manutencao', tipo_manutencao);
addCondition('modelo_marca', modelo_marca);
// Função auxiliar para adicionar condições de data relativa
const addRelativeDateCondition = (field, period) => {
let startDate;
const today = new Date();
switch (period) {
    case 'ultimos_7_dias':
        startDate = subDays(today, 7);
        break;
    case 'ultimos_15_dias':
        startDate = subDays(today, 15);
        break;
    case 'ultimos_30_dias':
        startDate = subDays(today, 30);
        break;
    case 'ultimos_3_meses':
        startDate = subMonths(today, 3);
        break;
    case 'ultimos_6_meses':
        startDate = subMonths(today, 6);
        break;
    case 'ultimos_12_meses':
        startDate = subMonths(today, 12);
        break;
    default:
        startDate = null;
    }
    if (startDate) {
        sql += ` AND ${field} >= ?`;
        values.push(format(startDate, 'yyyy-MM-dd')); // Ajuste o formato da data conforme necessário
    }
};

// Adiciona filtro de data relativa
    if (periodo) {
        addRelativeDateCondition('data_manutencao', periodo);
    }

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
    res.json(rows); // Retorna todas as linhas encontradas
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