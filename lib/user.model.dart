class UserModel {
  final String name;
  final int age;
  final String gender;

  const UserModel({
    required this.name,
    required this.age,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'],
      age: data['age'],
      gender: data['gender'],
    );
  }
}

Map<String, dynamic> user = {'name': "Hameed", 'age': 40, 'gender': 'Male'};

// user.name - WRONG

// user['name'] - "Hameed"