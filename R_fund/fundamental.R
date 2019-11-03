rm(list=ls()) #�ϐ������Z�b�g

#��ƃt�H���_��ύX
setwd("C:/Users/gnbrg/OneDrive/Documents/Qiita/R_fund")

#���C�u�����ǂݍ���
##������Ȃ����C�u������install.packages()�ŃC���X�g�[��
library(readxl) #xlsx�t�@�C�����������C�u����

#�f�[�^�ǂݍ���
##�I�v�V����:sheet���V�[�g���@skip�����s�ǂݔ�΂��� header���f�[�^�̈�s�ڂ��w�b�_�Ƃ��ēǂݍ��ނ�
dat_csv <- read.csv("./iris.csv")
dat_excel <- read_excel("./iris.xlsx",sheet="iris",skip=1) #Excel�Ńt�@�C�����J���Ă����R����͊J���Ȃ��̂Œ���
dat_txt <- read.table("./iris.txt",sep="\t",header=T)

dat <- dat_excel

#�f�[�^���H�E���o
##�񖼑���
dat[1,2] #�s��̗v�f�Ƃ���1�s2��ڂ��Ăяo��
names(dat)#�f�[�^�̗�
names(dat) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species") #�񖼂̕ύX
names(dat)[1] <- "Sep.Len" #1��ڂ̗񖼂��w�肵�ĕύX
names(dat)[3:4] <- c("Pet.Len","Pet.Wid") #2~3��ڂ̗񖼂��w�肵�ĕύX
names(dat)[names(dat)=="Sepal.Width"] <- "Sep.Wid" #�ύX����񖼂��w�肵�ĕύX "Sepal.Width" -> "Sep.Wid"

##�f�[�^����
japanese_iris <- data.frame(en=c("setosa","versicolor","virginica"),jp=c("�q�I�E�M�A����","���@�[�V�J���[","���@�[�W�j�A"))#�f�[�^�t���[���쐬
dat <- merge(dat,japanese_iris,by.x="Species",by.y="en",all=T)

##����̍s�E��𒊏o
dat$Sep.Len #Sep.Len����x�N�g���Ƃ��Ď擾
dat$Species #Species����x�N�g���Ƃ��Ď擾
uniq_species <- unique(dat$Species)#�d����r������Species����擾
dat[dat$Species==uniq_species[1],] #Species��uniq_species��1�Ԗڂƈ�v����s�𒊏o
dat[dat$Sep.Len>6 & dat$Pet.Len<5.5,] #�s�ɕ����̏�����
names(dat)[6] <- "ja"
dat[dat$Sep.Len>6 & dat$Pet.Len<5.5,c("ja")] #�s�ɕ����̏����� & �����̂ݒ��o

#���f���쐬
model1 <- lm(Sep.Len ~ Pet.Len + Pet.Wid,data=dat) #�����ϐ�:Pet.Len, Pet.Wid  ������ϐ�:Sep.Len
summary(model1) #���肳�ꂽ�W���Ȃǃ��f���̊T�v��\��
model2 <- lm(Sep.Len ~ Pet.Len,data=dat) #�����ϐ�:Pet.Len ������ϐ�:Sep.Len
summary(model2) #���肳�ꂽ�W���Ȃǃ��f���̊T�v��\��

#����
library(ggplot2)
g1 <- ggplot()+geom_point(data=dat,aes(x=ja,y=Pet.Len))+theme(text=element_text(size=20))
show(g1)
g2 <- ggplot()+geom_point(data=dat,aes(x=Pet.Len,y=Sep.Len))+theme(text=element_text(size=20)) #�U�z�}���쐬
g2 <- g2 + geom_abline(colour="red",intercept = model2$coefficients[1],slope = model2$coefficients[2]) #��A������ԐF�ŏd�˂�
show(g2)

#�t�@�C���o��
write.table(dat,"./iris.csv",sep=",",row.names=F,col.names=T,quote=F)