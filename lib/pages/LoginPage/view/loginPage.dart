import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routi_n/Themes/appTheme.dart';
import 'package:routi_n/pages/LoginPage/viewModel/loginPageViewModel.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  late Loginpageviewmodel viewModel;

  bool wantToLogin = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    viewModel = Loginpageviewmodel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Scaffold(body: mainTile()),
    );
  }

  Widget mainTile() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(turns: animation, child: child);
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 100,
                bottom: 100,
                left: 50,
                right: 50,
              ),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: wantToLogin ? loginField() : signUpField(),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginSignUpToggleSwitch() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('Already have account'),
        Checkbox(
          value: wantToLogin,
          onChanged: (value) {
            setState(() {
              wantToLogin = value ?? false;
            });
          },
        ),
      ],
    );
  }

  Widget loginField() {
    return Column(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Login', style: Apptheme.loginTextStyle),
        textFormFieldWidget(controller: viewModel.emailTextController),
        textFormFieldWidget(
          controller: viewModel.passwordTextController,
          obfuscated: true,
        ),

        Align(
          alignment: Alignment.centerRight,
          child: loginSignUpToggleSwitch(),
        ),
        customIconButton(icon: Icons.login, onPressed: () {}, label: 'Login'),
      ],
    );
  }

  Widget signUpField() {
    return Column(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Sign Up', style: Apptheme.loginTextStyle),
        textFormFieldWidget(
          controller: viewModel.emailTextController,
          hintText: 'E-mail',
        ),
        textFormFieldWidget(
          controller: viewModel.passwordTextController,
          obfuscated: true,
          hintText: 'Password',
        ),
        dividerWithCenterText(centerText: 'OR'),
        loginServiceProviders(),
        Align(
          alignment: Alignment.centerRight,
          child: loginSignUpToggleSwitch(),
        ),
        customIconButton(
          icon: Icons.settings_accessibility_outlined,
          onPressed: () {},
          label: 'Sign Up',
        ),
      ],
    );
  }

  Widget dividerWithCenterText({required String centerText}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Expanded(child: Divider(color: Colors.black)),
        Text(centerText, style: TextStyle(color: Colors.black)),
        Expanded(child: Divider(color: Colors.black)),
      ],
    );
  }

  Column loginServiceProviders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 5,
      children: [
        customIconButtonForProviders(
          onPressed: () {},
          icon: Icons.abc,
          label: 'Google',
        ),
        customIconButtonForProviders(
          onPressed: () {},
          icon: Icons.abc,
          label: 'Meta',
        ),
        customIconButtonForProviders(
          onPressed: () {},
          icon: Icons.abc,
          label: 'Yahoo',
        ),
      ],
    );
  }

  ElevatedButton customIconButtonForProviders({
    required Function()? onPressed,
    required IconData icon,
    String? label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      style: Apptheme.loginSignUpProviderButtonStyle,
      label: Text(label ?? ''),
    );
  }

  ElevatedButton customIconButton({
    required Function()? onPressed,
    required IconData icon,
    String? label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      style: Apptheme.loginSignUpButtonStyle,
      label: Text(label ?? ''),
    );
  }

  TextFormField textFormFieldWidget({
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
    bool obfuscated = false,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(hintText: hintText),
      obscureText: obfuscated,
    );
  }
}
