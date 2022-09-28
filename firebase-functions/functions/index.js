const functions = require("firebase-functions");
const admin = require('firebase-admin');
const request = require('request');
admin.initializeApp();

const db = admin.firestore();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.approvementWebhook = functions.https.onRequest((req, response) => {
  const data = JSON.parse(req.body);
  const userId = data.userId;
  const contactId = data.contactId;
  const approved = data.approved;

  console.log(`We got webhook to approve userId: ${userId}, contactId: ${contactId}, state: ${approved}`);
  db.doc(`users/${userId}/contacts/${contactId}`).update({state: approved ? "approved" : "failed"}).then(() => {
    console.log(`We have updated database`);
    response.send("Hello from Firebase!");
  });
});

function checkToTriggerVerify(newValue, context) {

  if (newValue.state === "initial") {
    console.log(`Habe to verfiy: birthday: ${newValue.birthday}, firstname: ${newValue.firstname}, lastname: ${newValue.lastname}, number: ${newValue.number}, state: ${newValue.state}. On user: ${context.params.userId} with id: ${context.params.contactId}`)

    sleep(1000);

    // SEND REQUEST TO THE GOVERNMENT
    const jsonData = {
      "contactId": context.params.contactId,
      "userId": context.params.userId,
      "url": "https://us-central1-contact-manager-9feff.cloudfunctions.net/approvementWebhook"
    }
    console.log("Send POST request to https://us-central1-contact-manager-9feff.cloudfunctions.net/approvementWebhook with " + JSON.stringify(jsonData));
    request({
      url: "https://us-central1-web-rtc-40073.cloudfunctions.net/govermentApprove",
      method: "POST",
      body: JSON.stringify(jsonData),
      headers: {"Content-Type": "text/plain"}
    }, function (error, response, body) {
      console.log(response);
    });

    // UPDATE THE DOC AS BEING VERIFIED
    return db.doc(`users/${context.params.userId}/contacts/${context.params.contactId}`).update({state: "approving"});

  } else {
    console.log(`Will not be verified: birthday: ${newValue.birthday}, firstname: ${newValue.firstname}, lastname: ${newValue.lastname}, number: ${newValue.number}, state: ${newValue.state}`)
  }
}

exports.createContact = functions.firestore
  .document('users/{userId}/contacts/{contactId}')
  .onCreate((snap, context) => {
    // Get an object representing the document
    checkToTriggerVerify(snap.data(), context);
    // perform desired operations ...
  });

exports.updateContact = functions.firestore
  .document('users/{userId}/contacts/{contactId}').onUpdate((change, context) => {
    // Get an object representing the document
    checkToTriggerVerify(change.after.data(), context);
    // perform desired operations ...
  });


function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e30; i++) {
    if ((new Date().getTime() - start) > milliseconds) {
      break;
    }
  }
}