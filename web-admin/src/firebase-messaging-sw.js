importScripts("https://www.gstatic.com/firebasejs/9.1.3/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.1.3/firebase-messaging-compat.js");
firebase.initializeApp({
    apiKey: "AIzaSyB6uKjGB3KgkDMs4345BpKLc2FjGliNb90",
    authDomain: "hita-live.firebaseapp.com",
    projectId: "hita-live",
    storageBucket: "hita-live.appspot.com",
    messagingSenderId: "270485872707",
    appId: "1:270485872707:web:86c1b8371eec1c69ccb4f6",
    measurementId: "G-VWR2VKNX3V"
});
const messaging = firebase.messaging();