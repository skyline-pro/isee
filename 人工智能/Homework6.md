## Homework6

### Problem1

+ step1

$G(A_1) = B(\frac{2}{5}) - [\frac{4}{5}B(\frac{1}{2}) + \frac{1}{5}B(0)] = 0.1709$

$G(A_2) = B(\frac{2}{5}) - [\frac{3}{5}B(\frac{1}{3}) + \frac{2}{5}B(0)] = 0.41997$

$G(A_3) = B(\frac{2}{5}) - [\frac{2}{5}B(\frac{1}{2}) + \frac{3}{5}B(\frac{1}{3})] = 0.01997$

So , we choose $A_2$ for the first split.

+ step2

We can notice that when $A_2=0$, it can be correctly classified. So we can only consider the situation when $A_2=1$.

$G(A_1) = B(\frac{1}{3}) - [\frac{1}{3}B(0) + \frac{2}{3}B(1)] = 0.9182$

$G(A_3) = B(\frac{1}{3}) - [\frac{1}{3}B(0) + \frac{2}{3}] = 0.2516$

So , we choose $A_1$ for the second split. All examples are classified correctly. The tree is as below:

![image-20220509185441689](https://cdn.jsdelivr.net/gh/skyline-pro/Picture//image-20220509185441689.png)

### Problem2

#### a.

The output of hidden layer $H_j$ is:
$$
H_j = c\sum_ix_i\cdot w_{ij} + b
$$
The final output $Y_k$ is:
$$
Y_k = c\sum_jH_j\cdot w_{jk} + b = c^2\sum_ix_i\sum_jw_{ij}w_{jk} + b(1+c\sum_jw_{jk})
$$
A network with np hidden units has the weight $w_{ik} = \sum_jw_{ij}w_{jk}$ , and the activation function is $g(x) = c^2x + b(1+c\sum_jw_{jk}$

#### b.

The operation can reduce a n-layer network to (n-1)-layer network straightly. By induction , the n-layer network can be reduced to a single-layer network. 

#### c.

The original network has $2nh$ weights , but the reduced network has $n^2$ weights. When $h \ll n$, the original network has far fewer weights than the reduced network, that means the original network can be trained much faster than the reduced network.