import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import '../../constants/messages.dart';

enum LocalAuth { none, password, biometric,  }

mixin LocalAuthMixin {
  static final LocalAuthentication auth = LocalAuthentication();

  Future<bool> biometricsAuthenticate([String? reasonString]) async {
    bool authenticated = false;

    if (await isBiometricsAvailable()) {
      authenticated = await auth.authenticate(
        localizedReason: reasonString ?? Messages.localizedReason,
        options: const AuthenticationOptions(biometricOnly: true, stickyAuth: false),
      );
    }

    return authenticated;
  }


  Future<bool> isBiometricsAvailable() async {
    bool canUseBiometrics = false;
    List<BiometricType> availableBiometrics = [];

    try {
      canUseBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      debugPrint('*** => Some error occurred on check biometrics availability');
    }

    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('*** => Some error occurred on enumerate biometrics availability');
    }

    if (availableBiometrics.isNotEmpty) {
      for (var ab in availableBiometrics) {
        debugPrint("\t$ab is available");
      }
      canUseBiometrics = true;
    } else {
      debugPrint('*** => NO BIOMETRICS AVAILABLE');
    }

    return canUseBiometrics;
  }
}
