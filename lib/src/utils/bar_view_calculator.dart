class BarViewCalculator {
  late double maximum;
  late double minimum;
  final List<double> values;

  BarViewCalculator({required this.values}) {
    minimum = (values.reduce((curr, next) => curr < next ? curr : next)) * .19;
    maximum = (values.reduce((curr, next) => curr > next ? curr : next)) * 1.2;
  }
  List<String> calculateMarkings() => maximum == minimum
      ? List.generate(5, (_) => '')
      : List.generate(6, (i) => minimum + i * (maximum - minimum) / 5)
          .map((e) => e.toStringAsFixed(2))
          .skip(1)
          .toList();
  double calculateFlexValue(double x) => maximum == 0
      ? maximum
      : maximum == minimum
          ? x / maximum
          : (x - minimum) / (maximum - minimum);
}
