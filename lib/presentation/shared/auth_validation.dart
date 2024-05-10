String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return "Email is required";
  } else if (!RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
    return "Enter a valid Email";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return "Password is required";
  }

  // TODO: Uncomment this code after seed in backend is updated
  /*
  else if (value.length < 6) {
    return "Password needs to be a minimum of 6 characters long";
  }
  */

  return null;
}
