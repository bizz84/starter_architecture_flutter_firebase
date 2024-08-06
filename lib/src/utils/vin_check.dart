/// todo check
bool isValidVIN(String vin) {
  vin = vin.replaceAll(RegExp(r'\s'), '').toUpperCase();
  if (vin.length != 17) return false;

  // Define weights for VIN characters
  final Map<String, int> weights = {
    'A': 1,
    'B': 2,
    'C': 3,
    'D': 4,
    'E': 5,
    'F': 6,
    'G': 7,
    'H': 8,
    'J': 1,
    'K': 2,
    'L': 3,
    'M': 4,
    'N': 5,
    'P': 7,
    'R': 9,
    'S': 2,
    'T': 3,
    'U': 4,
    'V': 5,
    'W': 6,
    'X': 7,
    'Y': 8,
    'Z': 9,
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    '0': 0,
  };

  // Define the positions of the weights in the VIN
  final List<int> positions = [8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2];

  int sum = 0;
  for (int i = 0; i < 17; i++) {
    String char = vin[i];
    if (!weights.containsKey(char)) return false;
    sum += ((weights[char] ?? 0) * positions[i]);
  }

  // Check digit
  int checkDigit = sum % 11;
  if (checkDigit == 10) return vin[8] == 'X';
  return checkDigit == int.parse(vin[8]);
}
