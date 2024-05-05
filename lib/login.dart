import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prueba_flutter_2/constants.dart';
import 'package:prueba_flutter_2/home_page.dart';
import 'package:prueba_flutter_2/register.dart';
import 'package:prueba_flutter_2/rep_textfiled.dart';
import 'package:prueba_flutter_2/service/http_api.dart';
import 'package:prueba_flutter_2/service/token_service.dart';
import 'package:prueba_flutter_2/service/user_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(15),
            width: gWidth,
            height: gHeight,
            child: Column(
              children: [
                SizedBox(height: 50),
                TopImage(),
                SizedBox(height: 20),
                EmailTextFiled(loginController: loginController),
                SizedBox(height: 20),
                PasswordTextFiled(loginController: loginController),
                SizedBox(height: 25),
                LoginButton(loginController: loginController),
                SizedBox(height: 20),
                RegisterText()
              ],
            ),
          ),
        ));
  }
}

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    String? email = emailController.text;
    String? password = passwordController.text;

    Map<String, dynamic> userData = {
      'mail': email,
      'password': password,
    };
    print(userData);
    ApiResponse response = await UserService.loginUser(userData);
    // print(userData);
    if (response.statusCode == 200) {
      String? token = response.data['token'];
      print(token);
      if (token != null) {
        await TokenService.saveToken(token);
        Get.offAll(() => HomePage());
      } else {
        print('token'.tr);
      }
    } else {
      Get.snackbar('Error', 'incorrecto'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Container(
        width: gWidth,
        height: gHeight / 28,
        child: Center(
          child: RichText(
            text: TextSpan(
              text: "¿No tienes una cuenta? ",
              style: TextStyle(color: text2Color, fontSize: 18),
              children: [
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Get.off(() => RegisterScreen());
                    },
                    child: Text(
                      "Regístrate",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: text3Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final LoginController loginController;

  LoginButton({
    required this.loginController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 150),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            loginController.login(context);
          },
          child: Text(
            "Iniciar Sesión",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(120, 42, 99, 1))),
        ),
      ),
    );
  }
}

class PasswordTextFiled extends StatefulWidget {
  final LoginController loginController;

  PasswordTextFiled({
    required this.loginController,
  });

  @override
  _PasswordTextFiledState createState() =>
      _PasswordTextFiledState(loginController: loginController);
}

class _PasswordTextFiledState extends State<PasswordTextFiled> {
  bool obscureText = true;
  final LoginController loginController;

  _PasswordTextFiledState({
    required this.loginController,
  });
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 200),
      child: RepTextFiled(
        controller: loginController.passwordController,
        icon: LineIcons.alternateUnlock,
        text: "Contraseña",
        suficon: Icon(obscureText
            ? LineIcons.eyeSlash
            : LineIcons.eye), // Cambia el icono según la visibilidad
        obscureText: obscureText,
        onToggleVisibility: () {
          // Cambia la visibilidad de la contraseña cuando se hace clic en el icono
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
    );
  }
}

class EmailTextFiled extends StatelessWidget {
  final LoginController loginController;

  EmailTextFiled({
    required this.loginController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
        delay: Duration(milliseconds: 225),
        child: RepTextFiled(
            icon: LineIcons.at,
            text: "Correo electrónico",
            controller: loginController.emailController));
  }
}

class TopImage extends StatelessWidget {
  const TopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 275),
      child: Container(
          width: gWidth,
          height: gHeight / 2.85,
          child: Image.asset('assets/logo2.png')),
    );
  }
}
