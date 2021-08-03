import 'dart:math';

class MathUtils {
  // i'm forced to use static otherwise i cannot access to those function from the outside
  // Sum an array
  static int sum (List arr) {
    if (arr == null || arr.length == 0 ) {
      return 0;
    } else {
      return arr.reduce((acc, curr) => acc + curr);
    }

  }

  // create an array of numbers between min and max (edges included)
  static List range(int min, int max) {
    int numerosity = max - min + 1;
    List<int> listOfValues = List<int>.filled(numerosity, 0);
    for (int i = 0; i < numerosity; i++) {
      listOfValues[i] = min + i;
    }
    return listOfValues;
  }

  // pick a random number between min and max (edges included)
  static int random(min, max) {
    var rn = new Random();
    if (max == 0) {
      return 0;
    } else {
      return min + rn.nextInt(max - min);
    }

  }

  // Given an array of numbers and a max...
  // Pick a random sum (< max) from the set of all available sums in arr
  static randomSumIn(List arr,int max) {
      List sets = [];
      sets.add([]);
      List<int> sums = [];
      for (int i = 0; i < arr.length; i++) {
        for (int j = 0, len = sets.length; j < len; j++) {
          List candidateSet = sets.elementAt(j)..add(arr.elementAt(i));
          int candidateSum = MathUtils.sum(candidateSet);
          if (candidateSum <= max) {
            sets.add(candidateSet);
            sums.add(candidateSum);
          }
        }
      }

      if (!sums.isEmpty) {
        return sums[MathUtils.random(0, sums.length)];
      } else {
        return 0;
      }

  }
}