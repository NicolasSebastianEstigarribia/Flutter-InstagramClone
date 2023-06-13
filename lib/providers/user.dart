import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen.dart';

// ignore: constant_identifier_names
enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  Status _status = Status.Uninitialized;

  Status get status => _status;
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

  Future<String> signIn(
      String email, String password, BuildContext context) async {
    try {
      onAuthStateChanged(Status.Authenticating);

      String login =
          await _authMethods.loginUser(email: email, password: password);

      if (login == 'success') {
        onAuthStateChanged(Status.Authenticated);
        if (context.mounted) {
          //Navegar y romver la anterior para que no pueda volver
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreen(),
                webScreenLayout: WebScreen(),
              ),
            ),
            (route) => false,
          );
        }

        return login;
      } else {
        onAuthStateChanged(Status.Unauthenticated);
        return login;
      }
    } catch (e) {
      onAuthStateChanged(Status.Unauthenticated);
      return e.toString();
    }
  }

  Future signOut() async {
    _authMethods.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> onAuthStateChanged(Status status) async {
    _status = status;
    notifyListeners();
  }
}
