
import 'package:BridgeTeam/Model/Survey/survey.answer.model.dart';


class SurveyQuestionModel {
  
final String question;
 List<dynamic> answerModels = new List<SurveyAnswerModel>();

 // List<SurveyAnswerModel> answerModels ;
  final String selectionType; //single,multiple
  int selectedAnsIndexSingle;
  String surveyId;
  int questionId;
  List<int> selectedAnsIndexForMultiple = List();


  SurveyQuestionModel.fromMap(Map snapshot)
      :

        // documentID =  id,
        question = snapshot['question'],
        selectionType = snapshot['selection_type'],
        surveyId = snapshot['survey_id'],
        answerModels = snapshot['answers']
            .map((map) => new SurveyAnswerModel.fromMap(map))
            .toList();


  SurveyQuestionModel(this.question, this.answerModels, this.selectionType, this.surveyId,
   { this.selectedAnsIndexSingle = -1,this.selectedAnsIndexForMultiple,this.questionId})
      
       {
          if (this.selectedAnsIndexForMultiple == null)
              selectedAnsIndexForMultiple = [];
       }

    SurveyQuestionModel copyInstance() {
        List<int> multipleIndex = List();
        List<SurveyAnswerModel> answers = List();
        this.answerModels.forEach((each) {
          answers.add(each);
        });
     return SurveyQuestionModel(question, answers, selectionType, surveyId,
        selectedAnsIndexSingle: selectedAnsIndexSingle,
        questionId: questionId,
        selectedAnsIndexForMultiple: multipleIndex);
  }



/*factory SurveyQuestionModel.fromMap(Map<String, dynamic> json, bool isFromServer) {
    return jsonParserDelegate.getQuestionFromJson(json, isFromServer);
  }*/



toMapForQuestionTable() {
    return {
      "question": question,
      "selection_type": selectionType,
      "survey_id": surveyId,
    };
  }

 toMapForUserAnswerTable(int surveyedId) {
    List<Map<String, dynamic>> list = List();
    if (selectionType == AnswerSelectionType.SINGLE_ANSWER) {
      list.add({
        "question_id": questionId,
        "answer_id": answerModels[selectedAnsIndexSingle].id,
        "survey_id": surveyId,
        "surveyed_count_id": surveyedId
      });
    } else {
      selectedAnsIndexForMultiple.forEach((each) {
        list.add({
          "question_id": questionId,
          "answer_id": answerModels[each].id,
          "survey_id": surveyId,
          "surveyed_count_id": surveyedId
        });
      });
    }
    return list;
  }


List<Map<String, dynamic>> toMapForAnswerTable() {
    List<Map<String, dynamic>> list = List();
    answerModels.forEach((each) {
      list.add({
        "survey_id": surveyId,
        "question_id": questionId,
        "answer": each.answer
      });
    });
    return list;
  }

getAnswerInString() {
    StringBuffer stringBuffer = StringBuffer();
    for (int i = 0; i < answerModels.length; i++) {
      stringBuffer.write(answerModels[i].answer);
      if (i != answerModels.length - 1) {
        stringBuffer.write(",");
      }
    }
    print(stringBuffer.toString());
    return stringBuffer.toString();
  }



}



class  AnswerSelectionType {
 static  const String SINGLE_ANSWER = "single";
 static const String MULTIPLE_ANSWER = "multiple";
}