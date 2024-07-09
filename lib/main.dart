import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_bank/pages/add_member.dart';
import 'package:mobile_bank/pages/dashboard.dart';
import 'package:mobile_bank/pages/detail_member.dart';
<<<<<<< HEAD
=======
import 'package:mobile_bank/pages/detail_transaction.dart';
import 'package:mobile_bank/pages/interest.dart';
>>>>>>> master
import 'package:mobile_bank/pages/login.dart';
import 'package:mobile_bank/pages/register.dart';
import 'package:mobile_bank/pages/update_member.dart';
import 'package:mobile_bank/pages/front_page.dart';
import 'package:mobile_bank/pages/member.dart';
<<<<<<< HEAD
=======
import 'package:mobile_bank/pages/profile.dart';
>>>>>>> master

GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: "/",
      builder: (context, state) {
        return FrontPage();
      },
      routes: [
        GoRoute(
            path: "dashboard",
            builder: (context, state) {
              return Dashboard();
<<<<<<< HEAD
            }
        ),
=======
            }),
        GoRoute(
            path: "profil",
            builder: (context, state) {
              return Profil();
            }),
>>>>>>> master
        GoRoute(
            path: "login",
            builder: (context, state) {
              return Login();
            }),
        GoRoute(
            path: "register",
            builder: (context, state) {
              return Register();
            }),
        GoRoute(
            path: "member",
            builder: (context, state) {
              return Member();
            }),
        GoRoute(
            path: "add_member",
            builder: (context, state) {
              return AddMember();
            }),
        GoRoute(
            path: "update_member/:id",
<<<<<<< HEAD
            builder: (context, state){
              return UpdateMember(user_id: state.pathParameters["id"],);
            }),
        GoRoute(
          path: "member/:id",
          builder: (context, state) {
            return DetailMember(user_id: int.parse(state.pathParameters["id"]!),);
          }
        )
=======
            builder: (context, state) {
              return UpdateMember(
                user_id: state.pathParameters["id"],
              );
            }),
        GoRoute(
            path: "member/:id",
            builder: (context, state) {
              return DetailMember(
                user_id: int.parse(state.pathParameters["id"]!),
              );
            }),
        GoRoute(
            path: "transaction",
            builder: (context, state) {
              return Member(
                transaction: true,
              );
            }),
        GoRoute(
            path: 'transaction_detail/:id',
            builder: (context, state) {
              return DetailTransaction(
                  user_id: int.parse(state.pathParameters['id']!));
            }),
        GoRoute(
            path: 'interest',
            builder: (context, state){
              return Interest();
            })
>>>>>>> master
      ])
]);

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> master
