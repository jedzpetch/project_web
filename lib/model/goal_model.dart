class GoalModel {
  double? goalBMI;
  double? goalBMR;
  double? goalTDEE;
  double? goalCal;
  double? goalBurn;
  double? goalWeight;
  double? goalDay;
  String? goalStartDate;
  String? goalEndDate;

  GoalModel({
    this.goalBMI,
    this.goalBMR,
    this.goalTDEE,
    this.goalCal,
    this.goalBurn,
    this.goalWeight,
    this.goalDay,
    required this.goalStartDate,
    required this.goalEndDate,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      goalBMI: json['goalBMI'],
      goalBMR: json['goalBMR'],
      goalTDEE: json['goalTDEE'],
      goalCal: json['goalCal'],
      goalBurn: json['goalBurn'],
      goalWeight: json['goalWeight'],
      goalDay: json['goalDay'],
      goalStartDate: json['goalStartDate'],
      goalEndDate: json['goalEndDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        "goalBMI": goalBMI,
        "goalBMR": goalBMR,
        "goalTDEE": goalTDEE,
        "goalCal": goalCal,
        "goalBurn": goalBurn,
        "goalWeight": goalWeight,
        "goalDay": goalDay,
        'goalStartDate': goalStartDate,
        'goalEndDate': goalEndDate,
      };
}
