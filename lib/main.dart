import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisileruygulamasiremastered/ui/cubit/anasayfa_cubit.dart';
import 'package:kisileruygulamasiremastered/ui/cubit/detay_sayfa_cubit.dart';
import 'package:kisileruygulamasiremastered/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:kisileruygulamasiremastered/ui/views/anasayfa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: 
      [
        BlocProvider(create:(context)=>KayitSayfaCubit()),
        BlocProvider(create:(context)=>DetaySayfaCubit()),
        BlocProvider(create:(context)=>AnaSayfaCubit()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Anasayfa()
      ),
    );
  }
}

