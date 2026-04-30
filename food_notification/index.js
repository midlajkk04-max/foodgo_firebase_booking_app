const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendFoodNotification = functions.firestore
  .document("Food/{foodId}")
  .onCreate(async (snapshot, context) => {
    const foodData = snapshot.data();

    const usersSnapshot = await admin.firestore().collection("users").get();

    const tokens = [];

    usersSnapshot.forEach((doc) => {
      const token = doc.data().fcmToken;
      if (token) {
        tokens.push(token);
      }
    });

    if (tokens.length === 0) {
      console.log("No tokens found");
      return null;
    }

    const message = {
      notification: {
        title: "New Food Added 🍔",
        body: `${foodData.name} is now available`,
      },
      tokens: tokens,
    };

    return admin.messaging().sendEachForMulticast(message);
  });