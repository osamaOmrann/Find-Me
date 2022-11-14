class MissingPerson {
  static const String collectionName = 'Missing Person';
  String? id, name, adress, desc;
  int? age;
  DateTime? dateTime;
  bool? isFound;

  MissingPerson(
      {this.id,
      this.name,
      this.adress,
      this.desc,
      this.age,
      this.dateTime,
      this.isFound});

  MissingPerson.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            name: data['name'],
            adress: data['adress'],
            desc: data['desc'],
            age: data['age'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            isFound: data['isFound']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'adress': adress,
      'desc': desc,
      'age': age,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isFound': isFound
    };
  }
}