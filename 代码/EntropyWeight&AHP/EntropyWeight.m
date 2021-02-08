function[weight]=EntropyWeight(dataset,max,min)
    [number,dimensions]=size(dataset);
    p=zeros(number,dimensions);
    lnp=zeros(number,dimensions);
    entropyweight=zeros(dimensions,1);
    normdataset=Normalize(dataset,max,min);
    
    SUM=sum(normdataset,1);
    SUM=SUM';
    for j=1:dimensions
        for i=1:number
            p(i,j)=normdataset(i,j)/SUM(j,:);
            if p(i,j)==0
                lnp(i,j)=0;
            else
                lnp(i,j)=log(p(i,j));
            end
        end
    end
    entropy=(-1/log(number))*(p'*lnp);
    
    SUMent=0;
    for i=1:dimensions
        SUMent=SUMent+entropy(i,i);
    end
    for i=1:dimensions
        entropyweight(i,:)=(1-entropy(i,i))/(dimensions-SUMent);
    end
    
    weight=entropyweight;
end
