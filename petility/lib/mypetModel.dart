class MyPetModel {
  String id;
  String name;
  String pet;
  String breed;
  String age;
  String sex;

  MyPetModel({this.id, this.name, this.pet, this.breed, this.age, this.sex});

  factory MyPetModel.fromJson(Map<String, dynamic> json) {
    return MyPetModel(
      id: json['id'],
      name: json['name'],
      pet: json['pet'],
      breed: json['breed'],
      age: json['age'],
      sex: json['sex']
    );
  }
}
