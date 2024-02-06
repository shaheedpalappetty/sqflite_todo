class User {
  String name;
  int age;
  String batchNo;

  User({required this.age, required this.name, required this.batchNo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      age: json['age'] as int,
      batchNo: json['batchNo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'batchNo': batchNo,
    };
  }
}
