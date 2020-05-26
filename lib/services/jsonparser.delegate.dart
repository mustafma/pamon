import 'package:BridgeTeam/Model/Survey/survey.answer.model.dart';
import 'package:BridgeTeam/Model/Survey/survey.question.model.dart';

class JsonParserDelegate {
  SurveyQuestionModel getQuestionFromJson(
      Map<String, dynamic> data, bool isFromServer) {
    String question = data["question"];
    String type = data["selection_type"];
    String id = data["survey_id"];
    List<SurveyAnswerModel> answers = List();
    if (isFromServer) {
      data["answers"].forEach((each) {
        answers.add(SurveyAnswerModel(answer: each));
      });
    }
    return SurveyQuestionModel(question, answers, type, id)
      ..questionId = data["id"];
  }
}
JsonParserDelegate jsonParserDelegate = JsonParserDelegate();