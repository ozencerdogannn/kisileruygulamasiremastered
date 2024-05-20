import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisileruygulamasiremastered/data/entity/kisiler.dart';
import 'package:kisileruygulamasiremastered/ui/cubit/anasayfa_cubit.dart';
import 'package:kisileruygulamasiremastered/ui/views/detay_sayfa.dart';
import 'package:kisileruygulamasiremastered/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyormu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().kisileriYukle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        aramaYapiliyormu ? 
        TextField(
          decoration: InputDecoration(hintText: "ara"),
          onChanged: (aramaSonucu) {
            context.read<AnaSayfaCubit>().ara(aramaSonucu);
          },
          )
        :
        Text("Kişiler"),
        actions: [
          aramaYapiliyormu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyormu = false;
            
            });
            context.read<AnaSayfaCubit>().kisileriYukle();
          }, icon:Icon(Icons.clear)):
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyormu = true;
              
            });
          }, icon:Icon(Icons.search)),
        ],
        ),
      body:BlocBuilder<AnaSayfaCubit,List<Kisiler>>(
        builder: (context,kisilerListesi) {
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context, index) {
                var kisi = kisilerListesi[index];
                return GestureDetector(
                  onTap: () {
                    
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>DetaySayfa(kisi: kisi)));

                  },
                  child: Card(
                    child: SizedBox(height: 100,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(kisi.kisi_ad,style: TextStyle(fontSize: 22),),
                                Text(kisi.kisi_tel),
                              ],
                            ),
                          ),
                          IconButton(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar (
                                content: Text("${kisi.kisi_ad} silinsin mi ?"),
                                action: SnackBarAction(label: "Evet", onPressed: (){
                                  context.read<AnaSayfaCubit>().sil(kisi.kisi_id);
                                }),
                                )
                                );
                          }, icon: Icon(Icons.clear))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else {
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder:(context)=>KayitSayfa()));
      },child: Icon(Icons.add),),
    );
  }
}