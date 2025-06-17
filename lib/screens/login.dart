import 'package:chat_app/cubit/authcubit.dart';
import 'package:chat_app/cubit/authstate.dart';
import 'package:chat_app/repositries/authrepo.dart';
import 'package:chat_app/repositries/routes.dart';
import 'package:chat_app/repositries/servicelocator.dart';
import 'package:chat_app/screens/homescreen.dart';
import 'package:chat_app/screens/signup.dart';
import 'package:chat_app/theme/mybutton.dart';
import 'package:chat_app/theme/mytextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Future<void> handlesignin() async{
     FocusScope.of(context).unfocus();
      if(_key.currentState?.validate() ?? false){
        try {
         await  getit<Authcubit>().sigin(
         
            email: emailcontroller.text, 
            
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
   
    _emailFocus.dispose();    
    _passwordFocus.dispose();    
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Authcubit,Authstate>(
      bloc: getit<Authcubit>(),
     
      listener: ( context, state) { 

        if(state.status==AuthStatus.authenticated)
        {
          getit<Approute>().pushutil(Homescreen());
        }

       },
      builder:(context,state) =>Scaffold(
        // appBar: AppBar(
      
        // ),
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
                  const SizedBox(
                            height: 30,
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
                  Mybutton(text: "signup", on_press: handlesignin,
                  
                  
                  child:state.status==AuthStatus.loading
                  ? const CircularProgressIndicator(
                    color: Colors.blueGrey,
                  )
                  :const Text("signup")
                  
                   ),
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
                            // Navigator.push(context,
                            //   MaterialPageRoute(builder:(context)=>Signuppage()),
                            // )
                            // ;
                            getit<Approute>().push(Signuppage());
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