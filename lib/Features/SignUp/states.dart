abstract class SignUpStates{}

class SignUpInit extends SignUpStates {}

class SignUpLoading extends SignUpStates {}

class SignUpError extends SignUpStates {
  final String message;

  SignUpError({required this.message});
}