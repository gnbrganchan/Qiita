rm(list=ls())

library(iml)
library(randomForest)

savepng <- FALSE

data("Boston", package  = "MASS")
head(Boston)
set.seed(42)
data("Boston", package  = "MASS")
rf = randomForest(medv ~ ., data = Boston, ntree = 50)

X = Boston[which(names(Boston) != "medv")]
predictor = Predictor$new(rf, data = X, y = Boston$medv)

#モデルの性能や特性の評価
#understand entire model
#ある変数列の値をシャッフルすると予測精度が大きく低下する＝重要度が高い
imp = FeatureImp$new(predictor, loss = "mse")
if(savepng){
  png("featureimportance.png", width = 300, height = 300)
  plot(imp)
  dev.off()
}else{
  plot(imp)
}

#特徴量（変数）に対するモデルの応答を見る
#PDP：ある観察に対して、注目する変数以外はすべて同じ値をもつ観察がたくさんあったとき、
#対象の変数の値の増減によって予測値がどう変化するか？

#ALE:ある特徴量の近傍で、平均的にモデルの予測値がどう変化するか？
#（Accumulated Local Effect）
#注目する特徴の値の周りの区間でモデルの勾配を観察している
#PDPと比べて
#特徴が相関してもうまくいく
#計算量が少ない
ale = FeatureEffect$new(predictor, feature = "lstat")
if(savepng){
  png("featureeffect.png", width = 500, height = 500)
  ale$plot()
  dev.off()
  png("featureeffect2.png", width = 500, height = 500)
  ale$set.feature("rm")
  ale$plot()
  dev.off()
}else{
  ale$plot()
  ale$set.feature("rm")
  ale$plot()
}

#RuleFitの論文中で提案されているH-Statisticを指標とする
#0（interactionなし）～1（f(x)の分散のうち、100%がinterationsに由来する）
interact = Interaction$new(predictor)
if(savepng){
  png("interaction.png", width = 500, height = 500)
  plot(interact)
  dev.off()
}else{
  plot(interact)
}

interact = Interaction$new(predictor, feature = "crim")
if(savepng){
  png("interaction2.png", width = 500, height = 500)
  plot(interact)
  dev.off()
}else{
  plot(interact)
}

#ICE:ある観察の予測値の変化を観察したとき
#他の変数はどう振る舞っているか？
effs = FeatureEffects$new(predictor)
plot(effs)

#あるデータに対する予測がどのように得られたかを説明する
#understand features
#複雑なモデルの入力と予測をデータとして、単純なモデルでフィットしなおす
#あらゆるブラックボックスに対して使用できる
#R^2値などでブラックボックスによる予測に対する近似精度を簡単に測定できる
#モデルが出力する予測値について説明する（データの説明ではない）
if(savepng){
  png("treesurrogate.png", width = 500, height = 500)
  tree = TreeSurrogate$new(predictor, maxdepth = 2)
  plot(tree)
  dev.off()
}else{
  tree = TreeSurrogate$new(predictor, maxdepth = 2)
  plot(tree)
}

head(tree$predict(Boston))

#local interpretation(for single prediction)
#LIME(Locally Interpretable Model-agnostic Explanations)
#説明したい観察の周辺で、単純な線形モデルによる近似を行う
#近似モデルの重みが、各変数の予測に対する説明を表す
#表形式のデータ・テキスト・及び画像のどれにたいしても機能する
#ブラックボックスモデル（の決定境界）の複雑性に依存して説明が安定しない。サンプリングプロセスを繰り返すと説明が変わる可能性がある。

library(glmnet)
library(Matrix)
library(foreach)
library(gower)
lime.explain = LocalModel$new(predictor,x.interest = X[1,])
lime.explain$results
if(savepng){
  png("lime.png", width = 500, height = 500)
  plot(lime.explain)
  dev.off()
}else{
  plot(lime.explain)
}

#ある予測が得られる過程を協力ゲームと考える
#各変数の貢献度を特徴間で報酬を公平に配分する
#すべての観察についてすべての特徴量の組み合わせを総当たりにすると
#計算コストが高いのでimlではモンテカルロサンプリングによる近似を採用
#/そのため、サンプリングが少数だと推定結果が不安定に
#完全な説明を提供する強固な理論保証がある。
shapley = Shapley$new(predictor, x.interest = X[1,])
if(savepng){
  png("shapley.png", width = 500, height = 500)
  shapley$plot()
  dev.off()
}else{
  shapley$plot()
}

results = shapley$results
head(results)
