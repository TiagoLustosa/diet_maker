enum Gender { MALE, FEMALE }

class BasalMetabolicRateModel {
  int age;
  int height;
  double weight;
  double result;
  Gender gender = Gender.MALE;
  BasalMetabolicRateModel({
    this.age,
    this.weight,
    this.height,
  });
}
