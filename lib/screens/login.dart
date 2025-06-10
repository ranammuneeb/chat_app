import 'package:chat_app/screens/signup.dart';
import 'package:chat_app/theme/mybutton.dart';
import 'package:chat_app/theme/mytextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller= TextEditingController();
  final TextEditingController passwordcontroller= TextEditingController();
  final _key=GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool ispassvisible=true;


String? _validatepassword(String? text)
  {
    if(text!.isEmpty)
    {
      return "please enter a password";
    }
    if(text.length<6)
    {
      return "please enter a password f length 6";
    }
    return null;
  }
  
  String? _validateemail(String? text)
  {
    if(text!.isEmpty)
    {
      return "please enter a email";
    }
   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(text)) {
      return 'Please enter a valid email address (e.g., example@email.com)';
    }
    return null;
  }


   @override
  void dispose()
  {
    emailcontroller.dispose();
    passwordcontroller.dispose();
   
    _emailFocus.dispose();    
    _passwordFocus.dispose();    
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                          height: 30,
                        ),
                Text("Welcome",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                          height: 10,
                        ),

                Text("sign in to continue ",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey,),
                ),
                Mytextfield(mycontroller: emailcontroller,
                         hinttext: "Email",
                         prefixIcon: Icon(Icons.email_outlined)
                         ,focusNode: _emailFocus,
                         myvalidator: _validateemail,
                         ),

                const SizedBox(
                          height: 15,
                        ),

                
                Mytextfield(mycontroller: passwordcontroller,
                 hinttext: "pasword",
                 isobscure: ispassvisible,
                 prefixIcon: Icon(Icons.lock),
                 suffixIcon: IconButton(onPressed:(){
                  setState(() {
                    ispassvisible=!ispassvisible;
                  });
                 }, icon: Icon(ispassvisible
                 ?Icons.visibility_off
                 :Icons.visibility,) 
                 ),
                 focusNode: _passwordFocus,
                 myvalidator: _validatepassword,
                 ),
                const SizedBox(
                          height: 15,
                        ),
                Mybutton(text: "Login", on_press: ()=>{
                   FocusScope.of(context).unfocus(),
                  if(_key.currentState?.validate() ?? false){},
                }),
                 const SizedBox(
                          height: 15,
                        ),
                Center(
                  child: RichText(text: TextSpan(
                    text:"don't have an account ?",
                    style:TextStyle( color:Colors.grey,),
                    children: [
                      TextSpan(
                        text: "sign up",
                        style: TextStyle(color: Colors.red),
                        recognizer: TapGestureRecognizer()..onTap= () {
                          Navigator.push(context,
                            MaterialPageRoute(builder:(context)=>Signuppage()),
                          );
                        }
                      )
                    ]
                  
                  )),
                )

              
              ],
            ),
          )
          )
          ),
    );
  }
}