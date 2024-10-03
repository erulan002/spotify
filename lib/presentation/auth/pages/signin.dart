import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            // const SizedBox(height: 30),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       const TextSpan(text: 'If You Need Any Support '),
            //       TextSpan(
            //         text: 'Click Here',
            //         style: TextStyle(
            //           color: Colors.green[400],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 50),
            _passwordField(context),
            const SizedBox(height: 20),
            _emailField(context),
            // const Row(
            //   children: [
            //     SizedBox(width: 20),
            //     Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text('Recovery Password'),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 30),
            BasicAppButton(
              onPressed: () {},
              title: 'Sign In',
            ),
            const SizedBox(height: 30),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Container(
            //         height: 1,
            //         decoration: const BoxDecoration(
            //           gradient: LinearGradient(
            //             colors: [
            //               Colors.grey,
            //               Colors.black,
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     const Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8.0),
            //       child: Text('Or'),
            //     ),
            //     Expanded(
            //       child: Container(
            //         height: 1,
            //         decoration: const BoxDecoration(
            //           gradient: LinearGradient(
            //             colors: [
            //               Colors.black,
            //               Colors.grey,
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SvgPicture.asset(AppVectors.googleLogo),
            //     const SizedBox(width: 40),
            //     SvgPicture.asset(AppVectors.appleLogo),
            //   ],
            // ),
            // const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member? ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const SignupPage(),
              ),
            ),
            child: const Text('Register Now'),
          ),
        ],
      ),
    );
  }
}
