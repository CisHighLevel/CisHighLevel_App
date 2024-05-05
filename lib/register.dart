import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prueba_flutter_2/constants.dart';
import 'package:prueba_flutter_2/home_page.dart';
import 'package:prueba_flutter_2/login.dart';
import 'package:prueba_flutter_2/rep_textfiled.dart';
import 'package:prueba_flutter_2/service/http_api.dart';
import 'package:prueba_flutter_2/service/token_service.dart';
import 'package:prueba_flutter_2/service/user_service.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final RegisterController registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(24, 15, 22, 1), // Cambia el color de fondo de la AppBar
          iconTheme: IconThemeData(color: Colors.white), // Cambia el color de la flecha
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(LoginScreen());
            },
          ),
        ),
          body: Container(
            margin: EdgeInsets.all(15),
            width: gWidth,
            height: gHeight,
            child: Column(
              children: [
                SizedBox(height: 50),
                TopImage(),
                SizedBox(height: 20),
                UsernameTextFiled(registerController: registerController),
                SizedBox(height: 20),
                EmailTextFiled(registerController: registerController),
                SizedBox(height: 20),
                PasswordTextFiled(registerController: registerController),
                SizedBox(height: 25),
                RegisterButton(registerController: registerController),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  void register(BuildContext context) async {
    String? username = usernameController.text;
    String? email = emailController.text;
    String? password = passwordController.text;

    Map<String, dynamic> userData = {
      'user_name' : username,
      'mail': email,
      'password': password,
    };
    print(userData);
    ApiResponse response = await UserService.registerUser(userData);
    // print(userData);
    if (response.statusCode == 201) {
       Get.offAll(() => LoginScreen());
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
                      //Get.off(() => SignUpScreen());
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

class RegisterButton extends StatelessWidget {
  final RegisterController registerController;

  RegisterButton({
    required this.registerController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 150),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 100),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
            registerController.register(context);
          },
          child: Text(
            "Registrarse",
            style: TextStyle(fontSize: 25, color: Colors.white),
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
  final RegisterController registerController;

  PasswordTextFiled({
    required this.registerController,
  });

  @override
  _PasswordTextFiledState createState() =>
      _PasswordTextFiledState(registerController: registerController);
}

class _PasswordTextFiledState extends State<PasswordTextFiled> {
   bool obscureText = true;
  final RegisterController registerController;

  _PasswordTextFiledState({
    required this.registerController,
  });
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 200),
      child: RepTextFiled(
        controller: registerController.passwordController,
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
  final RegisterController registerController;

  EmailTextFiled({
    required this.registerController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
        delay: Duration(milliseconds: 225),
        child: RepTextFiled(
            icon: LineIcons.at,
            text: "Correo electrónico",
            controller: registerController.emailController));
  }
}
class UsernameTextFiled extends StatelessWidget {
  final RegisterController registerController;

  UsernameTextFiled({
    required this.registerController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
        delay: Duration(milliseconds: 225),
        child: RepTextFiled(
            icon: LineIcons.user,
            text: "Nombre de usuario",
            controller: registerController.usernameController));
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
