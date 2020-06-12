convertMNIST;
load('mnist.mat');

training_size = training.count;

training_images = [];
training_labels = [];

test_image = [];
test_labels = [];

for i = 1: training.count
    training_labels(i) = training.labels(i);
    cur = 1;
    for j = 1:training.width
        for k = 1:training.height
            training_images(cur,i) = training.images(j,k,i);
            cur = cur+1;
        end
    end
end


for i = 1: test.count
    test_labels(i) = test.labels(i);
    cur = 1;
    for j = 1:test.width
        for k = 1:test.height
            test_images(cur,i) = test.images(j,k,i);
            cur = cur+1;
        end
    end
end

