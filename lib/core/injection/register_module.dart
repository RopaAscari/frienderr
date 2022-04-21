import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frienderr/features/presentation/navigation/app_router.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AppRouter get appRouter => AppRouter();

  @injectable
  FirebaseAuth get authInstance => FirebaseAuth.instance;

  @injectable
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}