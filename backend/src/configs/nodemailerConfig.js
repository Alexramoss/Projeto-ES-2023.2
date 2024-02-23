const nodemailer = require('nodemailer');
const DBConnection = require('../configs/connectDB');

const sendEmail = async (email, isStudent) => {
  try {
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'josemeloss01@gmail.com',
        pass: 'oktfqtnsvlfdlsnu',
      },
      tls: {
        rejectUnauthorized: false,
      },
    });

    const query = isStudent ? 'SELECT RASTUD FROM STUDENT WHERE email = ?' : 'SELECT RACOLLAB FROM COLLABORATOR WHERE email = ?';
    const [rows] = await DBConnection.query(query, [email]);

    if (rows.length === 0) {
      throw new Error('Usuário não encontrado.');
    }

    const identifier = rows[0][isStudent ? 'RASTUD' : 'RACOLLAB'];

    const mailOptions = {
      from: 'seuemail@gmail.com',
      to: email,
      subject: 'Bem vindo ao App',
      html: `<p>Seu identificador de login é: ${identifier}</p>`,
    };

    const info = await transporter.sendMail(mailOptions);
    console.log('E-mail enviado:', info.response);
  } catch (error) {
    console.error('Erro ao enviar e-mail:', error);
    throw new Error('Erro interno ao enviar e-mail.');
  }
};

module.exports = {
  sendEmail,
};