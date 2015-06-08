You will need to write the programming assignments in the R (You can download it for free,
see http://www.r-project.org/) or in MATLAB.

Write a program to implement the AdaBoost algorithm. Run the program on the TSS.mat
data set at the AdaBoost folder. (The data has handwritten digits of the number
"4" and number "7".)

File format: Each line is a dierent image. The images are 28 x 28 with each entry having a
gray level. This implies that an image has 784 entries. There are 1000 training examples and
200 test examples. The training examples are in X
train and their labels are in Y train.

The testing examples are in X test and their labels are in Y test.
Weak learner: A weak learner will correspond to a single pixel in the image and a threshold
value, i.e., x
> . Select at each iteration the best weak learner available.
Your experiments and the graphs you will output should address the following questions:
i;j
1. What happens when the number of iterations increases (both in the training error and
test error).
2. What happen when the size of the training set increases (you can use a random subset
of the training set).
3. How does the distribution changes through dierent iterations (qualitatively).




Execution: just Run muBoost file.