library(ggplot2)

data <- read.table(file="D:/RDATA/201701.csv", header=TRUE, sep=",")  #�Hread.table()�Ncsv�פJ�ë��w��data
data <- as.data.frame.matrix(data)                   #�Ndata�ରdata frame�Mmatrix���A
days <- 0                                            #�����Y�ɬq���ȹB�q
date <- 0                                            #�����Y����ɬq���ȹB�q
per <- 0                                             #�U���Ȯ��ܼƥΥH�[�`
sum = matrix(1:35, nrow = 5, ncol = 7)               #�����C���C���`�ȹB�q

for(k in c(1:5)){
  for(j in c(1:7)){                                  #���1/1-1/7�����
    row <- array()                                   #�����}�l�����ƪ��C��
    row2 <- array()                                  #������������ƪ��C��
    row[j] <- (21*(j-1))+1                           #�p��q�ĴX�C(�X�I)�}�l������
    row2[j] <- 21*j                                  #�p���ĴX�C(�X�I)���������
    obj <- c(44, 44, 74, 39, 6)
    
    for (i in c(row[j]: row2[j])) { 
        if(class(data[i,obj[k]]) == "character"){    #19-31�Ncsv�ɤ����A�����Ʀr�����ର�Ʀr
          t <- strsplit(data[i,obj[k]],",")          #�N�ӵ���ƥH","�������I������
          if(is.na(t[[1]][2])){                      #�p�r���e�S���ȫh�ӼƦr���d��H�U����
            per <- as.integer(t[[1]][1])
          }else{                                     #�p�r���e���ȫh�ӼƦr���d��H�W����
            per <- as.integer(t[[1]][1])*1000 + as.integer(t[[1]][2])
          }
        }else{
          per <- as.integer(data[i,j])
        }
        if(is.na(per)){
          next()
        }
      
        days [i] <- per                              #�N�Ȧs����ƥ�idays�}�C
        sum[k,j] <- sum[k,j] + days[i]               #�N�C�Ӯɬq����ư��[�`�å�isum�}�C
        date[j] <- data[row[j],1]                    #�N��ƪ������idate�}�C
    }
  }
}

perDailySum <- data.frame(date, sum[1,], sum[2,], sum[3,], sum[4,], sum[5,])
ggplot(perDailySum, aes(x = date, group = 1)) +      #�Hdate��x�bø�X��u��
  geom_line(aes(y = sum[1,]), colour = "blue") +     #�H�x�_������i����Ƭ�y�b�åH�Ŧ�uø�X
  geom_line(aes(y = sum[2,]), colour = "red") +      #�H�x�_������i����Ƭ�y�b�åH����uø�X
  geom_line(aes(y = sum[3,]), colour = "green") +    #�H�����i����Ƭ�y�b�åH���uø�X
  geom_line(aes(y = sum[4,]), colour = "yellow") +   #�H���ˬ���i����Ƭ�y�b�åH����uø�X
  geom_line(aes(y = sum[5,]), colour = "brown")      #�H�����_������i����Ƭ�y�b�åH�Ħ�uø�X

n <- c(sum[,1],sum[,2],sum[,3],sum[,4],sum[,5])

plot(n, pch = 17, col = "blue", cex =2)              #ø�X��ƴ��G��
points(mean(n), pch = 4, col = "red", cex = 2)      #�e�����ƪ��I
points(median(n), pch = 3, col = "red", cex = 2)    #�e����ƪ��I

sd(n)                          #�зǮt 
var(n)                         #�ܲ���
cv <- 100 * sd(n) / mean(n)    #�ܲ��Y�� 
cv 
range(n)[2] - range(n)[1]      #���Z

summary(n)                     #�`���ƾ�
quantile(n)                    #�ʤ��� 