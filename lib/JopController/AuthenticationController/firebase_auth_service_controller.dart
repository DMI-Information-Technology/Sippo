import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';

import 'package:jobspot/utils/states.dart';

import '../ConnectivityController/internet_connection_controller.dart';

class FirebaseAuthServiceController extends GetxController {
  Timer? timer;
  final _netController = InternetConnectionController.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final verificationId = "".obs;
  final _states = States().obs;

  States get states => _states.value;

  void set loadingState(bool value) {
    _states.value = _states.value.copyWith(isLoading: value);
  }

  void set successState(bool value) {
    _states.value = _states.value.copyWith(isSuccess: value);
  }

  @override
  void onInit() async {
    super.onInit();
  }

  void set errorState(bool value) {
    _states.value = _states.value.copyWith(isError: value);
  }

  Future<bool?> phoneAuthentication(
    String? phoneNumber, {
    int? secondDuration,
  }) async {
    if (_netController.isConnectionLostWithDialog()) return false;
    _states.value = _states.value.copyWith(isLoading: true);
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
        print("The provided phone number is not valid.");
        Get.snackbar("failed", error.message.toString());
        print(error.message);
      },
      codeSent: (verificationId, forceResendingToken) {
        _states.value = _states.value.copyWith(
          isLoading: false,
          isSuccess: true,
          isError: false,
        );
        Get.snackbar(
          "Sent OTP",
          "the code is sent",
          backgroundColor: Jobstopcolor.lightprimary2,
          colorText: Colors.black87,
        );
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _states.value = _states.value.copyWith(
          isLoading: false,
          isSuccess: true,
          isError: false,
        );
        this.verificationId.value = verificationId;
      },
    );
    return true;
  }

  Future<void> verifyOTP(String? smsCode) async {
    loadingState = true;
    if (smsCode != null && verificationId.toString().isNotEmpty) {
      try {
        if (_netController.isConnectionLostWithDialog()) {
          throw Exception("Connection lost.");
        }
        final credential = await _firebaseAuth.signInWithCredential(
          PhoneAuthProvider.credential(
            verificationId: this.verificationId.toString(),
            smsCode: smsCode.toString(),
          ),
        );
        _states.value = _states.value.copyWith(
          isSuccess: credential.user != null,
          isError: !(credential.user != null),
          message: credential.user == null ? "verification is failed" : null,
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

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
