const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNewFoodNotification = onDocumentCreated(
  "Food/{foodId}",
  async (event) => {
    const food = event.data.data();

    const foodName = food.name || "New Food";

    await admin.messaging().send({
      topic: "new_food",
      notification: {
        title: "New Food Added 🍔",
        body: `${foodName} is now available`,
      },
    });
  }
);