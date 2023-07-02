# Homework5

## Problem 1

Because:
$$
L = -N(log\sqrt{2\pi}+log\sigma) - \sum_{i=1}^N\frac{(y_i - (\theta_1x_i+\theta_2))^2}{2\sigma^2}
$$
Hence:
$$
\frac{\partial L}{\partial \theta_1} = \frac{\sum_ix_iy_i-\theta_1\sum_ix_i^2-\theta_2\sum_ix_i}{\sigma^2}=0 \\
\frac{\partial L}{\partial \theta_2} = \frac{\sum_iy_i-\theta_1\sum_ix_i-N\theta_2}{\sigma^2}=0 \\
\frac{\partial L}{\partial \sigma} = -\frac{N}{\sigma}+\sum_i\frac{(y_i-\theta_1x_i-\theta_2)^2}{\sigma^3}=0
$$
and the solution is:
$$
\theta_1 = \frac{N\sum_ix_iy_i-\sum_ix_i\sum_iy_i}{m\sum_ix_i^2+(\sum_ix_i)^2} \\
\theta_2 = \frac{\sum_iy_i - \theta_1\sum_ix_i}{N} \\
\sigma = \frac{1}{N}\sum_i(y_i-\theta_1x_i-\theta_2)^2
$$

## Problem2

### a.

$$
(\pi)^p(1-\pi)^n
$$

### b.

$$
L = logD = p\log\pi+n\log(1-\pi)
$$

$$
\frac{\partial L}{\partial \pi} = \frac{p}{\pi} - \frac{n}{1-\pi} = 0
$$

So, $\pi = \frac{p}{n+p}$ 

### c.

![image-20220424145958265](https://cdn.jsdelivr.net/gh/skyline-pro/Picture//image-20220424145958265.png)

### d.

$$
\pi^p(1-\pi)^n\prod_i\alpha_i^{p_i^+}(1-\alpha_i)^{n_i^+}\beta_i^{p_i^-}(1-\beta_i)^{n_i^-}
$$

### e.

$$
L = p\log\pi + n\log(1-\pi)+\\ \sum_i p_i^+\log\alpha_i+n_i^+\log(1-\alpha_i)+p_i^-\log\beta_i+n_i^-\log(1-\beta_i)
$$

$$
\frac{\partial L}{\partial \alpha_i} = \frac{p_i^+}{\alpha_i} - \frac{n_i^+}{1-\alpha_i} = 0 , \frac{\partial L}{\partial \beta_i} = \frac{p_i^-}{\beta_i} - \frac{n_i^-}{1-\beta_i} = 0
$$

So,
$$
\alpha_i = \frac{p_i^+}{p_i^++n_i^+}\text{ , means the fraction of cases where } X_i\text{ is true given Y is true}\\
\beta_i=\frac{p_i^-}{p_i^-+n_i^-}\text{ , means the fraction of cases where } X_i\text{ is true given Y is false}
$$
