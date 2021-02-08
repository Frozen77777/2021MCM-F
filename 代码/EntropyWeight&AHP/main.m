clear;
clc;
filename = 'dataset.xlsx';
orgndata = xlsread(filename);
filename='matrix';
matrix=xlsread(filename);

temp=orgndata(:,3);
value=ones(7,1);
dis=abs(temp-value);
dis=1./dis;
orgndata(:,3)=dis;

maxvalue=orgndata(6,:);
minvalue=orgndata(7,:);
orgndata=orgndata(1:5,:);

entropyweight=EntropyWeight(orgndata,maxvalue,minvalue);
[weight,CR]=AHP(matrix);

data=Normalize(orgndata,maxvalue,minvalue);


ew=zeros(9,1);
ew(1,1)=entropyweight(1,1)/(entropyweight(1,1)+entropyweight(2,1));
ew(2,1)=entropyweight(2,1)/(entropyweight(1,1)+entropyweight(2,1));

ew(3,1)=entropyweight(4,1)/(entropyweight(4,1)+entropyweight(5,1));
ew(4,1)=entropyweight(5,1)/(entropyweight(4,1)+entropyweight(5,1));

ew(5,1)=entropyweight(6,1)/(entropyweight(6,1)+entropyweight(7,1)+entropyweight(8,1));
ew(6,1)=entropyweight(7,1)/(entropyweight(6,1)+entropyweight(7,1)+entropyweight(8,1));
ew(7,1)=entropyweight(8,1)/(entropyweight(6,1)+entropyweight(7,1)+entropyweight(8,1));

ew(8,1)=entropyweight(9,1)/(entropyweight(9,1)+entropyweight(10,1));
ew(9,1)=entropyweight(10,1)/(entropyweight(9,1)+entropyweight(10,1));

data1=zeros(5,5);
for i=1:5
    data1(i,1)=data(i,1:2)*ew(1:2,:);
    data1(i,2)=data(i,3);
    data1(i,3)=data(i,4:5)*ew(3:4,:);
    data1(i,4)=data(i,6:8)*ew(5:7,:);
    data1(i,5)=data(i,9:10)*ew(8:9,:);
end

score=zeros(5,1);
for i=1:5
    score(i,1)=data1(i,:)*weight;
end

meanscore=mean(data1,1);
maxscore=max(data1);
minscore=min(data1);
