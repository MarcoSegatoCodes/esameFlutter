class Person {
  Person({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumbers,
  });

  String firstName;
  String lastName;
  String email;
  List<String> phoneNumbers;
}

final List<Person> people = [
  Person(
    firstName: "Brocco",
    lastName: "Letto",
    email: 'bloccoletto123@brmail.bro',
    phoneNumbers: ["1234567890"],
  ),
];
