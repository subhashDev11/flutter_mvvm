import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/components/primary_button.dart';
import '../utils/routes/route_names.dart';
import '../utils/utilis.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocus,
              decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
              ),
              onFieldSubmitted: (value) {
                Utlis.fieldFocusNode(
                  context,
                  emailFocus,
                  passwordFocus,
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: obsecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: obsecurePassword.value,
                  obscuringCharacter: "*",
                  focusNode: passwordFocus,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        obsecurePassword.value = !obsecurePassword.value;
                      },
                      icon: Icon(
                        obsecurePassword.value ? Icons.visibility_off_outlined : Icons.visibility,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: height * .1,
            ),
            PrimaryButton(
              title: 'Sign Up',
              isLoading: authViewModel.signUpLoading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utlis.flushBarShowMessage('Please Enter Email', context);
                } else if (_passwordController.text.isEmpty) {
                  Utlis.flushBarShowMessage('Please Enter Password', context);
                } else if (_passwordController.text.length < 6) {
                  Utlis.flushBarShowMessage('Please Enter 6 Digit', context);
                } else {
                  Map data = {
                    'email': _emailController.text.toString(),
                    'password': _passwordController.text.toString(),
                  };

                  authViewModel.signUpApi(data, context);
                  print('api hit');
                }
              },
            ),
            SizedBox(
              height: height * .05,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              child: const Text("Already have account? Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
