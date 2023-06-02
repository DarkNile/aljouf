class User {
  final dynamic id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? token;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['customer_id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      email: json['email'],
      phone: json['telephone'],
      token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': id,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'telephone': phone,
      'access_token': token,
    };
  }
}
