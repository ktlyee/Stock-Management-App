import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'dart:io';

/// A simple usage example using synthetic data. To see more complex examples,
/// please, visit other directories in this folder

//class LinearReg{

// var dataFrame;
// LinearReg({this.dataFrame});

  Future main() async {
    // Let's create a dataframe with fitting data, let's assume, that the target
    // column is the fifth column (column with index 4)
    final dataFrame = DataFrame(<Iterable<num>>[
      [2, 3, 4, 5, 6],
      [12, 32, 1, 3, 3.5],
      [27, 3, 0, 59, 2.1],
    ], headerExists: false);

  // Let's create a regressor itself and train it
  final regressor = LinearRegressor(dataFrame, 'col_4',
      iterationsLimit: 100,
      initialLearningRate: 0.0005,
      learningRateType: LearningRateType.constant);

    // Let's see adjusted coefficients
    print('Regression coefficients: ${regressor.coefficients}');
    print('Learning Rate: ${regressor.learningRateType}');
    //print(regressor.predict(dataFrame).toMatrix());
    //DataFrame predict(DataFrame testFeatures);
  }
//}

