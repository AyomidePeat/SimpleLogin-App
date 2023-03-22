class UserDetails {
  String name;
  UserDetails({required this.name});
  Map<String, dynamic> toJson() => {'name': name};

  factory UserDetails.fromJson({ Map<String, dynamic>? json}) {
    return UserDetails(name: json!['name']);
  }
}
