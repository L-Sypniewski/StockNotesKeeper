import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:stock_notes/model/stock_note.dart';

import '../stock_database.dart';
import 'firestore_auth_data.dart';

class FirestoreNotesDatabase extends StockDatabase {
  @override
  void add(StockNote note) {}

  @override
  List<StockNote> read(String stockCompany) {}

  FirestoreNotesDatabase() {
    initializeApp(
        apiKey: FirebaseAuthData.apiKey,
        authDomain: FirebaseAuthData.authDomain,
        databaseURL: FirebaseAuthData.databaseURL,
        projectId: FirebaseAuthData.projectId,
        storageBucket: FirebaseAuthData.storageBucket);

    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection("notes");

    ref.onSnapshot.listen((querySnapshot) {
      querySnapshot.docChanges().forEach((change) {
        print('Added');
        print(change.doc.data());

        if (change.type == "added") {
          // Do something with change.doc
        }
      });
    });
  }
}
