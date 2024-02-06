class User {
  int? id;
  String name;
  int age;
  String batchNo;
  String email;

  User(
      {required this.age,
      required this.name,
      required this.batchNo,
      required this.email,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      batchNo: json['batch_no'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'batch_no': batchNo,
      'email': email
    };
  }
}
