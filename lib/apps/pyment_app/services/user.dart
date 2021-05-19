import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values["id"]).set(values);
  }

  void updateDetails(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values["id"]).update(values);
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
