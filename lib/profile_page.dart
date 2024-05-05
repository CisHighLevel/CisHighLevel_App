import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_2/constants.dart';
import 'package:prueba_flutter_2/nav_bar.dart';
import 'package:prueba_flutter_2/service/http_api.dart';
import 'package:prueba_flutter_2/service/token_service.dart';
import 'package:prueba_flutter_2/service/user_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  @override
  void initState() {
    super.initState();
    checkAuthAndNavigate();
    obtenerDatosUsuario();
  }

  Future<void> obtenerDatosUsuario() async {
    ApiResponse response = await UserService.getUserById();
    setState(() {
      userData = response.data;
    });
  }

  Future<void> checkAuthAndNavigate() async {
    await TokenService.loggedIn();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
      body: SingleChildScrollView(
        child: Container(
            width: gWidth,
            height: gHeight,
            child: Column(
              children: [
                SizedBox(height: 50),
                ProfileImage(),
                const SizedBox(height: 10),
                if (userData.isNotEmpty) UsernameText(userData: userData),
                const SizedBox(height: 10),
                if (userData.isNotEmpty) EmailText(userData: userData),
                if (userData.isEmpty) CircularProgressIndicator(),
                const SizedBox(height: 30),
                LogoutButton(),
              ],
            )),
      ),
    );
  }
}

class EmailText extends StatelessWidget {
  const EmailText({
    Key? key,
    required this.userData,
  });

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    String email = userData['mail'] ?? "N/A";

    return Text(
      email != "N/A" ? "$email" : "",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200,color: Colors.white),
    );
  }
}

class UsernameText extends StatelessWidget {
  const UsernameText({
    Key? key,
    required this.userData,
  });

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    String username = userData['user_name'] ?? "N/A";

    return Text(
      username != "N/A" ? "$username" : "",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color:Colors.white),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: const Image(image: AssetImage('assets/descarga.gif')),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.text1Color,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? text1Color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Color(0xFF486D28).withOpacity(0.9),
              ),
              child: Icon(icon, color: Color(0xFFFFFCEA), size: 25),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: text1Color,
                  fontSize: 18,
                ),
              ),
            ),
            if (endIcon)
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFF486D28).withOpacity(0.9),
                ),
                child: const Icon(LineAwesomeIcons.angle_right,
                    size: 18.0, color: Color(0xFFFFFCEA)),
              ),
          ],
        ),
      ),
    );
  }
}
class LogoutButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 100),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
          TokenService.removeToken();
          },
          child: Text(
            "Cerrar Sesión",
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
      );
  }
}
