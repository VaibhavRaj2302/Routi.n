import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routi_n/Themes/appTheme.dart';
import 'package:routi_n/customComponents/RNSnackBar.dart';
import 'package:routi_n/customComponents/loadingIndicatorOverlay.dart';
import 'package:routi_n/enumsAndConstants/enums.dart';
import 'package:routi_n/pages/LoginPage/viewModel/loginPageViewModel.dart';
import 'package:routi_n/utility/textFieldValidators.dart';

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
    viewModel.addListener(viewModelUpdated);

    super.initState();
  }

  void viewModelUpdated() {
    final viewState = viewModel.viewState;

    if (viewState.pageState == PageState.error && viewState.message != null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        Rnsnackbar(
          message: viewModel.viewState.message ?? '',
          showCloseIcon: true,
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,

      builder:
          (context, child) => Stack(
            children: [
              Scaffold(body: mainTile()),
              if (viewModel.viewState.pageState == PageState.loading)
                Loadingindicatoroverlay(),
            ],
          ),
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
              child: loginSignUpField(),
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
              viewModel.emailTextController.text = '';
              viewModel.passwordTextController.text = '';
              wantToLogin = value ?? false;
            });
          },
        ),
      ],
    );
  }

  Future<void> validateEmailPasswordAndLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      await viewModel.signInWithEmailPassword(
        email: viewModel.emailTextController.text,
        password: viewModel.passwordTextController.text,
      );
    }
  }

  Future<void> validateEmailPasswordAndSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      await viewModel.signUpWithEmailPassword(
        email: viewModel.emailTextController.text,
        password: viewModel.passwordTextController.text,
      );
    }
  }

  Widget loginSignUpField() {
    return Column(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        wantToLogin
            ? Text('Login', style: Apptheme.loginTextStyle)
            : Text('Sign Up', style: Apptheme.loginTextStyle),
        textFormFieldWidget(
          controller: viewModel.emailTextController,
          hintText: 'E-mail',
          validator:
              (value) => Textfieldvalidators.emailTextFieldValidator(value),
        ),
        textFormFieldWidget(
          controller: viewModel.passwordTextController,
          obfuscated: true,
          hintText: 'Password',
          validator:
              (value) => Textfieldvalidators.passwordTextFieldValidator(value),
        ),
        dividerWithCenterText(centerText: 'OR'),
        loginServiceProviders(),
        Align(
          alignment: Alignment.centerRight,
          child: loginSignUpToggleSwitch(),
        ),
        wantToLogin
            ? customIconButton(
              icon: Icons.login_outlined,
              onPressed: () async {
                await validateEmailPasswordAndLogin();
              },
              label: 'Login in',
            )
            : customIconButton(
              icon: Icons.settings_accessibility_outlined,
              onPressed: () async {
                await validateEmailPasswordAndSignUp();
              },
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
          onPressed: () async {
            await viewModel.signInWithGoogle();
          },
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(hintText: hintText),
      obscureText: obfuscated,
      validator: validator,
    );
  }
}
