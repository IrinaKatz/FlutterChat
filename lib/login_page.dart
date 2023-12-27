import 'package:flutter/material.dart';
import 'package:my_first_project/services/auth_service.dart';
import 'package:my_first_project/utils/spaces.dart';
import 'package:my_first_project/utils/styles.dart';
import 'package:my_first_project/widgets/login_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>(); // globalkey is accessible through entire app

  void loginUser(BuildContext context) {
    final authService = context.read<AuthService>();
    if(_formKey.currentState!=null && _formKey.currentState!.validate()) {
      authService.loginUser(userNameController.text, passwordController.text);
      Navigator.pushReplacementNamed(context, '/chat');
    } else {
      print('Not validated');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Widget buildHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text('Let\'s sign you in!',
            style: TextStyle(
                fontSize: 24,
                color: AppStyles.primaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(26)
          ),
          padding: EdgeInsets.all(10),
          child: Image.asset('assets/chatimage.png', height: 50,),
          margin: EdgeInsets.all(10),
        ),
      ],
    );
  }

  Widget buildForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LoginTextField(
                    controller: userNameController,
                    hintText: 'Add your username',
                    isObscured: false,
                    validator: (value) {
                      if(value != null && value.isNotEmpty && value.length <= 5) {
                        return 'Your username must be more than 5 characters';
                      } else if(value!=null && value.isEmpty) {
                        return 'Please type ypour username';
                      }
                    }),
                Spaces.VerticalSpacing(24),
                LoginTextField(
                    controller: passwordController,
                    hintText: 'Type your password',
                    isObscured: true,
                    validator: (value) {
                      if(value != null && value.isNotEmpty && value.length <= 5) {
                        return 'Your username must be more than 5 characters';
                      } else if(value!=null && value.isEmpty) {
                        return 'Please type your username';
                      }
                    }),
              ],
            ),
          ),
        ),
        ElevatedButton(onPressed: () {
          loginUser(context);
        },
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(// horizontal alignment
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            if(constraints.maxWidth > 1000) {
              return Row(
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        buildHeader(context)
                    ]
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(child: buildForm(context)),
                  Spacer(flex: 1),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center, // vertical alignment
                children: [
                  buildHeader(context),
                  buildForm(context)
                ],
              );
            }
          }
        ),
      ),
    );
  }
}

