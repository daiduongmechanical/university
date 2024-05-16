class Mark {
  String? name;
  int? normalMark;
  int? middleMark;
  int? finalMark;
  int? averageMark;
  int? semester;
  int? year;
  String? classData;
  String? teacher;

  Mark(
      {this.name,
        this.normalMark,
        this.middleMark,
        this.finalMark,
        this.averageMark,
        this.semester,
        this.year,
        this.classData,
        this.teacher});

  Mark.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    normalMark = json['normal_mark'];
    middleMark = json['middle_mark'];
    finalMark = json['final_mark'];
    averageMark = json['average_mark'];
    semester = json['semester'];
    year = json['year'];
    classData = json['class_data'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['normal_mark'] = this.normalMark;
    data['middle_mark'] = this.middleMark;
    data['final_mark'] = this.finalMark;
    data['average_mark'] = this.averageMark;
    data['semester'] = this.semester;
    data['year'] = this.year;
    data['class_data'] = this.classData;
    data['teacher'] = this.teacher;
    return data;
  }
}
