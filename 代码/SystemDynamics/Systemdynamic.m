clear;
clc;
filename = 'orgndata.xlsx';
dataset = xlsread(filename);

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
for i=2:9
    prdNoS(i)=prdNoS(i-1)+k*(N1-prdNoS(i-1)).*prdNoS(i-1);
end
