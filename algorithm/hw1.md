# 1.
```
fn RealRoot(a,b,c):
	if(a ==0)
		return -c/b
	if(b*b-4*a*c  >=0)
		return (-b+sqrt(b*b-4*a*c))/(2*a), (-b-sqrt(b*b-4*a*c))/(2*a)
	else:
		return 'no real roots'
```

# 2.
## a.
best case is choose first two can pair
best case: 2
worse case is first choose every shoes left side, and choose next will pair
worse case: 12
## b.
in 1/9 case will remain 4 pair socks can wear,
in 8/9 case will remain 3 pair socks can wear
$E = \frac{1}{9}\cdot4 +\frac{8}{9} \cdot 3$ 
# 3.
$f(n)= n^2 +3n^3$

$3n^3 \leq n^2 +3n^3$ , $n\geq0$
=>$\Omega(n^3)$
$n^2 +3n^3 \leq 4n^3$ , $n\geq1$
=>$O(n^3)$

# 4.
1. $f_3  = 2 \geq (\frac{1+\sqrt{5}}{2})^{3-2}$ is true when n=3
2. let $$f_n = f_{n-1}+f_{n-2} \geq (\frac{1+\sqrt{5}}{2})^{n-2}$$ is true
3.  $(\frac{1+\sqrt{5}}{2}+1) = 2.61803398875 \geq (\frac{1+\sqrt{5}}{2})^{2} =2.61803398875$ is true
 $$
(\frac{1+\sqrt{5}}{2}+1)
\geq (\frac{1+\sqrt{5}}{2})^{n} / (\frac{1+\sqrt{5}}{2})^{n-2} 
=  (\frac{1+\sqrt{5}}{2})^{2}$$
 $$(\frac{1+\sqrt{5}}{2})^{n-1}+(\frac{1+\sqrt{5}}{2})^{n-2} 
 = (\frac{1+\sqrt{5}}{2})^{n-2} \cdot (\frac{1+\sqrt{5}}{2}+1)
 \geq (\frac{1+\sqrt{5}}{2})^{n}$$
 $$f_{n+2} = f_{n+1}+f_{n}  
 \geq (\frac{1+\sqrt{5}}{2})^{n-1}+(\frac{1+\sqrt{5}}{2})^{n-2} 
 \geq (\frac{1+\sqrt{5}}{2})^{n}$$
 $$f_{n+1} = f_{n}+f_{n-1} \geq (\frac{1+\sqrt{5}}{2})^{n-1}$$
so that,  $f_{n+1} = f_{n}+f_{n-1} \geq (\frac{1+\sqrt{5}}{2})^{n-1}$ is true, Q.E.D.
# 5.
$$
\begin{align}
lg(n!)& = \Theta(n lg (n))\\
lg(n!) &= lg(1\cdot2\cdot3\cdot...\cdot n)=  lg(1)+lg(2)+...+ lg(n) \\
nlg(n) &= lg(n^n)=lg(n)+lg(n)+...+lg(n)\\
\\
O(n lg(n))& :lg(1)+lg(2)+...+ lg(n) < lg(n^n)=lg(n)+lg(n)+...+lg(n)\\
\\
&lg(\frac{n}{2})=lg(\frac{n}{2})\\
&=> lg(\frac{n}{2}+1)>lg(\frac{n}{2})\\
\Omega(n lg(n)) & : lg(\frac{n}{2})+lg(\frac{n}{2}+1)+...+lg(n) >
lg(\frac{n}{2})+ lg(\frac{n}{2})+...+ lg(\frac{n}{2}) = \frac{n}{2}lg(\frac{n}{2})\\
&=\frac{n}{2}(lg(n)-lg(2)) \\
\end{align}
$$
# 6.
## (a) 
$$c=2, 2^{n+1} = 2\cdot2^n = O(2^n)$$ 
## (b) 
$$\text{c=$2^n$ can't be c. } 2^{2n} = 2^n\cdot2^n \neq O(2^n)$$
