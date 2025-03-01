import 'package:flutter/material.dart';
import 'package:task/app/di.dart';
import 'package:task/app/routing/app_routes.dart';
import 'package:task/task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();
  runApp(Task(appRouter: AppRoutes()));
}
