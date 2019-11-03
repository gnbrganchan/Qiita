rm(list=ls()) #変数をリセット

#作業フォルダを変更
setwd("C:/Users/gnbrg/OneDrive/Documents/Qiita/R_fund")

#ライブラリ読み込み
##見つからないライブラリはinstall.packages()でインストール
library(readxl) #xlsxファイルを扱うライブラリ

#データ読み込み
##オプション:sheet→シート名　skip→何行読み飛ばすか header→データの一行目をヘッダとして読み込むか
dat_csv <- read.csv("./iris.csv")
dat_excel <- read_excel("./iris.xlsx",sheet="iris",skip=1) #Excelでファイルを開いているとRからは開けないので注意
dat_txt <- read.table("./iris.txt",sep="\t",header=T)

dat <- dat_excel

#データ加工・抽出
##列名操作
dat[1,2] #行列の要素として1行2列目を呼び出し
names(dat)#データの列名
names(dat) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species") #列名の変更
names(dat)[1] <- "Sep.Len" #1列目の列名を指定して変更
names(dat)[3:4] <- c("Pet.Len","Pet.Wid") #2~3列目の列名を指定して変更
names(dat)[names(dat)=="Sepal.Width"] <- "Sep.Wid" #変更する列名を指定して変更 "Sepal.Width" -> "Sep.Wid"

##データ結合
japanese_iris <- data.frame(en=c("setosa","versicolor","virginica"),jp=c("ヒオウギアヤメ","ヴァーシカラー","ヴァージニア"))#データフレーム作成
dat <- merge(dat,japanese_iris,by.x="Species",by.y="en",all=T)

##特定の行・列を抽出
dat$Sep.Len #Sep.Len列をベクトルとして取得
dat$Species #Species列をベクトルとして取得
uniq_species <- unique(dat$Species)#重複を排除してSpecies列を取得
dat[dat$Species==uniq_species[1],] #Speciesがuniq_speciesの1番目と一致する行を抽出
dat[dat$Sep.Len>6 & dat$Pet.Len<5.5,] #行に複数の条件式
names(dat)[6] <- "ja"
dat[dat$Sep.Len>6 & dat$Pet.Len<5.5,c("ja")] #行に複数の条件式 & 特例列のみ抽出

#モデル作成
model1 <- lm(Sep.Len ~ Pet.Len + Pet.Wid,data=dat) #説明変数:Pet.Len, Pet.Wid  被説明変数:Sep.Len
summary(model1) #推定された係数などモデルの概要を表示
model2 <- lm(Sep.Len ~ Pet.Len,data=dat) #説明変数:Pet.Len 被説明変数:Sep.Len
summary(model2) #推定された係数などモデルの概要を表示

#可視化
library(ggplot2)
g1 <- ggplot()+geom_point(data=dat,aes(x=ja,y=Pet.Len))+theme(text=element_text(size=20))
show(g1)
g2 <- ggplot()+geom_point(data=dat,aes(x=Pet.Len,y=Sep.Len))+theme(text=element_text(size=20)) #散布図を作成
g2 <- g2 + geom_abline(colour="red",intercept = model2$coefficients[1],slope = model2$coefficients[2]) #回帰直線を赤色で重ねる
show(g2)

#ファイル出力
write.table(dat,"./iris.csv",sep=",",row.names=F,col.names=T,quote=F)
