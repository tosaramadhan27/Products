import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:productsapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  'test@gmail.com': 'test',
};

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  // login
  Future<String?> _authUserLogin(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(data.name, data.password);
      } catch (err) {
        // print(err);
        return err.toString();
      }
      return null;
    });
  }

  // signup
  Future<String?> _authUserSignUp(SignupData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .signup(data.name, data.password);
      } catch (err) {
        // print(err);
        return err.toString();
      }
      return null;
    });
  }

  // forgot passsword
  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return _recoverPassword(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'WELCOME',
      // logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUserLogin,
      onSignup: _authUserSignUp,
      onSubmitAnimationCompleted: () {
        Provider.of<AuthProvider>(context, listen: false).tempData();
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
