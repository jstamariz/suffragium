import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votation_app/src/app.dart';
import 'package:votation_app/src/models/questions_model.dart';
import 'package:votation_app/src/models/rooms_model.dart';
import 'package:votation_app/src/providers/questions_provider.dart';
import 'package:votation_app/src/providers/rooms_provider.dart';
import 'package:votation_app/src/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Add other providers here to avoid context error
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider(1)),
      ChangeNotifierProvider(create: (_) => QuestionsProvider()),
      StreamProvider<Questions>(
        create: (context) => QuestionsProvider().getQuestions(context),
        initialData: Questions(questions: []),
        catchError: (_, error) => throw error.toString(),
      ),
      ChangeNotifierProvider<RoomsProvider>(create: (_) => RoomsProvider()),
      StreamProvider<Rooms>(
        create: (_) => RoomsProvider().getRooms(),
        initialData: Rooms(
          beginDate: Timestamp.now(),
          endDate: Timestamp.now(),
          isEnded: false,
          title: '',
        ),
        catchError: (_, error) => throw error.toString(),
      ),
    ], child: App()),
  );
}