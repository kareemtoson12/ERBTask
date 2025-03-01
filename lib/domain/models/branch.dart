class Branch {
  int? id;
  String name;
  String address;
  String email;
  String phoneNumber;

  Branch({
    this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
  });

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  // from json
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
