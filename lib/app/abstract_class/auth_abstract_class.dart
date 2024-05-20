abstract class AuthenticationProviderUseCase{
    Future<void>signUp();
    Future<void>verifyOtp();
    Future<void>registerUser();
  }