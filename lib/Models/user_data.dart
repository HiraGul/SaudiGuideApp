class UserData {
  String userAge;
  String gender;
  String userLocation;
  String monthlyIncome;
  String nationality;
  String country;
  String purpose;

  UserData(this.country, this.gender, this.monthlyIncome, this.nationality,
      this.purpose, this.userAge, this.userLocation);

  Map<String, dynamic> toJson() =>
      {
        "userAge": userAge,
        "gender": gender,
        "userLocation": userLocation,
        "monthlyIncome": monthlyIncome,
        "nationality": nationality,
        "country": country,
        "purpose": purpose
      };

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      json['country'],
      json['gender'],
      json['monthlyIncome'],
      '',
      json['purpose'],
      json['userAge'],
      json['userLocation'],);

  }
}
