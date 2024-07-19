import 'package:bloc/bloc.dart';
import 'package:chapter/main.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:chapter/utility/network/api_request.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  signInUser() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    final oAuthResponse = await googleSignIn.signIn();
    if (oAuthResponse == null) {
      AuthFailed(errorMessage: "Failed to sign in user");
      return;
    }
    print("-------------- $oAuthResponse");
    prefs.setString("email", oAuthResponse.email);

    final response = await getRequest(apiEndPoint: ApiEndpoints.createUser);

    print("-------------- $response");

    if (response.data['status'] == 0) {
      AuthFailed(errorMessage: response.data['message'] ?? "Failed to sign in user");
      return;
    }

    AuthSuccess();
  }
}
