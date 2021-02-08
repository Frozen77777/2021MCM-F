clear;
clc;
filename = 'orgndata.xlsx';
dataset = xlsread(filename);
record=zeros(9,4);
for i=1:9
noise=rand(10,2)*0.05-0.025;
dataset=dataset.*noise+dataset;

EF=dataset(:,1);
NoS=dataset(:,2);
dEF=EF(2:10)-EF(1:9);
dNoS=NoS(2:10)-NoS(1:9);
tc=5.929;
    
N=max(dEF)/tc*100;

[~,I] = max(dEF);

N1=2*NoS(I);
rate=(N1-NoS).*NoS;
normrate=Normalize(rate,max(rate),min(rate));
normdNoS=Normalize(dNoS,max(dNoS),min(dNoS));
normdata=[normdNoS,normrate(2:10)];

k=regress(dNoS(2:9),rate(3:10));

prdNoS=zeros(9,1);
prdNoS(1)=NoS(10);
for j=2:9
    prdNoS(j)=prdNoS(j-1)+k*(N1-prdNoS(j-1)).*prdNoS(j-1);
end

record(i,1)=N;
record(i,2)=N1;
record(i,3)=abs(N-769247)/769247;
record(i,4)=abs(N1-859998)/859998;
end
