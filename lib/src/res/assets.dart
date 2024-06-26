import 'package:flutter_riverpod_base/src/res/base.dart';

/// Contains all the paths of image used across the project.
/// Every image path variable name must contain a name and its extension.
/// example :
///
/// for an image with name avatar.png,
/// a suitable variable can be [avatarImagePng].
/// ```dart
/// static const sampleImagePng = "$_base/image.png";
/// ```
/// can be used by doing
/// ```dart
/// ImageAssets.sampleImagePng
/// ```
class ImageAssets {
  static const _base = BasePaths.baseImagePath;
  static const _baseIconPath = BasePaths.baseIconsPath;

  static const sampleImagePath = "$_base/image.png";

  static const profileImageJpeg = "$_base/profile.jpeg";

  // images
  

  //Svg assets for  [onboarding]
  static const page1 = "$_base/undraw_house_searching_re_stk8 1.svg";
  static const page2 = "$_base/undraw_online_calendar_re_wk3t 1.svg";
  static const page3 = "$_base/app_overview.png";

  //svg icons
  static const lock = "$_baseIconPath/lock.svg";
  static const browse = "$_baseIconPath/browse.svg";
  static const helpcircle = "$_baseIconPath/help-circle.svg";
  static const logout = "$_baseIconPath/log-out.svg";
  static const settings = "$_baseIconPath/settings.svg";
  static const user1 = "$_baseIconPath/user1.svg";
  static const vector1 = "$_baseIconPath/vector1.svg";
  static const key = "$_baseIconPath/key.svg";
  static const trash2 = "$_baseIconPath/trash-2.svg";
  static const smile = "$_baseIconPath/smile.svg";
  static const link = "$_baseIconPath/link.svg";
  static const camera = "$_baseIconPath/camera.svg";
  static const otp = "$_baseIconPath/otp.svg";
  static const mapPoints = "$_baseIconPath/map-points.svg";

  static const successCheckBox = "$_baseIconPath/suceess-checkbox.svg";
  static const starSvg = "$_baseIconPath/star.svg";
  static const discountSvg = "$_baseIconPath/discount.svg";
  static const notificationSvg = "$_baseIconPath/notification.svg";

  // images
  static const facebook = "assets/images/Facebook_logo.png";
  static const google = "$_base/Google_logo.png";
  static const apple = "$_base/Apple_logo.png";

  static const photgraphy = "$_base/cat-photo.png";
  static const art = "$_base/cat-art.png";
  static const music = "$_base/cat-music.png";
  static const dance = "$_base/cat-dance.png";

  //studio image
  static const studio = "$_base/studio.png";
  static const studio1 = "$_base/studio1.png";
  static const studio2 = "$_base/studio2.png";
  static const studio3 = "$_base/studio3.png";
  static const studio4 = "$_base/studio4.png";
  static const studio5 = "$_base/studio5.png";
  static const studio6 = "$_base/studio6.png";
  static const studio7 = "$_base/studio7.png";
  static const studio8 = "$_base/studio8.png";
  static const mapImage = "$_base/map-image.jpg";

  static const privacyIcon = "$_base/privacy_icon.svg";

  //bottom nav bar items
  static const home = "$_baseIconPath/home.svg";
  static const explore = "$_baseIconPath/map-pin.svg";
  static const favorite = "$_baseIconPath/heart.svg";
  static const chat = "$_baseIconPath/message-square.svg";
  static const profile = "$_baseIconPath/user1.svg";

  // icons svgs
  static const tune = "$_baseIconPath/git-pull-request.svg";
  static const search = "$_baseIconPath/search.svg";
}

class AnimationAssets {
  static const _base = BasePaths.baseAnimationPath;
  static const splashAnimation = "$_base/splash.riv";
}

class PlaceholderAssets {
  static const _base = BasePaths.basePlaceholderPath;

  static const carouselCardJpeg = "$_base/carousel_placehoder.jpeg";
}
