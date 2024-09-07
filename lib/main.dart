
import 'dart:io';
import 'package:everlane/bloc/delet_notification/bloc/delet_notification_bloc.dart';
import 'package:everlane/bloc/notifications/bloc/notification_bloc_bloc.dart';
import 'package:everlane/splash/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'bloc/address/address_bloc.dart';
import 'bloc/cart/cart_bloc.dart';
import 'bloc/category_bloc.dart';
import 'bloc/change_password/bloc/change_password_bloc.dart';
import 'bloc/editprofile/bloc/editprofile_bloc.dart';
import 'bloc/forgot_password/bloc/forgot_password_bloc.dart';
import 'bloc/loginn/loginn_bloc.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/question_bloc/bloc/question_bloc.dart';
import 'bloc/question_result/bloc/question_result_bloc.dart';
import 'bloc/userprofile/bloc/profile_bloc.dart';
import 'bloc/whishlist/whishlist_bloc.dart';
import 'bloc_signup/bloc/signup_bloc.dart';
import 'data/datasources/change_password_repo.dart';
import 'data/datasources/editprofileservice.dart';
import 'data/datasources/forgot_password_service.dart';
import 'data/datasources/notification_service.dart';
import 'data/datasources/profileservice.dart';
import 'data/datasources/qst_service.dart';
import 'data/datasources/signuprepository.dart';
import 'data/navigation_provider/navigation_provider.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) =>
                    RegistrationBloc(SignupRepository()),
              ),
              BlocProvider(
                create: (BuildContext context) => ProfileBloc(ProfileService()),
              ),
               BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(notificationService: NotificationService( )),
        ),
        BlocProvider<DeletNotificationBloc>(
          create: (context) => DeletNotificationBloc(
            notificationService: NotificationService(),
          ),
        ),
              BlocProvider(
                create: (BuildContext context) =>
                    ForgotPasswordBloc(authRepository: ForgotPasswordService()),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    EditprofileBloc(Editprofileservice()),
              ),
              BlocProvider(
                create: (BuildContext context) => ChangePasswordBloc(
                    changePasswordRepo: ChangePasswordRepo()),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    QuestionBloc(QstService()),
              ),
              BlocProvider(
                create: (BuildContext context) => CategoryBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => ProductBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => WhishlistBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => LoginnBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => CartBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => AddressBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    QuestionResultBloc(QstService()),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          );
        });
  }
}
