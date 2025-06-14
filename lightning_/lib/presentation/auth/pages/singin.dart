import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lightning_/common/widgets/appbar/app_bar.dart';
import 'package:lightning_/common/widgets/button/basic_app_button.dart';
import 'package:lightning_/core/configs/assets/app_vectors.dart';
import 'package:lightning_/data/models/auth/signin_user_req.dart';
import 'package:lightning_/domain/usecases/auth/signin.dart';
import 'package:lightning_/presentation/auth/pages/signup.dart';
import 'package:lightning_/presentation/home/pages/home.dart';
import 'package:lightning_/service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        hideBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerText(),
                const SizedBox(
                  height: 50,
                ),
                _emailField(context),
                const SizedBox(
                  height: 20,
                ),
                _passwordField(context),
                const SizedBox(
                  height: 20,
                ),
                BasicAppButton(
                    onPressed: () async {
                      var result = await sl<SinginUseCase>().call(
                          params: SigninUserReq(
                              email: _email.text.toString(),
                              password: _password.text.toString()));
                      result.fold((l) {
                        var snackbar = SnackBar(content: Text(l));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }, (r) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomePage()),
                            (route) => false);
                      });
                    },
                    title: 'Sign In')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      obscureText: true,
      controller: _password,
      decoration: InputDecoration(hintText: 'Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not A Member?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignupPage()));
              },
              child: Text(
                'Register Now',
              ))
        ],
      ),
    );
  }
}
