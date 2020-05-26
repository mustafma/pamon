import 'package:BridgeTeam/Model/Survey/survey.question.model.dart';
import 'package:flutter/material.dart';

/* This page shows the Circle avatars and its status if answerd or not  */
class PageIndicator extends StatelessWidget {

  final int currentIndex;
  final int pageCount;
  Color bgDarkColor = Color(0xa13700b3);
  final Function onClick;
  List<SurveyQuestionModel> surveyModels;

PageIndicator(
      this.currentIndex, this.pageCount, this.onClick , this.surveyModels
            );



_indicator(bool isActive, int index) {
   bool isAnswered = false;


 if (surveyModels[index].selectionType == AnswerSelectionType.SINGLE_ANSWER)
 {
      isAnswered =  surveyModels[index].selectedAnsIndexSingle != null && surveyModels[index].selectedAnsIndexSingle != -1;
 } else if (surveyModels[index].selectionType == AnswerSelectionType.MULTIPLE_ANSWER)
 {
      isAnswered = surveyModels[index].selectedAnsIndexForMultiple != null &&
      surveyModels[index].selectedAnsIndexForMultiple.length > 0;
 }

return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: () {
          onClick(index);
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedContainer(
              height: 4.0,
              decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFF003C64), const Color(0xFF428879)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
              duration: Duration(seconds: 2),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastLinearToSlowEaseIn,
            ),
            CircleAvatar(
              backgroundColor: isActive ? Colors.white : bgDarkColor,
              child: Text(
                "${index + 1}",
                style: TextStyle(
                    color: isActive ? bgDarkColor : Colors.white, fontSize: 20),
              ),
            ),
            isAnswered
                ? Positioned(
                    top: -4,
                    right: 8,
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

 _buildPageIndicators() {
    List<Widget> indicatorList = [];

    int showTop5  = 5;
    int start  = 0;
    int end  = 5;
    if ( currentIndex % 5 == 0 ) 
      {
        start = currentIndex;
        end = currentIndex + 5  < pageCount ? currentIndex + 5 : pageCount;
      }
      else
      {
        start = currentIndex -  (currentIndex % 5);
        end = currentIndex + (5 - (currentIndex % 5));
      }


   

    for (int i = start; i < end; i++) {
      indicatorList
          .add(i <= currentIndex ? _indicator(true, i) : _indicator(false, i));
    }
    return indicatorList;
  }


@override
  Widget build(BuildContext context) {
    return new Row(
      children: _buildPageIndicators(),
    );
  }


}
