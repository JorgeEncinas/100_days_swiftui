//: A Cocoa based Playground to present user interface
import CreateML
import Foundation

let data = try MLDataTable(
    contentsOf: URL(fileURLWithPath: "/Users/jorge/Desktop/CreateML/reviews.json")
)

// A lot of this code is deprecated or non-functional by this point.
// but let's keep writing it

//Split 80 / 20
let (trainingData, testingData) = data.randomSplit(by: 0.8)
let classifier = try MLTextClassifier(
    trainingData: trainingData,
    textColumn: "text",
    labelColumn: "label"
)

let evaluationMetrics = classifier.evaluation(
    on: testingData,
    textColumn: "text",
    labelColumn: "label"
)
let errorData = evaluationMetrics.classificationError * 100

let metadata = MLModelMetadata(
    author: "Paul Hudson",
    shortDescription: "A model for sentimental analysis",
    version: 5.0
)

try classifier.write(
    to: URL(fileURLWithPath: "/Users/jorge/Desktop/result.mlmodel"),
    metadata: metadata
)

// That's another ML Model.

// REGRESSION ANALYSIS
// Estimate how manipulating multiple variables can bring about a specific result

// 1. Regression analysis only estimates RELATIONSHIPS amongst its variables.
// 2. Providing sufficient data is important.

// MODELS THAT APPLE PROVIDES
//      - Linear
//      - Decision Tree
//      - Boosted Tree
//      - Random Forest

// LINEAR REGRESSORS
//      Attempt to estimate relationships btw variables
//      by considering them as part of a linear function
//          applyAlgorithm(a, b, c)
//      Line of Best Fit ("Straight Line through all the data points, as close as possible")

// DECISION TREE REGRESSORS
//  Form a natural tree structure, conforming a hierarchy of decisions.
//  Like a game of 20 questions, branching paths from questions.

// You can imagine navigating easily until you get an answer.
//  Try to imagine one with very complex data, however.
//  then it becomes less useful.

// BOOSTED TREE REGRESSORS
//  Will often provide the best results
//  Uses a collection of regular Decision Trees, where each tree serves
//  to correct previous trees.
//      Say the 1st tree has an error rate of 20%
//      it gets passed to the next tree to refine the answer.
//      Tree 2 has 10% error rate, Tree 3 has error rate 8%, the next one 7%

// RANDOM FOREST REGRESSORS
//  Straightforward if you understand boosted tree regressors.
//  Since BTR uses an ensemble of Decision Tree Regressors, to help get the best accuracy.

// Random Forest also does that.
// With boosted trees, each tree has access to all the data
// BUT, with Random Forests, each tree has access to a subset of the data.

// Hiding data may lead to better inference!
// It's like getting different perspectives on a problem.

// Regression analysis works with JSON data
//  CreateML gives us a variety of regression models, and each correspond to a class
//      - MLLinearRegressor
//      - MLDecisionTreeRegressor
//      - MLBoostedTreeRegressor
//      - MLRandomForestRegressor
// However, when you don't care, there's a higher level abstraction
//  called MLRegressor, which will try out different approaches and
//  choose the one that performs best.

//import CreateML

let data2 = try MLDataTable(
    contentsOf: URL(fileURLWithPath: "/Users/jorge/Desktop/CreateML/house-prices.json")
)
// Now let's split
let (trainingData2, testingData2) = data2.randomSplit(by: 0.8)


// Now what's the attribute we want to predict?
let pricer = try MLRegressor(
    trainingData: trainingData2, targetColumn: "value"
)

let evaluationMetrics2 = pricer.evaluation(on: testingData2)

print(evaluationMetrics2.rootMeanSquaredError)
print(evaluationMetrics2.maximumError)

// When you create a specific regressor, you can tune its parameters so you can
// get a better performance, compared to just having a generic MLRegressor instance



let params =  MLRandomForestRegressor.ModelParameters(
    maxIterations: 500
)
let pricer2 = try MLRandomForestRegressor(
    trainingData: trainingData,
    targetColumn: "value",
    parameters: params
) //This is worse, which is why it's often better to use MLRegressor.

// Let's look in the playground output for our first model.
// You can see which model it chose, and it chose Boosted Tree Regression

let params2 = MLBoostedTreeRegressor.ModelParameters(
    maxIterations: 500
)
let pricer3 = try MLBoostedTreeRegressor(
    trainingData: trainingData,
    targetColumn: "value",
    parameters: params2
)

// Now we would get better results.


// Time to save the model

let metadata2 = MLModelMetadata(
    author: "Paul Hudson",
    shortDescription: "A Boosted Tree Regression Model",
    version: "6.0"
)
try pricer.write(
    to: URL(fileURLWithPath: "/Users/jorge/Desktop/model2.mlmodel"),
    metadata: metadata2
)
