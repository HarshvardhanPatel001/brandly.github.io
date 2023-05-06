class BusinessModel {
  String companyname;
  String companyemail;
  String companyweb;
  String companylogo;
  String createdAt;
  String companyadress;
  String companydescription;
  String uid;

  BusinessModel({
    required this.companyname,
    required this.companyemail,
    required this.companyweb,
    required this.companylogo,
    required this.createdAt,
    required this.companyadress,
    required this.companydescription,
    required this.uid,
  });

  // from map
  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      companyname: map['companyname'] ?? '',
      companyemail: map['companyemail'] ?? '',
      companyweb: map['companyweb'] ?? '',
      uid: map['uid'] ?? '',
      companyadress: map['companyadress'] ?? '',
      companydescription: map['companydescription'] ?? '',
      createdAt: map['createdAt'] ?? '',
      companylogo: map['companylogo'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "companyname": companyname,
      "companyemail": companyemail,
      "uid": uid,
      "companyweb": companyweb,
      "companylogo": companylogo,
      "companyadress": companyadress,
      "companydescription": companydescription,
      "createdAt": createdAt,
    };
  }
}
