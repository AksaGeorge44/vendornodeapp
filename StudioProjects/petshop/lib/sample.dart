import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController uname=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController email=TextEditingController();
  bool ispassword=false;
  final formkey=GlobalKey<FormState>();

  Future<void>register()async{
   if(formkey.currentState!.validate())
     {
       try{
         final existinguser=await FirebaseFirestore.instance.collection('users').where('email',isEqualTo:email.text ).get();
         if(existinguser.docs.isNotEmpty)
         {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("email exists")));
         }
         final existingusername=await FirebaseFirestore.instance.collection('users').where('uname',isEqualTo: uname.text).get();
         if(existingusername.docs.isNotEmpty)
         {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("uname exists")));
         }
         UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
             email: email.text,
             password: password.text);

         await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
           'uname':uname.text,
           'password':password.text,
           'email':email.text,
         });
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("saved")));

       }
       catch(e)
       {

       }
     }
  }

Future<void>login()async{
    if(formkey.currentState!.validate())
      {
        try{

          UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email.text,
              password: password.text);
          DocumentSnapshot userdoc=await FirebaseFirestore.instance.collection('users').
          doc(userCredential.user!.uid).get();

          String username=userdoc['uname'];
          String useremail=userdoc['email'];


        }
        catch(e)
  {

  }
      }
}

Future<void>save()async{
    if(formkey.currentState!.validate())
      {
        try{
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    CollectionReference namecollecton=firestore.collection('users');
    Map<String,dynamic>namedata={
      'uname':uname.text,
      'password':password.text
    };
    await namecollecton.add(namedata);
        }
        catch(e)
  {
    

  }
      }
}






TextEditingController date=TextEditingController();
  TextEditingController date1=TextEditingController();

TimeOfDay? time;

Future<void>getdate(BuildContext context)async{
  final DateTime currentdate=DateTime.now();
  final DateTime? seledate=await showDatePicker(
      context: context,
      initialDate: currentdate,
      firstDate: DateTime(currentdate.year-50),
      lastDate: currentdate);
  if(seledate!=null)
    {
      date.text=formatdate(seledate);
    }


}
String formatdate(DateTime date){
  return '${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}';
}


Future<void>gettime(BuildContext context)async{
  final currenttime=TimeOfDay.now();
  final seltime=await showTimePicker(
      context: context,
      initialTime: currenttime);
  if(seltime!=null)
    {
      date1.text=DateFormat.Hm().format(DateTime(2024,1,1,time!.hour,time!.minute));
    }
}

File? galleryfile;
final picker=ImagePicker();

Future<void>getimage(ImageSource img)async{
  final pickedfile=await picker.pickImage(source: img);
  XFile? xfilepick=pickedfile;
  setState(() {
    if(xfilepick!=null)
      {
        galleryfile=File(pickedfile!.path);
      }
  });
}

void showimage({required BuildContext context})
{
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("camera"),
              onTap: (){
                getimage(ImageSource.camera);
              },
            ),
            ListTile(),
          ],
        );
      });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: date,
            onTap: (){
              getdate(context);
            },
          ),

          TextFormField(
            controller: date1,
            onTap: (){
              getdate(context);
            },
          ),

          SizedBox(height: 20,),
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
              else if(!RegExp('^[A-Za-z]').hasMatch(value)||!RegExp('^[0-9]').hasMatch(value))
                {
                  return 'enter a value with letters and numbers';
                }
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: password,
            obscureText: ispassword,
            decoration: InputDecoration(
              labelText: "password",
              hintText: "enter password",
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  ispassword=!ispassword;
                });
              }, icon: Icon(ispassword?Icons.visibility_off:Icons.visibility)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
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
          ElevatedButton(onPressed: (){},
              child: Text("register"))
        ],
      ),
    );
  }
}
