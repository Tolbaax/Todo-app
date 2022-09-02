import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/note_model.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constant.dart';

class Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  addNote({required TaskModel taskModel}) async {
    await users.doc(uId).collection('tasks').add(taskModel.toJson());
  }

  getAllTasks() {
    return users.doc(uId).collection('tasks').snapshots();
  }

  deleteNote({id, title}) {
    users.doc(uId).collection('tasks').doc(id).delete();
    showToast(text: '${title} Deleted', state: ToastState.error);
  }

}
