import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/user_model.dart';

class AuthController extends GetxController {

  //==========================================================signin
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  //==========================================================signup

  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Rx<TextEditingController> nameController = TextEditingController().obs;

  Rx<TextEditingController> signUPEmail = TextEditingController().obs;
  Rx<TextEditingController> signUPPass = TextEditingController().obs;
  signIn()async{
try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.value.text,
    password: passwordController.value.text
  );
  if (credential.user !=null) {
    // Get.toNamed();

  }else{
    Get.snackbar("Error", "user null");
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  }
  //=========================================================================sign up method
  signUP()async{
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: signUPEmail.value.text,
    password: signUPPass.value.text,
  );
  if (credential.user != null) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final myUser = DataModel(
      // image: curentUser.photoURL.toString(),
        name: nameController.value.text,
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: credential.user!.uid,
        pushToken: "",
      
        email: signUPEmail.value.text);
    return await firebaseFirestore
        .collection("Users")
        .doc(credential.user!.uid)
        .set(myUser.toJson()).then((value){
          print("=============================================She");
        });
  }else{

          print("=============================================jamal");
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print("=====================error ${e.toString()}");
}
  }

}
