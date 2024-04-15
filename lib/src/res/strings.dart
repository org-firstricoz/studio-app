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
  static const baseUrl = 'https://b971-103-24-84-27.ngrok-free.app';
  // name@gmail.com name123
  static const locationEndPoint = '/api/city';
  static const loginEndPoint = '/api/login';
  static const signupEndPoint = '/api/signup';
  static const homeViewEndPoint = '/api/homeview';
  static const descriptionEndpoint = '/api/description';
  static const reviewEndPoint = '/api/review';
  static const search = '/api/search';
  static const chat = '/api/chat';
  static const agent = '/api/agent';
  static const requestEndPoint = '/api/request';
  static const otpEndPoint = '/api/otp';
  static const loginOtpEndPoint = '/api/otp/login';
  static const payment = '/api/payment';
  static const filter = '/api/filter';
  static const update = '/api/update';
  static const favourites = '/api/favourites';
}
