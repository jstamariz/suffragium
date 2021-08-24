import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:votation_app/src/models/answers_model.dart';
import 'package:votation_app/src/providers/answers_provider.dart';
import 'package:votation_app/src/screens/room/widgets/question_chart.dart';
// import 'package:votation_app/src/providers/theme_provider.dart';
import 'package:votation_app/src/screens/room/widgets/response_buttons.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen(
      {Key? key,
      required this.question,
      required this.questionsId,
      required this.questionIsEnded})
      : super(key: key);

  final String question, questionsId;
  final bool questionIsEnded;

  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeProvider>(context);
    final _h = MediaQuery.of(context).size.height;

    return StreamProvider<Answers>(
      create: (_) => AnswerProvider().getAnswers(this.questionsId),
      initialData: Answers(answers: [], id: ''),
      catchError: (_, error) => throw error.toString(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Text(this.question,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                    )),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Consumer<Answers>(
                    builder: (context, answers, child) => ResponseButtons(
                      answers: answers,
                      answersId: answers.id,
                      question: this.question,
                      questionIsEnded: this.questionIsEnded,
                    ),
                  ),
                  Container(
                    height: _h * 0.48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Text("Resultados de la votación",
                            style: GoogleFonts.montserrat(fontSize: 30)),
                        Expanded(
                          child: QuestionChart(question: this.question),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          floatingActionButton: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
            label: Text(
              'Ir a la siguiente pregunta',
              style: GoogleFonts.montserrat(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
