const nodemailer = require('nodemailer');

// Create a Nodemailer transporter
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'vitoria.pereirac@ufpe.br',
    pass: 'Mvitori22'
  }
});

// Function to send email
const sendEmail = async (user) => {
  try {
    // Email template with placeholders for user's name and ID
    const emailTemplate = `
      <p>Hello ${user.fullname},</p>
      <p>Bem vindo à nossa plataforma! Seu código para login é: ${user.id}</p>
      <p>Obrigada por se juntar a nós.</p>
    `;

    // Email options
    const mailOptions = {
      from: 'mvitoriapereirac@gmail.com',
      to: user.email,
      subject: 'Welcome to Our Platform',
      html: emailTemplate
    };

    // Send email
    const info = await transporter.sendMail(mailOptions);
    console.log('Email sent:', info.response);
  } catch (error) {
    console.error('Error sending email:', error);
  }
};

module.exports = { sendEmail };
