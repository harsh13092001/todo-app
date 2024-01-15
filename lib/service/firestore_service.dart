import "package:cloud_firestore/cloud_firestore.dart";

class FireStoreService {
  var firebaseClassInstance = FirebaseFirestore.instance.collection("User");
  createTask(String userEmail, Map<String, String> taskDetails, String title) {
    firebaseClassInstance
        .doc(userEmail)
        .collection("task")
        .doc(title)
        .set(taskDetails);
  }

  editTask(String userEmail, Map<String, String> taskDetails, String title) {
    firebaseClassInstance
        .doc(userEmail)
        .collection("task")
        .doc(title)
        .update(taskDetails);
  }
  deleteTask(String userEmail, String title){
    firebaseClassInstance
        .doc(userEmail)
        .collection("task")
        .doc(title).delete();

  }
  getTaskList(String userEmail) {
    return firebaseClassInstance.doc(userEmail).collection("task").snapshots();
  }
}
