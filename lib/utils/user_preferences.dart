

import '../model/user.dart';

class UserPreferences {
  static const myUser = User(
    imagePath:
    "assets/images/278250160_1579945952390104_6541379510025297465_n.jpg",
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
    'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );

  static void setUser(User user) {}
}