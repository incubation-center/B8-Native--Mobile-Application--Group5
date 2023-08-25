const admin = require('firebase-admin');
const serviceAccount = require('../../firebase.json'); // Replace with the actual path

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

export default admin;
