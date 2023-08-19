abstract class PropertyError {
  List<String>? phone;
  List<String>? name;
  List<String>? password;
  List<String>? passwordConfirmation;

  PropertyError({this.phone, this.name, this.password, this.passwordConfirmation});
}