# HomeWork4

## Problem1

### a

Yes. 

Numerically: P(B,E) = P(B)P(E)

Topologically: B and E are d-separated by A

### b

$$
P(B,E|a) = \alpha <0.95*0.001*0.002,0.94*0.001*0.998,\\0.29*0.999.0.002,0.001*0.999*0.998>\\
=\alpha<0.0008,0.3728,0.2303,0.3962>
$$

$$
\because P(b,e|a) = 0.008 \neq 0.0863=0.3736*0.2311=P(b|a)P(e|a)
$$

So , B and E are not conditionally independent given A

## Problem2

### a

(c)

### b

(a) and (b)

### c

(a)

### d

| $G_{father}$ | $G_{mother}$ | $P(G_{child} = l)$ |
| ------------ | ------------ | ------------------ |
| l            | l            | 1-m                |
| l            | r            | 0.5                |
| r            | l            | 0.5                |
| r            | r            | m                  |

### e

$$
P(G_{child} = l) = q^2\times (1-m) + 2\times 0.5\times q(1-q) + (1-q)^2m\\
=m+q-2mq
$$

## f

Since equilibrium means that $P(G_{child} = l) = P(G_{father} = l) = P(G_{mother} =l)$

So , $m+q-2mq = q$

$q=0.5$

But few humans are left-handed , so its wrong.

## Problem3

DBN has 3 values : $S_t$ , whether the student gets enough sleep ; $R_t$ , whether the student have red eyes ; $C_t$ , whether the student sleep at class. CPTs are as below:
$$
P(s_t) = 0.7 \\
P(s_{t+1} | s_t) = 0.8 \\
P(s_{t+1} |\neg s_t) = 0.8 \\
P(r_t | s_t) = 0.2 \\
P(r_t |\neg s_t) = 0.7 \\
P(c_t | s_t) = 0.1 \\
P(c_t |\neg s_t) = 0.3 \\
$$
 

To reformulate as an HMM with a single observation node, simply combine the 2-valued variables“having red eyes” and “sleeping in class” into a single 4-valued variable, multiplying
together the emission probabilities. (Probability tables omitted.)

## Problem4



### a

$$
P(S_0) = <0.7,0.3>\\
P(S_1) = <0.65,0.35>\\
P(S_1|e_1) = <0.8643,0.1357>\\
P(S_2|e_{1:2}) = <0.5010,0.4990>\\
P(S_3 | e_{1:3}) = <0.1045,0.8955>
$$

### b

$$
P(e_3|S_3) = <0.02,0.21>\\
P(e_3|S_2)=<0.588,0.153>\\
P(e_{2:3}|S_1)=<0.0233,0.0556>\\
P(S_1|e_{1:3})=<0.7277,0.2723>\\
P(S_2|e_{1:3})=<0.2757,0.7243>\\
P(S_3|e_{1:3})=<0.1045,0.8955>
$$

### c

The smoothed analysis places the time the student started sleeping one step earlier than than filtered analysis, integrating future observations indicating lack of sleep at the last step.