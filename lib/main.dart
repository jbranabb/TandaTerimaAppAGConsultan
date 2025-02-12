import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tandaterima/pages/home_page.dart';
import 'package:tandaterima/pages/pdf_page.dart';
import 'package:tandaterima/providers/recipt_provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]).then((_){
    runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => InventoryProvider(),),
      ChangeNotifierProvider(create: (context) => DateProvider(),),
    ],
    child: const MainApp()));

  });
  }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          color: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,),
      // theme: ThemeData,
      home: HomePage(),
    );
    
  }
}
