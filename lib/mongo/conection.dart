// import 'dart:convert';
// import 'dart:developer';

// import 'const.dart';
// import 'package:mongo_dart/mongo_dart.dart';

// class Mogodatabase {
//   // List<String> imagess = [];

//   static connect() async {
//     var db = await Db.create(MONGO_URL);
//     await db.open();
//     inspect(db);
//     var status = db.serverStatus();
//     print(status);
//   }

//   // static addMyBusiness(companyname, companyadress, companyemail,
//   //     companydescription, companyweb, companylogo, createdAt) async {
//   //   var db = await Db.create(MONGO_URL);
//   //   await db.open();
//   //   inspect(db);
//   //   var business = db.collection(buisness);
//   //   await business.insertOne({
//   //     "companyname": companyname,
//   //     "companyadress": companyadress,
//   //     "companyemail": companyemail,
//   //     "companydescription": companydescription,
//   //     "companyweb": companyweb,
//   //     "companylogo": companylogo,
//   //     "createdAt": createdAt,
//   //   });
//   //   print(".........................");
//   //   var get = await business.find().toList();
//   //   print(get);

//   //   var jsonResponse = json.decode('$get');

//   //   var id = jsonResponse;
//   //   var companyName;
//   //   var companyAddress;
//   //   var companyEmail;
//   //   var companyDescription;
//   //   var companyWeb;
//   //   var companyLogo;
//   //   var createdat;
//   //   for (final item in jsonResponse) {
//   //     id = jsonResponse[item]['_id'];
//   //     companyName = jsonResponse[item]['companyname'];
//   //     companyAddress = jsonResponse[item]['companyadress'];
//   //     companyEmail = jsonResponse[item]['companyemail'];
//   //     companyDescription = jsonResponse[item]['companydescription'];
//   //     companyWeb = jsonResponse[item]['companyweb'];
//   //     companyLogo = jsonResponse[item]['companylogo'];
//   //     createdat = jsonResponse[item]['createdAt'];
//   //   }

//   //   print(companyDescription);
//   // }

//   static slider() async {
//     var db = await Db.create(MONGO_URL);
//     await db.open();
//     inspect(db);
//     var slider = db.collection(imgslider);

//     List<String> imagees = [
//       "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
//       "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
//       "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
//       "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
//       "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
//       "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
//     ];
//     for (int i = 0; i < imagees.length; i++) {
//       final imageUrl = imagees[i];
//       final imageDocument = {'url': imageUrl};
//       await slider.insert(imageDocument);
//     }

//     print(".........................");
//     var get = await slider.find().toList();
//     print(get);

//     var jsonResponse = json.decode('$get');
//   }

//   // static callslider() async {
//   //   var db = await Db.create(MONGO_URL);
//   //   await db.open();
//   //   inspect(db);
//   //   var slider = db.collection(imgslider);

//   //   var get = await slider.find().toList();
//   //   print(get);

//   //   var jsonResponse = json.decode('$get');
//   // }
// }
