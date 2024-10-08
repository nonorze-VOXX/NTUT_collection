a=int(input())
b=int(input())

c=float(a-b)
if c<0:
    c*=-1

print("Difference:%.2f" %c)
print("Sum:%.2f" %float(a+b))
print("Quotient:%.2f" %float(a/b))
print("Product:%.2f" %float(a*b))