import 'package:badapp/delete.dart';
import 'package:badapp/post.dart';
import 'package:badapp/put.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //para inicializar os componentes que utilizam o firebase
  await Firebase.initializeApp( //aguarda o firebase inicializar
  options: DefaultFirebaseOptions.currentPlatform

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: TelaGet()
    );
  }
}

class TelaGet extends StatefulWidget {
  const TelaGet({super.key});

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  String? temperature; //pode ser nula caso o database não exista

  @override
  void initState(){
    super.initState();
    gettemp();
  }

  void gettemp(){
    //collection é o nome da coleção, que precisa ter o mesmo nome que foi escolhido no banco de dados
    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(
      (snapshot){ //o que você irá fazer para cada um
      dynamic data = snapshot.docs.first.data(); //data == ao primeiro documento que tem no seu banco
      setState(() {
        temperature =data['temperatura'];
      });

      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(
          "Tela Get", 
          style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 40, 104, 177),),
          
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$temperature"),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()
              ));
            }, style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 40, 104, 177),
                foregroundColor: Colors.white,), child: Text("Ir para a página Post")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeletePage()
              ));
            }, style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 40, 104, 177),
                foregroundColor: Colors.white,), child: Text("Ir para a página Delete")),
             ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PutPage()
              ));
            }, style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 40, 104, 177),
                foregroundColor: Colors.white,), child: Text("Ir para a página PUT"))
          ],
        ),
        ),
      ),

    );
  }
}