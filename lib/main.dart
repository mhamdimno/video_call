import 'package:flutter/material.dart';
import 'package:video_call/video_call/videocall_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MyHomePage(isCallIsRunning: false,),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.isCallIsRunning});
final bool isCallIsRunning;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(

          children: [
            Center(child: VideocallManager.callWidget(context,isCallIsRunning:isCallIsRunning)),
            if(isCallIsRunning)
              GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  color: Colors.red,
                  child:  Text("return to call".toUpperCase(),style: const TextStyle(fontWeight: FontWeight.w900,color: Colors.black54),),
                ),
              )
          ],
        ),
      ),
    );
  }
}


