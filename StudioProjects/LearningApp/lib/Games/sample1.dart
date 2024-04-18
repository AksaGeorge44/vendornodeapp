import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {

  TextEditingController uname=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController email=TextEditingController();

  bool ispassword=false;
  final formkey=GlobalKey<FormState>();

  List unames=[];
  List passwords=[];

TextEditingController date=TextEditingController();
TextEditingController date1=TextEditingController();
TimeOfDay? time;


Future<void>getdate(BuildContext context)async{
  final DateTime currentdate= DateTime.now();
  final DateTime? seldate=await showDatePicker(
      context: context,
      firstDate: DateTime(currentdate.year-50),
      lastDate: currentdate,
  initialDate: currentdate);
  if(seldate!=null)
    {
      date.text=formatdate(seldate);
    }
}


String formatdate(DateTime date){
  return '${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}';
}


File? galleryfile;
final picker=ImagePicker();

Future<void>getimage(ImageSource img)async{
  final pickedfile=await picker.pickImage(source: img);
  XFile? xfilepicked=pickedfile;
  if(xfilepicked!=null)
    {
      galleryfile=File(pickedfile!.path);
    }
  else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("nothing selected")));
  }
}

void showimage({required BuildContext context}){
  showModalBottomSheet(context: context,
      builder: (BuildContext context){
    return SafeArea(child: Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.camera),
          onTap: (){
            getimage(ImageSource.camera);
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_library),
          onTap: (){
            getimage(ImageSource.gallery);
          },
        ),
      ],
    ));
      });
}


String selval='item1';
int selvalue=1;



sendemail()async{
    var url=Uri.parse('mailto:');
    if(await canLaunchUrl(url))
      {
        await launchUrl(url);
      }
}

sendsms()async{
    var url=Uri.parse('sms:');
    if(await canLaunchUrl(url))
      {
        await launchUrl(url);
      }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app"),
      ),

      body: Column(
        children: [

          SizedBox(height: 20,),
          DropdownButton(items: [
            'item1','item2','item3'
          ].map<DropdownMenuItem<String>>((String val) => DropdownMenuItem(child: Text(val),value: val,)).toList(),
              onChanged: (String? val){
            setState(() {
              selval=val!;
            });
              }),

          Radio(value: 1,
              groupValue: selvalue,
              onChanged: (val){
            setState(() {
              selvalue=val!;
            });
          }),




          TextFormField(
            controller: uname,
            decoration: InputDecoration(
              labelText: "uname",
              hintText: "enter uname",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            validator: (value){
              if(value==null||value.isNotEmpty)
                {
                  return 'enter a value';
                }
              else if(!RegExp(r'^[a-zA-Z]').hasMatch(value)||!RegExp(r'[0-9]').hasMatch(value))
                {
                  return 'enter a value with letters and numbers';
                }
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
              labelText: "password",
              hintText: "enter password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            validator: (value){
              if(value==null||value.isNotEmpty)
                {
                  return 'enter a value';
                }
              else if(value.length<8||!RegExp(r'^[a-zA-Z]').hasMatch(value)||!RegExp(r'^[0-9]').hasMatch(value))
                {
                  return 'enter a value with letters and numbers';
                }
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              labelText: "email",
              hintText: "enter email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          ),
          SizedBox(height: 20,),

          ElevatedButton(onPressed: (){
            var getuname=uname.text;
            var getpassword=password.text;
            print(getuname);
            print(getpassword);
          },
              child: Text("register")),

        ],
      ),
    );
  }
}
