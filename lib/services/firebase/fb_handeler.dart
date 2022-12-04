import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nearvegi/models/postmodel.dart';
import 'package:nearvegi/models/usermodel.dart';

import '../../constants/initdata.dart';

class FbHandeler {
  static final user = FirebaseAuth.instance.currentUser;
  static final firestoreInstance = FirebaseFirestore.instance;
  static final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  static const String chatboxpath = "chatbox";

//check doc is exists
  static Future<int> checkdocstatus(String collectionpath, String docid) async {
    var a = await FirebaseFirestore.instance
        .collection(collectionpath)
        .doc(docid)
        .get();
    if (a.exists) {
      return 1;
    } else if (!a.exists) {
      print('Not exists');
      return 0;
    } else {
      return 0;
    }
  }

// create doc random id;
  static Future<int> createDocAuto(
      Map<String, dynamic> model, String collectionpath) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc()
          .set(model)
          .then((_) {
        print("create  doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }

    return res;
  }

  // create doc manual id;
  static Future<int> createDocManual(
      Map<String, dynamic> model, String collectionpath, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc(docid)
          .set(model)
          .then((_) {
        print("create  doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }

    return res;
  }

//update doc
  static Future<int> updateDoc(
      Map<String, dynamic> model, String collectionpath, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc(docid)
          .update(model)
          .then((_) {
        print("update doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }
    return res;
  }

  //delete doc
  static Future<int> deletedoc(String collection, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance.collection(collection).doc(docid).delete();
      print("delete doc");
      res = resok;
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }
    return res;
  }

//get user details

  static Future<UserModel> getUser() async {
    String uid = user!.uid.toString();
    const String collectionpath = "/users/";
    UserModel model;

    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection(collectionpath).doc(uid).get();
    model = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return model;
  }

  static Future<UserModel> getUserid(String id) async {
    String uid = id;
    const String collectionpath = "/users/";
    UserModel model;

    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection(collectionpath).doc(uid).get();
    model = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return model;
  }

  //commiunity
  static Future<List<PostModel>> getallPost() async {
    List<PostModel> enlist = [];
    PostModel enmodel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(CollectionPath.postpath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      enmodel = PostModel.fromMap(a.data() as Map<String, dynamic>, a.id);
      enlist.add(enmodel);
      print("passed");
    }
    print(enlist);
    enlist.sort((a, b) => b.addeddate.compareTo(a.addeddate));
    return enlist;
  }

  static Future<List<PostModel>> getnearPost() async {
    final usr = await getUser();
    List<PostModel> enlist = [];
    enlist = await getfilterPost(city: usr.city, distric: usr.district);
    return enlist;
  }

  static Future<List<PostModel>> getfilterPost(
      {required String city, required String distric}) async {
    List<PostModel> enlist = [];
    List<PostModel> clist = [];
    List<PostModel> dlist = [];
    PostModel enmodel;
    if (distric == "All") {
      enlist = await getallPost();
    } else if (city == "All") {
      QuerySnapshot querySnapshot = await firestoreInstance
          .collection(CollectionPath.postpath)
          .where("dis", isEqualTo: distric)
          .get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        print(a.data());
        enmodel = PostModel.fromMap(a.data() as Map<String, dynamic>, a.id);
        enlist.add(enmodel);
      }
      enlist.sort((a, b) => b.addeddate.compareTo(a.addeddate));
      print("passed");
    } else {
      QuerySnapshot querySnapshot = await firestoreInstance
          .collection(CollectionPath.postpath)
          .where("dis", isEqualTo: distric)
          .get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        print(a.data());
        enmodel = PostModel.fromMap(a.data() as Map<String, dynamic>, a.id);
        if (enmodel.city == city) {
          clist.add(enmodel);
        } else {
          dlist.add(enmodel);
        }
        print("passed");
      }
      print(enlist);
      clist.sort((a, b) => b.addeddate.compareTo(a.addeddate));
      dlist.sort((a, b) => b.addeddate.compareTo(a.addeddate));
      enlist = clist + dlist;
    }
    return enlist;
  }

  static Future<List<PostModel>> getmyPost() async {
    List<PostModel> enlist = [];
    PostModel enmodel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(CollectionPath.postpath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      enmodel = PostModel.fromMap(a.data() as Map<String, dynamic>, a.id);
      if (enmodel.user.uid == user!.uid) {
        enlist.add(enmodel);
      }
      print("passed");
    }
    print(enlist);
    enlist.sort((a, b) => b.addeddate.compareTo(a.addeddate));
    return enlist;
  }

  static Future<List<UserModel>> getalluserspec(String r) async {
    List<UserModel> enlist = [];
    UserModel enmodel;
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection(CollectionPath.userpath)
        .where("role", isEqualTo: r)
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      enmodel = UserModel.fromMap(a.data() as Map<String, dynamic>);
      enlist.add(enmodel);
      print("passed");
    }
    print(enlist);
    enlist.sort((a, b) => b.name.compareTo(a.name));
    return enlist;
  }

//realtimedb
  static Future<int> checkfiledstatus(String collectionpath) async {
    final snapshot = await dbRef.child('$collectionpath').get();
    if (snapshot.exists) {
      return 0;
    } else {
      return 1;
    }
  }
}
