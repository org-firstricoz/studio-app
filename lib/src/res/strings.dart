/// Contains all the strings used accross the app.
/// Avoid hard coding strings.
/// All the strings must be added in this file.
/// ```dart
/// class AppStrings{
///  static const appName = "Riverpod app template";
///}
///```

class AppStrings {
  static const appName = "Riverpod app template";
}

class FailureMessage {
  static const getRequestMessage = "GET REQUEST FAILED";
  static const postRequestMessage = "POST REQUEST FAILED";
  static const putRequestMessage = "PUT REQUEST FAILED";
  static const deleteRequestMessage = "DELETE REQUEST FAILED";

  static const jsonParsingFailed = "FAILED TO PARSE JSON RESPONSE";

  static const authTokenEmpty = "AUTH TOKEN EMPTY";

  static const failedToParseJson = "Failed to Parse JSON Data";
}

class SnackBarMessages {
  static const productLoadSuccess = "Products Loaded Successfully";
  static const productLoadFailed = "Failed To Load Products";
}

class LogLabel {
  static const product = "PRODUCT";
  static const auth = "AUTH";
  static const httpGet = "HTTP/GET";
  static const httpPost = "HTTP/POST";
  static const httpPut = "HTTP/PUT";
  static const httpDelete = "HTTP/DELETE";
  static const sharedPrefs = "SHARED_PREFERENCES";
}

class AppRequestUrl {
  static const baseUrl = 'https://a7c7-103-24-84-183.ngrok-free.app';
  static const locationEndPoint = '/city';
  static const loginEndPoint = '/login';
  static const signupEndPoint = '/signup';
  static const homeViewEndPoint = '/homeview';
  static const descriptionEndpoint = '/description';
  static const reviewEndPoint = '/review';
  static const search = '/search';
  static const chat = '/chat';
  static const agent = '/agent';
  static const requestEndPoint = '/request';
  static const otpEndPoint = '/otp';
  static const loginOtpEndPoint = '/otp/login';
  static const payment = '/payment';
  static const filter='/filter';
}
