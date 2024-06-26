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
  static const profile =
      'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs=';
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
  static const baseUrl = 'https://bookmystudio.azurewebsites.net';
  // static const baseUrl = 'http://192.168.0.106:3000';
  // static const baseUrl = 'https://booking-studio-node-apis.vercel.app';
  // name@gmail.com name123 https://booking-studio-node-apis.vercel.app
  static const locationEndPoint = '/api/v1/user/city';
  static const loginEndPoint = '/api/v1/user/login';
  static const signupEndPoint = '/api/v1/user/signup';
  static const homeViewEndPoint = '/api/v1/user/homeview';
  static const descriptionEndpoint = '/api/v1/user/description';
  static const reviewEndPoint = '/api/v1/user/review';
  static const search = '/api/v1/user/search';
  static const chat = '/api/v1/user/chat';
  static const agent = '/api/v1/user/agent';
  static const requestEndPoint = '/api/v1/user/request';
  static const otpEndPoint = '/api/v1/user/otp';
  static const loginOtpEndPoint = '/api/v1/user/otp/login';
  static const payment = '/api/v1/user/payment';
  static const filter = '/api/v1/user/filter';
  static const update = '/api/v1/user/update';
  static const favourites = '/api/v1/user/favourites';
  static const delete = '/api/v1/user/delete';
  static const help = '/api/v1/user/help';
}
