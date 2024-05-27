class User {
  String? firstName;
  String? lastName;
  String? email;
  String? birthdate;
  String? gender;
  String? password;
  String? profilePic;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.password,
    required this.profilePic,
  });

  // Dari JSON ke model User
  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    password = json['password'];
    profilePic = json['profilePic'];
  }

  // Dari model User ke JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthdate': birthdate,
      'gender': gender,
      'password': password,
      'profilePic': profilePic,
    };
  }
}
