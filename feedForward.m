function [hiddenOutput, endOutput] = feedForward(image,hiddenOutput,endOutput,weight1,weight2,hiddenUnit,outputUnit)
    inputToHidden = weight1*image;
    for i = 1:hiddenUnit
        hiddenOutput(1,i)= 1/(1+exp(-inputToHidden(i)));
    end
    for i = 1:outputUnit
        hiddenToOutput = weight2(i,:) * hiddenOutput';
        endOutput(1,i) = 1/(1+exp(-hiddenToOutput));
    end
    
end

