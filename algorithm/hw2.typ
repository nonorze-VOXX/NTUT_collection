= hw2

110590002 王熯竑

== 1. 
  === a
  ```python
  function sort(list):
    for i in 0 to length(list):
      if list[i] =='black':
        continue
      for j in range(0,i):
        if list[i-j-1]=='white':
          break
        else:
          swap(list[i-j],list[i-j-1])
  ```

  the number of moves it makes is n(n+1)/2

  === b 
  if want to make the dark, light, dark, light, and so on,
  to all the light disks to the left-hand end

  the n-th light disk must moved to the n-th position 

  if n-th light disk moved to a position which is less than n mean that :
    + a (< n)-th light disk is at the right-side of n-th light disk,
      that is, a swap happen between them, the swap is non-effective

  if n-th light disk moved to position which is greater than n mean two state:
    + that the black disk is between 0 to n, that is illegal state
    + a (> n)-st light disk is between 0 to n, that is mean n move to n-1 position state happen.

  because above, the n-th light disk must moved to n-th position

  the light disk origin position is 2n

  so the number of moves is $sum(i=0)^(i=n) (2i-i) = (1+n)/2*n$

  it is lower bound


== 2.

  $ T(n) &= 2T(n/2)+n/lg(n) \

   &= 2(2T(n/4)+(n/2)/lg(n/2))+n/lg(n) \

   &= 4T(n/4)+n/(lg(n)-lg(2))+n/lg(n) \

   &= 2^{lg(n)}T(n/2^lg(n))+ n sum_(i=0)^(lg(n)) 1/(lg(n)-i) \

  &=n T(1) + n/2 (1/lg(n)+ 1/1) lg(n) \

  &=n + n 1/2+n lg(n)/2 $

  $T(n) = O(n lg(n))$

  *mathematical induction*

  let  $T(n) <= n lg(n)$  is true

  then    $T(n/2) <= n/2 lg(n/2)$ is true

  $
  T(n) &= 2T(n/2) + n/lg(n) <= n lg(n/2)+n/lg( n )
  $

  $
  &= n lg(n)-n+ (n/lg(n)) <= n lg(n)
  $
  Q.E.D

== 3.
  - $T(n) = 2T(n/2) + c$
    - $a=2, b=2, f(n)=c$
    - $n^(lg_b a) = n$
    - $h(m) = (c)/(m) = c m^(-1)$
    - $-1<0$
    - $T(n)= O(n)$
  - $T(n) = 4T(n/2) + c n$
    - $a=4, b=2, f(n)=c$
    - $n^(lg_b a) = n^2$
    - $h(m) = (c m)/(m^2) = c m^(-1)$
    - $-1<0$
    - $T(n)= O(n^2)$
  - $T(n) = 4T(n/2) + c n^3$
    - $a=4, b=2, f(n)=c n^3$
    - $n^(lg_b a) = n^2$
    - $h(m) = (c m^3)/m^2 = c m$
    - $1>0$
    - $T(n) = n^2 O(c n) = O(n^3)$
  - $T(n) = 4T(n/3) + c n$
    - $a=4, b=3, f(n)=c n$
    - $n^(lg_b a) = n^(lg_3 4)$
    - $h(m) = (c m)/(m^(lg_3 4))=c m^(1-lg_3 4)$
    - $1-lg_3 4 < 0$
    - $T(n) = O(n^(lg_3 4))$

  === result 
    $O(n)<O(n^(lg_3 4))<O(n^2) < O(n^3)\
    => 2T(n/2)+c < 4T(n/3)+c n < 4T(n/2)+c n < 4T(n/2)+c n^3$
    
== 4.
  - $x_l$ is left half of x.
  - $x_r$ is right half of x.
  - $y_l$ is left half of y.
  - $y_r$ is right half of y.
  - $x*y &= x_l*2^(n/2)*y_l*2^(n/2)+ x_l*2^(n/2)*y_r 
          + x_r*y_l*2^(n/2) + x_r*y_r\
        &= x_l*y_l*(2^n) + (x_l*y_r + x_r*y_l)*2^(n/2) + x_r*y_r$
  - $(x_l+x_r)*(y_l+y_r) = x_l*y_l + x_l*y_r + x_r*y_l + x_r*y_r$
  - $x_l*y_r + x_r*y_l =(x_l+x_r)*(y_l+y_r) - x_l*y_l - x_r*y_r$
  - $x*y &= x_l*y_l*(2^n) + (x_l*y_r + x_r*y_l)*2^(n/2) + x_r*y_r \
          &=x_l*y_l*(2^n) + ((x_l+x_r)*(y_l+y_r) - x_l*y_l - x_r*y_r)*2^(n/2) + x_r*y_r $
  - $T(n)= F_1(x_l,y_l)+F_2(x_r,y_r)+F_3(x_l+x_r,y_l+y_r)$

  === pseudo-code
  Mul(x,y):
  if x==0 and y==0:
    return 0
  n = max(len(x),len(y))\
  if n == 1:
    return x*y
  $x_l <- $ left half of x.\
  $x_r <- $ right half of x.\
  $y_l <- $ left half of y.\
  $y_r <- $ right half of y.\
  $r_1$ = Mul($x_l,y_l)$\
  $r_2$ = Mul($x_r,y_r)$\
  $r_3$ = Mul($x_l+x_r,y_l+y_r)$\
  return $r_1*2^n + (r_3-r_1-r_2)*2^(n/2) + r_2$

  === T(n)

  $T(n)&= 3T(n/2)+c\
    &a=4,b=3,f(n)=c\
    n^(lg_b a) &= n^{lg_3 4}\
    h(m) &= (c)/(m^{lg_3 4}) = c m^{-lg_3 4}\
    -lg_3 4 &< 0\
    T(n) &= O(n^(lg_3 4))$






