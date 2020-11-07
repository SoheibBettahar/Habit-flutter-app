import 'package:habit/models/page.dart';

const HABIT = 'Habit';
// const CHOOSE_ACTIVITY = 'Choose Activity';
const NO_HABITS_CREATED = 'No Habits Created.';
const ENTER_HABIT = "Enter Habit";
const ABOUT_US = "About Us";
const SHOW_NOTIFICATION = "Show Notification";
const DELETE = "Delete";
const UPDATE = "Update";
const NOTIFICATION = 'Remind \nwith a notification';
const CHOOSE_ICON = 'Choose \nan icon';
const ICON_SELECTED = "Icon\nselected";
const START = "Start";
const NOT_SET = -1;
const HABIT_ID = "id";

const ID = "id";
const NAME = "name";
const STATUS = "status";
const IMAGE_URL = "image_url";
const DAYS = "days";
const NOTIFICATION_TIME = "notification_time";

const REMINDER_NOTIFICATION_TASK = "reminder_notification_task";
const DAILY_NOTIFICATION_TASK = "daily_notification_task";
const IS_FIRST_TIME_PREF_KEY = "is_first_time";

const List<OnBoardingPage> onBoardingPages = [
  OnBoardingPage(
      0,
      "Habit creation",
      "In psychology, it has long been established that 21 days is enough to develop a new habit (get rid of an old one) and 90 days to torn it into a lifestyle thus improve quality of life.",
      "illustrations/analyse.svg"),
  OnBoardingPage(
      1,
      "Set up a goal",
      "Create a goal in the app (the habit you want to change) and celebrate its successful daily completion.",
      "illustrations/plan.svg"),
  OnBoardingPage(
      2,
      "Regularity is important ",
      "If you skip the daily mark, the progress is reset, but you can start counter again.",
      "illustrations/jogging.svg"),
];
