import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/ui/log_in/login_viewModel.dart';
import 'package:find_me_ii/ui/registeration/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../validation_utils.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = 'Log In Screen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> implements LoginNavigator {
  bool securePasswordI = true;
  bool securePasswordII = true;
  var formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * .05),
          child: AppBar(
            shape: Theme.of(context).appBarTheme.shape,
            centerTitle: true,
            title: Text('Find Me'),
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'E-mail Adress Is Required';
                      }
                      if (!ValidationUtils.isValidEmail(text)) {
                        return 'Pleas Enter A Valid E-mail';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'E-mail Adress'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Password';
                      }
                      if (text.length < 6) {
                        return 'Passord Must Be At Least 6 Characters.';
                      }
                      return null;
                    },
                    obscureText: securePasswordI,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              securePasswordI = !securePasswordI;
                              setState(() {});
                            },
                            child: Icon(securePasswordI
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        labelText: 'Password'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .09,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Log In',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onPressed: () {
                      signIn();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red))),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Center(
                      child: Text(
                    'Or',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.routeName);
                      },
                      child: Text('Create New Account',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.login(emailController.text, passwordController.text);
  }

  @override
  void showLoadingDialog({String message = 'Loading..'}) {
    showLoading(context, message);
  }

  @override
  void showMessageDialog(String message) {
    showMessage(context, message);
  }

  @override
  void hideLoadinDialog() {
    hideLoading(context);
  }
}