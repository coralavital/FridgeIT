import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List> readProducts() async {
    QuerySnapshot querySnapshot;
    List document = [];

    try {
      querySnapshot =
          await _firestore.collection('${_auth.currentUser?.uid}').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          if (doc.id == "user_data") {
            document = doc['products'];
          }
        }
        return document;
      }
    } catch (e) {
      print(e);
    }
    return document;
  }

  Future<List> readShoppingList() async {
    QuerySnapshot querySnapshot;
    List document = [];

    try {
      querySnapshot =
          await _firestore.collection('${_auth.currentUser?.uid}').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          if (doc.id == "user_data") {
            document = doc['shopping_list'];
          }
        }
        return document;
      }
    } catch (e) {
      print(e);
    }
    return document;
  }

  Future<void> addToShoppingList(
      String name, String image, int quantity) async {
    try {
      await _firestore
          .collection('${_auth.currentUser?.uid}')
          .doc("user_data")
          .update(
        {
          'shopping_list': FieldValue.arrayUnion([
            {"name": name, "image": image, "quantity": quantity}
          ])
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> addItemToProduct(List doc, int index) async {
    doc.elementAt(index)['quantity'] += 1;
    try {
      await _firestore
          .collection('${_auth.currentUser?.uid}')
          .doc("user_data")
          .update(
        {'shopping_list': doc},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeItemToProduct(List doc, int index) async {
    doc.elementAt(index)['quantity'] -= 1;
    if (doc.elementAt(index)['quantity'] > 0) {
      try {
        await _firestore
            .collection('${_auth.currentUser?.uid}')
            .doc("user_data")
            .update(
          {'shopping_list': doc},
        );
      } catch (e) {
        print(e);
      }
    } else if (doc.elementAt(index)['quantity'] <= 0) {
      doc.remove(doc.elementAt(index));
      try {
        await _firestore
            .collection('${_auth.currentUser?.uid}')
            .doc("user_data")
            .update(
          {'shopping_list': doc},
        );
      } catch (e) {
        print(e);
      }
    }
  }
}