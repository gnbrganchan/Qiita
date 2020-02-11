rm(list=ls())
library(XLConnect)
setwd("C://Users//gnbrg//OneDrive//Documents//Qiita//R_Excel")

##読み込み
wb <- XLConnect::loadWorkbook("ひな形.xlsx")


##編集
###シート名の変更
renameSheet(wb, sheet = "Sheet1", newName = "あやめデータ")

###シートへ追記
dat <- iris
dat$index = 1:nrow(dat)
dat <- dat[,c(ncol(dat),1:(ncol(dat)-1))]

XLConnect::writeWorksheet(wb,dat,sheet = "あやめデータ",startRow = 3,startCol = 1,header = FALSE)

###フィルターの追加
XLConnect::setAutoFilter(wb,"あやめデータ","A2:F2")

###セルに書式を設定する
redA3 <- XLConnect::createCellStyle(wb)
XLConnect::setFillForegroundColor(redA3, color = XLC$COLOR.RED)
XLConnect::setFillPattern(redA3, fill = XLC$FILL.SOLID_FOREGROUND)
XLConnect::setCellStyle(wb, sheet = "あやめデータ", row = 3, col = 1:6, cellstyle = redA3)

###シートタブに色をつける
XLConnect::setSheetColor(wb,"あやめデータ",XLC$COLOR.LIGHT_GREEN )

###条件付き書式（がくの長さが6以上の行に色を塗る）
rowIndex <- which(dat$Sepal.Length > 6) + 2
index <- expand.grid(row=rowIndex,col=1:6)
longSepal <- XLConnect::createCellStyle(wb)
XLConnect::setFillForegroundColor(longSepal, color = XLC$COLOR.ORANGE)
XLConnect::setFillPattern(longSepal, fill =  XLC$"FILL.BIG_SPOTS")
XLConnect::setCellStyle(wb, sheet = "あやめデータ", row = index$row, col = index$col, cellstyle = longSepal)

###新しいシートを作成する
XLConnect::createSheet(wb,"新しいシート")

###不要なシートを削除する
XLConnect::removeSheet(wb,"不要なシート")


##xlsxファイルとして出力
XLConnect::saveWorkbook(wb,"あやめデータ.xlsx")
