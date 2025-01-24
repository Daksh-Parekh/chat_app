class UserModal {
  String? uid, name, email, password, image;

  UserModal(
      {required String uid,
      required this.name,
      required this.email,
      required this.password,
      required this.image});

  factory UserModal.fromMap(Map m1) {
    return UserModal(
        uid: m1['uid'],
        name: m1['name'],
        email: m1['email'],
        password: m1['password'],
        image: m1['image']);
  }

  Map<String, dynamic> get toMap => {
        'uid': uid,
        'name': name,
        'email': email,
        'password': password,
        'image': image,
      };
}
