import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
//Aqui fica a sua lógica

  TextEditingController novaTemperatura = TextEditingController();

  @override
  void initState(){ //Função que reinicia o estado da página
  super.initState();
  mensagem = "";
  erro = ""; 

  }

  //Funcao Post

  String erro = " "; //variável para erro'
  String mensagem = ""; //variável para alertar que deu certo

  Future<void> postValue() async {
    try{

       FirebaseFirestore.instance.collection("monitoramento").add(
      {
        "temperatura": novaTemperatura.text,
      }
       );

       setState(() {
         mensagem = "Dados cadastrados no banco de dados";
       });
       Timer(Duration(seconds: 4), (){
          setState(() {
         mensagem = "";
       });
       });
       
       
    }catch(e){
      setState(() {
        erro = "Erro ao enviar dados";
      });
    }
     
  
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(
          "Post Page", 
          style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 40, 104, 177),),
          
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Insira a sua temperatura"),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 80, vertical: 20),
                child: TextFormField(
                  controller: novaTemperatura,
                  cursorColor: Color.fromARGB(255, 40, 104, 177),
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 40, 104, 177),
                    ),
                    helperText: 'Insira a temperatura',
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 40, 104, 177),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 40, 104, 177)),
                    ),
                  ),
                )
                ),
              ElevatedButton(onPressed: postValue, style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 40, 104, 177),
                foregroundColor: Colors.white,

              ),
              child: Text("Inserir dados no banco")),
              Text("$mensagem"),
              Text("$erro"),

            ],

          ),
        ),
      ),
    );
  }
}