

import 'package:chat_app/cubit/authcubit.dart';
import 'package:chat_app/cubit/authstate.dart';
import 'package:chat_app/repositries/authrepo.dart';
import 'package:chat_app/repositries/routes.dart';
import 'package:chat_app/repositries/servicelocator.dart';
import 'package:chat_app/screens/homescreen.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/theme/mybutton.dart';
import 'package:chat_app/theme/mytextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {

  final _key=GlobalKey<FormState>();
  final TextEditingController emailcontroller= TextEditingController();
  final TextEditingController passwordcontroller= TextEditingController();
  final TextEditingController namecontroller= TextEditingController();
  final TextEditingController phonecontroller= TextEditingController();
  final TextEditingController usernamecontroller= TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _fullnameFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  bool ispassvisible=true;



  String? _validatename(String? text)
  {
    
    if(text!.isEmpty)
    {
      return "please enter a name ";
    }
    return null;
  }
   String? _validateusername(String? text)
  {
    
    if(text!.isEmpty)
    {
      return "please enter a username ";
    }
    return null;
  }
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
  String? _validatephone(String? text)
  {
    if(text!.isEmpty)
    {
      return "please enter a phone";
    }
   final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(text)) {
      return 'Please enter a valid phone number (e.g., +1234567890)';
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

  Future<void> handlesigup() async{
     FocusScope.of(context).unfocus();
      if(_key.currentState?.validate() ?? false){
        try {
          getit<Authrepo>().signup(fullName: namecontroller.text,
           username: usernamecontroller.text,
            email: emailcontroller.text, 
            phoneNumber: phonecontroller.text, 
            password: passwordcontroller.text,
            );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      
        }
        }
      else{

      }

  }



  @override
  void dispose()
  {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
    phonecontroller.dispose();
    usernamecontroller.dispose();
    _emailFocus.dispose();    
    _passwordFocus.dispose();    
    _fullnameFocus.dispose();    
    _usernameFocus.dispose();    
    _phoneFocus.dispose();    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<Authcubit,Authstate>(
      bloc: getit<Authcubit>(),
      listenWhen: (previous, current) {
        return previous.status!=current.status||previous.error!=current.error;
      },
      listener: ( context, state) { 

        if(state.status==AuthStatus.authenticated)
        {
          getit<Approute>().pushutil(Homescreen());
        }

       },
      child: Scaffold(
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
                  Text("Create Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                            height: 10,
                          ),
      
                  Text("fill details to continue ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey,),
                  ),
                  const SizedBox(
                            height: 15,
                          ),
      
                  Mytextfield(mycontroller: namecontroller,
                       hinttext: "FullName",
                       prefixIcon: Icon(Icons.person_2_outlined),
                       focusNode: _fullnameFocus,
                       myvalidator: _validatename,
                       ),
                  const SizedBox(
                            height: 15,
                          ),
      
                  Mytextfield(mycontroller: usernamecontroller,
                   hinttext: "userName",
                   prefixIcon: Icon(Icons.alternate_email),
                   focusNode: _usernameFocus,
                   myvalidator: _validateusername,
                   ),
                  const SizedBox(
                            height: 15,
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
      
                  Mytextfield(mycontroller: phonecontroller,
                           hinttext: "phone number",
                           prefixIcon: Icon(Icons.phone_rounded)
                           ,focusNode: _phoneFocus,
                           myvalidator: _validatephone,
                           ),
                  const SizedBox(
                            height: 15,
                          ),
                  Mytextfield(mycontroller: passwordcontroller,
                   hinttext: "pasword",
                   isobscure: ispassvisible,
                   prefixIcon: Icon(Icons.lock),
                   suffixIcon:  IconButton(onPressed:(){
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
                  Mybutton(text: "signup", on_press: handlesigup),
                   const SizedBox(
                            height: 15,
                          ),
                  Center(
                    child: RichText(text: TextSpan(
                      text:"already have an account ?",
                      style:TextStyle( color:Colors.grey,),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(color: Colors.red),
                          recognizer: TapGestureRecognizer()..onTap= () {
                            //  Navigator.push(context,
                            //   MaterialPageRoute(builder:(context)=>LoginPage()),
                            // );
                            getit<Approute>().push(LoginPage());
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
      ),
    );
  }
}