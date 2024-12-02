const jwt = require('jsonwebtoken');
require('dotenv').config();
function verifyToken(req, res, next) {
    const token = req.headers['authorization']?.split(' ')[1]; // Obtém o token do cabeçalho

    if (!token) {
        return res.status(403).json({ error: 'Token não fornecido' });
    }

    // Verifica a validade do token
    jwt.verify(token, 'suaChaveSecreta', (err, decoded) => {
        if (err) {
            return res.status(401).json({ error: 'Token inválido' });
        }

        req.user = decoded; // Armazena as informações do usuário no req.user
        next(); // Passa para o próximo middleware ou rota
    });
}

module.exports = verifyToken;