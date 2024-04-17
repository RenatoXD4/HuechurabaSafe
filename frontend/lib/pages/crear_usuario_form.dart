import 'package:flutter/material.dart';
import 'package:frontend/models/regex.dart';

class UsuarioForm extends StatefulWidget {
  const UsuarioForm({super.key});

  @override
  State<UsuarioForm> createState() {
    return _UsuarioFormState();
  }
}

class _UsuarioFormState extends State<UsuarioForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final Regex _regex = Regex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Ingrese su nombre (Ej: Diego Castro/Diego)',icon: Icon(Icons.person, ) ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre de usuario es requerido';
                  }
                  if(value.length < 6 || value.length > 20){
                    return 'El nombre tiene que tener entre 6 y 20 carácteres';
                  }
                  return _regex.formValidate(_regex.name, value, 'El nombre es inválido');
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico',icon: Icon(Icons.email, )),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo electrónico es requerido';
                  }
                  return _regex.formValidate(_regex.email, value, 'Correo electrónico inválido');
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  errorMaxLines: 2,
                  icon: Icon(Icons.password, )
                ),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña es requerida';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return _regex.formValidate(
                      _regex.password, value, 'La contraseña debe contener al menos 1 mayúscula, 1 número y 1 carácter especial');
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirmar contraseña',icon: Icon(Icons.password, )),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirma tu contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Realizar el registro del usuario
                    _registroUsuario();
                  }
                },
                child: const Text('Registrarse', ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registroUsuario() {
    // Aquí puedes realizar el registro del usuario
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Por ejemplo, puedes imprimir los datos del usuario
    print('Nombre de usuario: $username');
    print('Correo electrónico: $email');
    print('Contraseña: $password');

    // También puedes llamar a tu API para registrar el usuario en el backend
  }
}