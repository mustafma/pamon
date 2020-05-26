class SurveyAnswerModel {
  String answer;
  String id;
  SurveyAnswerModel({this.answer, this.id});
  factory SurveyAnswerModel.fromMap(Map<dynamic, dynamic> data) {
    return SurveyAnswerModel(answer: data["answer"], id: data["id"]);
  }
  SurveyAnswerModel copyInstance() {
    return SurveyAnswerModel(answer: answer, id: id);
  }
}