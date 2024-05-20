import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisileruygulamasiremastered/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAdi=TextEditingController();
  var tfKisiTel= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kayıt Sayfa"),),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKisiAdi,decoration: InputDecoration(hintText: "Kişi Ad"),),
              TextField(controller: tfKisiTel,decoration: InputDecoration(hintText:"Kişi Tel"),),
              ElevatedButton(onPressed: (){
                context.read<KayitSayfaCubit>().kaydet(tfKisiAdi.text,tfKisiTel.text);
              }, child:Text("Kaydet")),
            ],
          ),
        ),
      ),
    );
  }
}