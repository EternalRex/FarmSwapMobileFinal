class ComputeSellDeductibleSwapCoins {
  double computeDeductibleSwapCoins(purchaseValue) {
    /*Percentage to deduct every transaction*/
    const double twoPercent = 0.02; // below 10K
    const double fourPercent = 0.04; // above 10K below 30K
    const double sixPercent = 0.06; //above 30K below 60K
    const double eightPercent = 0.08; //abpove 60K below 100K,
    const double tenPercent = 0.10; //above 100K,

    if (purchaseValue < 10000) {
      return purchaseValue * twoPercent;
    } else if (purchaseValue > 10000 && purchaseValue <= 30000) {
      return purchaseValue * fourPercent;
    } else if (purchaseValue > 30000 && purchaseValue <= 60000) {
      return purchaseValue * sixPercent;
    } else if (purchaseValue > 60000 && purchaseValue <= 100000) {
      return purchaseValue * eightPercent;
    }
    return purchaseValue * tenPercent;
  }

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
