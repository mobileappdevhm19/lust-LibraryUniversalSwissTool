//
class CapacityTime {
  static int getTimeForCapacityGraph() {
    var hour = new DateTime.now().toLocal().hour;

    hour = hour % 2 == 0 ? hour : hour - 1;

    return hour;
  }
}
