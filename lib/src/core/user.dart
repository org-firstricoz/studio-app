import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

Map<String, dynamic> userDetails = {};
User user = User.empty();
late double latitude;
late double longitude;
bool newUser = false;
late Socket socket;
