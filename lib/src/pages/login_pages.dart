import 'package:flutter/material.dart';
import 'package:flutter_app_carrito/shared/models/auth_model.dart';
import 'package:flutter_app_carrito/src/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login_page';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<AuthModel> usuariosValidos = [
    AuthModel(user: 'Christian', password: '123456'),
    AuthModel(user: 'Mark', password: '1234'),
  ];
  String user = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: size.height,
      width: size.width,
      color: Colors.white24,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: 250.0,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    icon: Icon(Icons.verified_user_rounded),
                    hintText: 'Ingrese su Usuario ...',
                    labelText: 'Usuario:'),
                onChanged: (value) => {
                  setState(() {
                    user = value;
                  })
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password_rounded),
                    hintText: 'Ingrese una contraseña ...',
                    labelText: 'Password:'),
                onChanged: (value) => {
                  setState(() {
                    password = value;
                  })
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  validarCredenciales();
                },
                child: Text("Ingresar"))
          ],
        ),
      ),
    )));
  }

  void validarCredenciales() {
    final valid = usuariosValidos
        .any((usuario) => usuario.user == user && usuario.password == password);

    if (!valid) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Credenciales inválidas'),
          content: const Text(
              'El nombre de usuario o la contraseña son incorrectos.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Si las credenciales son válidas, navega a la página principal
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
    // Navigator.push(
    //   context,
    //   // MaterialPageRoute(builder: (_) => PaginaPrincipal()),
    // );
  }
}
