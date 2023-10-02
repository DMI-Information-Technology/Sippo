import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/utils/states.dart';

import '../ConnectivityController/internet_connection_controller.dart';

class FirebaseAuthServiceController extends GetxController {
  final _netController = InternetConnectionController.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  var verificationId = "";
  final _states = States().obs;

  LightSubscription<States> addStateListener(
    void Function(States states) listener,
  ) {
    return _states.subject.listen(listener, cancelOnError: true);
  }

  void closeStateListener(LightSubscription<States> _subs) {
    // _states.subject.removeSubscription(_subs);
    _states.close();
  }

  States get states => _states.value;
  ConfirmationResult? confirmationResult;

  void set loadingState(bool value) {
    _states.value = _states.value.copyWith(isLoading: value);
  }

  void set successState(bool value) {
    _states.value = _states.value.copyWith(isSuccess: value);
  }

  void set errorState(bool value) {
    _states.value = _states.value.copyWith(isError: value);
  }

  Future<void> _webPhoneAuth(String? phoneNumber) async {
    if (phoneNumber != null)
      confirmationResult = await _firebaseAuth.signInWithPhoneNumber(
        phoneNumber,
      );
    else
      print("phone number is null");
  }

  Future<bool?> phoneAuthentication(
    String? phoneNumber, {
    int? secondDuration,
  }) async {
    if (_netController.isConnectionLostWithDialog()) return false;
    _states.value = _states.value.copyWith(isLoading: true);
    if (kIsWeb) {
      await _webPhoneAuth(phoneNumber);
    } else {
      await _firebaseAuth.verifyPhoneNumber(
        timeout: Duration(seconds: secondDuration ?? 30),
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          _states.value = _states.value.copyWith(
            isLoading: false,
            isSuccess: false,
            isError: true,
            message: error.message,
          );
          // print("The provided phone number is not valid.");
          Get.snackbar("failed", error.message.toString());
          print("from phoneAuthentication: ${error.message}");
          print("from phoneAuthentication: error code => ${error.code}");
        },
        codeSent: (verificationId, forceResendingToken) {
          _states.value = _states.value.copyWith(
            isLoading: false,
            isSuccess: verificationId.isNotEmpty,
            isError: false,
          );
          Get.snackbar(
            "Send OTP",
            "the code is sent",
            backgroundColor: Jobstopcolor.lightprimary2,
            colorText: Colors.black87,
          );
          this.verificationId = verificationId.trim();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _states.value = _states.value.copyWith(
            isLoading: false,
            isSuccess: verificationId.isNotEmpty,
            isError: false,
          );
          this.verificationId = verificationId.trim();
        },
      );
    }
    return true;
  }

  Future<void> verifyOTP(String? smsCode) async {
    loadingState = true;
    try {
      print("verificationId: $verificationId");
      if (_netController.isConnectionLostWithDialog()) {
        throw Exception("Connection lost.");
      }
      if (smsCode == null || verificationId.isEmpty) {
        throw Exception(
          "the verification id is not receive it or sms otp code is not found.",
        );
      }
      late final UserCredential? credential;
      if (kIsWeb) {
        credential =
            await confirmationResult?.confirm(smsCode.toString().trim());
      } else {
        credential = await _firebaseAuth.signInWithCredential(
          PhoneAuthProvider.credential(
            verificationId: this.verificationId,
            smsCode: smsCode.toString().trim(),
          ),
        );
      }
      _states.value = _states.value.copyWith(
        isSuccess: credential?.user != null,
        isError: !(credential?.user != null),
        message: credential?.user == null ? "verification is failed" : null,
      );
    } on FirebaseAuthException catch (e) {
      _states.value = _states.value.copyWith(
        isSuccess: false,
        isError: true,
        message: e.message,
      );
      print(e.message);
    } catch (e) {
      _states.value = _states.value.copyWith(
        isSuccess: false,
        isError: true,
        message: e.toString().replaceAll("Exception:", ""),
      );
      print(e.toString());
    } finally {
      loadingState = false;
    }
  }
}
