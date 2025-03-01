import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/di.dart';

import 'package:task/app/routing/app_routes.dart';
import 'package:task/app/routing/routing.dart' show Routes;
import 'package:task/presentaion/create_branch/cubit/branch_cubit.dart';

class Task extends StatelessWidget {
  final AppRoutes appRouter;

  const Task({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BranchCubit>(create: (context) => BranchCubit(getit())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.splash,
          title: 'tasky',
        ),
      ),
    );
  }
}
