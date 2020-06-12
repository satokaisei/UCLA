
clc;
clear all;
close all;
%parse data
setVar;

%declare variables
inputUnit = 784;
hiddenUnit = 100;
outputUnit = 10;
epoch = 1000;

training_size = 5000;
solution = zeros(500,2);
convergence = 0;
dconvergence = 0;
Nweight = 0;
Ndweight = 0;
variable = 1;

hiddenOutput = zeros(1,hiddenUnit);
endOutput = zeros(1,outputUnit);

weight1 = rand(hiddenUnit,inputUnit) -.5;
weight2 = rand(outputUnit, hiddenUnit) -.5;


%backprop
for i = 1 : epoch
    for j = 1 : training_size
        lRate = 1/sqrt(variable);
        label = [0 0 0 0 0 0 0 0 0 0];
        cur = training_labels(j) + 1;
        label(cur) = 1;
        
        [hiddenOutput, endOutput] = feedForward(training_images(:,j),hiddenOutput,endOutput,weight1,weight2,hiddenUnit,outputUnit);
        Nweight = Ndweight;
        
        Ndweight = (1/2)*(label-endOutput)*(label-endOutput)';
        
       errorAtOutput = (-1) *((label-endOutput).*endOutput.*(ones(1,outputUnit)-endOutput));
       weight2 = weight2 - lRate*(errorAtOutput' * hiddenOutput);
       
       errorAtHidden = (errorAtOutput*weight2).*(hiddenOutput.*(ones(1,hiddenUnit)-hiddenOutput));
       weight1 = weight1 - lRate*(errorAtHidden' * training_images(:,j)');
       
       convergence = convergence + abs(Ndweight-Nweight);
           if( j == training_size)
               if(abs(convergence-dconvergence) < i)
                   break;
               end
               dconvergence = convergence;
               convergence = 0;
           end
      variable = variable +1;
    end
end


%testing
counter = 0;

for i = 1 : 500
    [hiddenOutput, endOutput] = feedForward(test_images(:,i),hiddenOutput,endOutput,weight1,weight2,hiddenUnit,outputUnit);
    [~,index] = max(endOutput);
    solution(i,1) = test_labels(i);
    solution(i,2) = index-1;
    if(solution(i,1) == solution(i,2))
        counter = counter +1;
    end
end
accuracy = counter/500*100;
accuracy