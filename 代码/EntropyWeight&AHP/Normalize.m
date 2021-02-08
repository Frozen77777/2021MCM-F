function[result]=Normalize(dataset,max,min)
    result=(dataset-min)./(max-min);
end