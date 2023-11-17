class ComputeDeductibleSwapCoins {
  /*Function that returns the deductible swap coins */
  double computeDeductibleSwapCoins(double? listingValue, double? itemValue) {
    /*Percentage to deduct every transaction*/
    const double twoPercent = 0.02; // below 10K
    const double fourPercent = 0.04; // above 10K below 30K
    const double sixPercent = 0.06; //above 30K below 60K
    const double eightPercent = 0.08; //abpove 60K below 100K,
    const double tenPercent = 0.10; //above 100K,

    double averageValue = (listingValue! + itemValue!) / 2;
    if (averageValue < 10000) {
      return averageValue * twoPercent;
    } else if (averageValue > 10000 && averageValue <= 30000) {
      return averageValue * fourPercent;
    } else if (averageValue > 30000 && averageValue <= 60000) {
      return averageValue * sixPercent;
    } else if (averageValue > 60000 && averageValue <= 100000) {
      return averageValue * eightPercent;
    }
    return averageValue * tenPercent;
  }

  /*Function that returns the average value range */
  double averageValue(double? listingValue, double? itemValue) {
    double averagevalue = (listingValue! + itemValue!) / 2;
    return averagevalue;
  }

  /*Function that returns the percentage */
  String percentDeduction(double averageValue) {
    if (averageValue < 10000) {
      return "2% Transaction Fee";
    } else if (averageValue > 10000 && averageValue <= 30000) {
      return "4% Transaction Fee";
    } else if (averageValue > 30000 && averageValue <= 60000) {
      return "6% Transaction Fee";
    } else if (averageValue > 60000 && averageValue <= 100000) {
      return "8% Transaction Fee";
    }
    return "10% Transaction Fee";
  }
}
