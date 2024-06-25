import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/firebase_authhelper.dart';
import 'package:petshop/model/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

TextEditingController uname=TextEditingController();
TextEditingController password=TextEditingController();

bool isShowPassword=true;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("app"),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextField(
                controller: uname,
                decoration: InputDecoration(
                  labelText: "enter uname",
                  hintText: "uname",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  labelText: "enter password",
                  hintText: "password",
                  suffixIcon: CupertinoButton(
                    
                    
                    child: Icon(Icons.visibility),
                  
                  
                  
                   onPressed: (){
                    setState(() {
                      isShowPassword=!isShowPassword;
                    });
                   }),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async{

                var getuname=uname.text;
                var getpassword=password.text;

                print(getuname);
                print(getpassword);

              bool isValidated=loginValidation(uname.text, password.text);
              if(isValidated)
              {
                bool isLoginied=await FirebaseAuthHelper.instance.login(uname.text, password.text, context);
                if(isLoginied)
                {
                  
                }
              }


              },
              
               child: Text("Login"))

            ],
          ),
        ),
      ),
    );
  }
}