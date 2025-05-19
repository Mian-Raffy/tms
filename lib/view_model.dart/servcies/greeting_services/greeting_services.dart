class Greeting {
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 5) {
      return 'Good Night';
    } else if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  Stream<String> getGreetingStream() async* {
    while (true) {
      yield getGreeting();
      final now = DateTime.now();
      final nextMinute =
          DateTime(now.year, now.month, now.day, now.hour, now.minute + 1);
      final waitDuration = nextMinute.difference(now);
      await Future.delayed(waitDuration);
    }
  }
}
