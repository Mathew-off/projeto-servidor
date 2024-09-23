const { format, subDays, subMonths } = require('date-fns');

// Função auxiliar para adicionar condições dinamicamente
const addCondition = (sql, values, field, value) => {
    if (value) {
        sql += ` AND ${field} = ?`;
        values.push(value);
    }
    return { sql, values };
};

// Função auxiliar para adicionar condições de data relativa
const addRelativeDateCondition = (sql, values, field, period) => {
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
    return { sql, values };
};

module.exports = {
    addCondition,
    addRelativeDateCondition
};