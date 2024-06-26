import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditUserPage extends StatefulWidget {
  String id;
  EditUserPage(@required this.id);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _username;
  String? _email;
  String? _password;
  String? _avatar;
  Map data = {};
  List usersData = [];

  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Usuario',
          style: TextStyle(
            color: Color(0xFFFFFCEA),
          ),
        ),
        backgroundColor: Color(0xFF486D28),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Color(0xFF486D28),
                  ),
                ),
                onSaved: (value) => _username = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color(0xFF486D28),
                  ),
                ),
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF486D28),
                  ),
                ),
                onSaved: (value) => _password = value,
                obscureText: true,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Avatar URL',
                  labelStyle: TextStyle(
                    color: Color(0xFF486D28),
                  ),
                ),
                onSaved: (value) => _avatar = value,
              ),
              SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          final Map<String, String> userData = {
                            'username': _username ?? "",
                            'email': _email ?? "",
                            'password': _password ?? "",
                            'avatar': _avatar ?? "",
                          };

                          final response = await http.put(
                            Uri.parse(
                                'http://localhost:9090/users/updateuser/$id'),
                            body: userData,
                          );

                          if (response.statusCode == 201) {
                            print('Usuario editado con éxito.');

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Éxito'),
                                  content: Text('Usuario creado con éxito'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Aceptar'),
                                      onPressed: () {
                                        // Cierra el diálogo
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            print(
                                'Error al editar el usuario. Código de estado: ${response.statusCode}');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF486D28),
                      ),
                      child: Text(
                        'Editar Usuario',
                        style: TextStyle(color: Color(0xFFFFFCEA)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
}
