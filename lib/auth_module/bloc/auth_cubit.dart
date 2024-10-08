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
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();

      googleSignIn.signOut();
      final oAuthResponse = await googleSignIn.signIn();
      if (oAuthResponse == null) {
        throw "Google AUth Failed";
      }

      prefs.setString("email", oAuthResponse.email);
      prefs.setBool('signIn', true);

      final response = await postRequest(
        apiEndPoint: ApiEndpoints.createUser,
        postData: {
          "profile_url": oAuthResponse.photoUrl,
          "display_name": oAuthResponse.displayName,
          "fcm_token": prefs.getString("FCM_TOKEN"),
        },
      );

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(errorMessage: "Failed to sign in user"));

      print(e);
    }
  }
}
