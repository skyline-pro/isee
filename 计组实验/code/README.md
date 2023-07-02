# CPU

## 勘误
1. Decode.v第55行处`parameter ORI_funct3 = 3'b101`应为`parameter ORI_funct3 = 3'b110`

## 编写adder_4bits.v

## 编写adder_32bits.v

## ALU模块
主要难点在于slt与sltu的书写，这一模块输入为
$$A[31],B[31],sum[31]$$

### sltu部分
列出真值表：

| A[31] | B[31] | sum[31] | result |
| ---   | ---   | ---     | ---    | 
|  0|0|0|1|
|  0|0|1|0|
|  0|1|0|1|
|  0|1|1|1|
|  1|0|0|0|u
|  1|0|1|0|
|  1|1|0|1|
|  1|1|1|0|

化简可得：$\text{result} = \overline{\text{A[31]}}\cdot \text{C[31]} + \text{B[31]}\cdot  \text{sum[31]} + \text{B[31]} \cdot\text{sum[31]} $

### slt部分
列出真值表
| A[31] | B[31] | sum[31] | result |
| ---   | ---   | ---     | ---    | 
|  0|0|0|1|
|  0|0|1|0|
|  0|1|0|1|
|  0|1|1|1|
|  1|0|0|0|
|  1|0|1|0|
|  1|1|0|1|
|  1|1|1|0|

化简可得：$\text{result} = \text{A[31]}\cdot \overline{\text{B[31]}} + \overline{\text{B[31]}}\cdot \text{sum[31]} + \text{A[31]} \cdot\text{sum[31]} $

## Decode模块编写
