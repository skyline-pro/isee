<center><font size=5>Homework3</font></center>

## Problem1

1. $C_3 \larr 1$
2. $F\larr 1$
3. $C_2 \larr 1$
4. $C_1 \larr 1$
5. $O\larr 7$
6. $R \larr 4$
7. $T\larr 8$
8. $W\larr 6$
9. $U\larr 3$

## Problem2

1. remove SA-WA, delete G from SA
2. remove SA-V , delete R from SA,leaving B
3. remove NT-WA , delete G from NT
4. remove NT-SA , delete B from NT , leaving R
5. remove NSW-V , delete R from NSW
6. remove NSW-SA , delete B from NSW , leaving G
7. remove Q-NT , delete R from Q
8. remove Q-SA , delete B from Q
9. remove Q-NSW , delete G from Q, leaving no domain for Q

## Problem3

**a. c. e. f. g.** are correct

## Problem4

## a.

The 8 rows of the truth table shows that the sentence is true for all models hence valid

### b.

The LHS:
$$
(Food \implies Party)\or (Drinks \implies Party)\\
(\neg Food \or Party)\or (\neg Drinks \or Party) \\
\neg Food \or \neg Drinks \or Party
$$
The RHS:
$$
(Food \and Drinks) \implies Party \\
\neg (Food \and Drinks) \or Party \\
\neg Food \or \neg Drinks \or Party
$$
The two sides are identical , so the sentence is valid

### c.

To prove that a sentence is valid, we can prove that its negation is unsatisfiable.
$$
\neg[[Food \implies Party)\or (Drinks \implies Party)]\implies [(\\
Food \and Drinks) \implies Party]]\\
[Food \implies Party)\or (Drinks \implies Party)]\and \neg [Food \and Drinks) \implies Party] \\
(\neg Food \or \neg Drinks \or Party) \and Food \and Drinks \and \neg Party
$$
We can see that this sentence is unsatisfiable , so the sentence in this problem is valid