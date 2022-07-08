class User {
  late final String fullName;
  late final String email;
  late final String avatar;

  User({required this.fullName, required this.email, required this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}
