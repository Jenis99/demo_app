import 'environment.dart';

class Config {
  static String MAIN_URL = Environment.apiUrl;
  static String USER_IMG_URL = MAIN_URL+"";

  static String BASE_URL = MAIN_URL+"";
  static String LOGIN = BASE_URL+"";
  static String REGISTER = BASE_URL+"";
  static String OTP_VERIFY = BASE_URL+"";
  static String OTP_RESEND = BASE_URL+"";
  static String FORGOT_PASSWORD = BASE_URL+"";
  static String FORGOT_UPDATE_PASSWORD = BASE_URL+"";
  static String UPDATE_PROFILE = BASE_URL+"";
  static String CHANGE_PASSWORD = BASE_URL+"";
  static String ADD_REMINDER = BASE_URL+"";
  static String REMINDER_LIST = BASE_URL+"";
}
