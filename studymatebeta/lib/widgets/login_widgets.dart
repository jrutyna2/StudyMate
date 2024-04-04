import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

Widget buildBackgroundImage(BuildContext context) {
  return Stack(
    children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/background.jpg",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Image.asset(
            "assets/logo.png",
            width: 240,
            height: 120,
          ),
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(context).size.height * 0.54,
        left: 15,
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xff18C7FF), Color(0xffC84DFF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildEmailInput(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: 'Email',
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: const Icon(Icons.email),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    ),
  );
}

Widget buildPasswordInput(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: true,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: 'Password',
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: const Icon(Icons.lock),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    ),
  );
}

Widget buildLoginButton(BuildContext context, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: const Text('LOGIN'),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
      minimumSize: const Size(double.infinity, 50),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget buildOrSeparator() {
  return const Row(
      children: <Widget>[
        Expanded(child: Divider(color: Colors.white70)),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white70)),
      ],
  );
}

Widget buildSignUpButton(VoidCallback onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        'Need an account? ',
        style: TextStyle(color: Colors.white),
      ),
      TextButton(
        onPressed: onPressed,
        child: const Text(
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget buildRememberMeCheckbox(bool rememberMeValue, ValueChanged<bool?> toggleRememberMe, VoidCallback handleForgotPassword) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30), // Reduced horizontal padding
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible( // Wrap the inner Row with Flexible
          child: Row(
            mainAxisSize: MainAxisSize.min, // Make the Row take the minimum space
            children: <Widget>[
              Checkbox(
                value: rememberMeValue,
                onChanged: toggleRememberMe,
              ),
              const Flexible( // Make Text flexible to prevent overflow
                child: Text(
                  'Remember me?',
                  style: TextStyle(
                    color: Colors.white70,
                    // You can adjust the font size if needed
                    fontSize: 14, // Example: decrease font size
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent overflow visually
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: handleForgotPassword,
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSocialButtons(void Function(SignInService service) handleSignIn) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: IconButton(
            icon: Image.asset('assets/facebook.png'),
            onPressed: () => handleSignIn(SignInService.facebook),
          ),
        ),
        Flexible(
          child: IconButton(
            icon: Image.asset('assets/google.png'),
            onPressed: () => handleSignIn(SignInService.google),
          ),
        ),
        Flexible(
          child: IconButton(
            icon: Image.asset('assets/apple.png'),
            onPressed: () => handleSignIn(SignInService.apple),
          ),
        ),
        Flexible(
          child: IconButton(
            icon: Image.asset('assets/uog.jpg'),
            onPressed: () => handleSignIn(SignInService.uog),
          ),
        ),
      ],
    ),
  );
}
