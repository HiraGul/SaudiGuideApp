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

  Map<String, dynamic> toJson() => {
        "userAge": userAge,
        "gender": gender,
        "userLocation": userLocation,
        "monthlyIncome": monthlyIncome,
        "nationality": nationality,
        "country": country,
        "purpose": purpose
      };

  // UserData.fromJson(Map<String, dynamic> json) {
  //   userAge = json['userAge'];
  //   gender = json['gender'];
  //   userLocation = json['userLocation'];
  //   monthlyIncome = json['monthlyIncome'];
  //   country = json['country'];
  //   purpose = json['purpose'];
  // }
}
