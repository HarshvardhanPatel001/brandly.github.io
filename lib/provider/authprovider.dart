import 'dart:convert';
import 'dart:io';

import 'package:brandly_01/model/business_model.dart';
import 'package:brandly_01/model/user_model.dart';
import 'package:brandly_01/Screen/auth/otp.dart';
import 'package:brandly_01/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  BusinessModel? _businessModel;
  BusinessModel get businessModel => _businessModel!;

  List<BusinessModel> _bussiness = [];
  List<BusinessModel> get bussiness => _bussiness;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
    getDataFromFirestore();
    // getBusinessDataFromFirestore();
  }

  Future checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;

    notifyListeners();
    return print(_isSignedIn);
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // signin
  void signInWithPhone(
      BuildContext context, String phoneNumber, String phno) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  verificationId: verificationId,
                  phone: phno,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

// business data
  void saveBusinessDataToFirebase({
    required BuildContext context,
    required BusinessModel businessModel,
    required File businesslogo,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    // notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeBusinesFileToStorage(
              "businessPic/${userModel.phoneNumber}/${DateTime.now()}",
              businesslogo)
          .then((value) {
        businessModel.companylogo = value;
        businessModel.createdAt =
            DateTime.now().millisecondsSinceEpoch.toString();
        businessModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      bussiness.add(businessModel);
      _bussiness = bussiness;
      _businessModel = businessModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("business")
          .add(businessModel.toMap())
          // .doc(_uid).collection('business').doc()
          // .set(businessModel.toMap())
          .then((value) {
        onSuccess();
        bussiness.add(businessModel);
        getBusinessDataFromFirestore();
        _isLoading = false;
        // notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      // notifyListeners();
    }
  }

//bussiness logo
  Future<String> storeBusinesFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//profile pic
  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

// get users data
  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = userModel.uid;
    });
  }

// get business data
  Future getBusinessDataFromFirestore() async {
    try {
      final List<BusinessModel> bussinessget = [];
      var response = await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("business")
          .get();
      print(response.docs);
      if (response.docs.length > 0) {
        response.docs.forEach((result) async {
          print(result.data());
          print("Product ID  ${result.id}");

          bussinessget.add(BusinessModel(
              companyname: result['companyname'],
              companyemail: result['companyemail'],
              companyweb: result['companyweb'],
              companylogo: result['companylogo'],
              createdAt: result['createdAt'],
              companyadress: result['companyadress'],
              companydescription: result['companydescription'],
              uid: uid));
        });
      }
      bussiness.addAll(bussinessget);
      //   .then((DocumentSnapshot snapshot) {
      // _businessModel = BusinessModel(
      //     companyname: snapshot['companyname'],
      //     companyemail: snapshot['companyemail'],
      //     createdAt: snapshot['createdAt'],
      //     uid: snapshot['uid'],
      //     companylogo: snapshot['companylogo'],
      //     companyweb: snapshot['companyweb'],
      //     companyadress: snapshot['companyadress'],
      //     companydescription: snapshot['companydescription']);
      // _uid = businessModel.uid;
      // });
    } catch (error) {
      print(error);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  // STORING BUSINESS DATA LOCALLY
  Future saveBusinessUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("business_model", jsonEncode(businessModel.toMap()));
  }

//get user data locally
  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

//get business data locally
  Future getBusinessDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("business_model") ?? '';
    _businessModel = BusinessModel.fromMap(jsonDecode(data));
    _uid = _businessModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  Future EditName(name) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({"name": name}).then((_) {});
      await getDataFromFirestore();
      await saveUserDataToSP();
      print(userModel.name);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      // print(error);
    }
  }

  Future EditProfilePic(File businesslogo) async {
    _isLoading = true;
    notifyListeners();
    await storeUpdetedProfileToStorage("updetedprofile/$_uid", businesslogo)
        .then((value) {
      userModel.profilePic = value;
      // businessModel.createdAt =
      //     DateTime.now().millisecondsSinceEpoch.toString();
      userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
    });
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({"profilePic": userModel.profilePic}).then((_) {});
      await getDataFromFirestore();
      await saveUserDataToSP();
      print(userModel.profilePic);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<String> storeUpdetedProfileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
