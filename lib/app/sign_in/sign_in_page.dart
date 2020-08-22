import 'package:trust_ping_app/app/sign_in/email_password/email_password_sign_in_page.dart';
import 'package:trust_ping_app/app/sign_in/sign_in_view_model.dart';
import 'package:trust_ping_app/common_widgets/spaces.dart';
import 'package:trust_ping_app/common_widgets/images.dart';
import 'package:trust_ping_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:trust_ping_app/constants/keys.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/tpstyle.dart';

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(auth: auth),
      child: Consumer<SignInViewModel>(
        builder: (_, SignInViewModel viewModel, __) => SignInPage._(
          viewModel: viewModel,
          title: 'Trustping',
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({Key key, this.viewModel, this.title}) : super(key: key);
  final SignInViewModel viewModel;
  final String title;

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await viewModel.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    // Make content scrollable so that it fits on small screens
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // SizedBox(height: 32.0),
          SizedBox(
            height: 220.0,
            child: _buildHeader(),
          ),
          vspace32,
          SizedBox(
            height: 45.0,
            width: 250,
            child: RaisedButton(
              key: anonymousButtonKey,
              child: Text(Strings.goAnonymous),
              color: TPStyle.yellow,
              onPressed: viewModel.isLoading
                  ? null
                  : () => _signInAnonymously(context),
            ),
          ),
          vspace16,
          Text(
            Strings.or,
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          vspace16,
          SizedBox(
            height: 45.0,
            width: 250,
            child: RaisedButton(
              key: emailPasswordButtonKey,
              child: Text(Strings.signInWithEmailPassword),
              onPressed: viewModel.isLoading
                  ? null
                  : () => EmailPasswordSignInPageBuilder.show(context),
              color: TPStyle.lightGray,
            ),
          ),
          vspace16,
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (viewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      children: <Widget>[
        trustpingImage100,
        vspace16,
        Center(child: TPStyle.title("Konto erstellen")),
        // vspace8,
        // Center(child: Style.title(Strings.signIn)),
      ],
    );
  }
}
