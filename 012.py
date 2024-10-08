a = int(input())
b = int(input())
c = int(input())
d = int(input())
e = int(input())

fee = [ [0.08 ,  0.07 ,  0.06],
    [0.1393 ,0.1304 ,0.1087],
    [0.1349, 0.1217, 0.1018],
    [1.1287 ,1.1127, 0.9572],
    [1.4803 ,1.2458 ,1.1243]]
feeA = a*fee[0][0]+b*fee[1][0]+c*fee[2][0]+d*fee[3][0]+e*fee[4][0]
feeB = a*fee[0][1]+b*fee[1][1]+c*fee[2][1]+d*fee[3][1]+e*fee[4][1]
feeC = a*fee[0][2]+b*fee[1][2]+c*fee[2][2]+d*fee[3][2]+e*fee[4][2]

if feeA<183:
    feeA=183
if feeB<383:
    feeB=383
if  feeC<983:
    feeC=983


if feeA<feeB :
    if feeA<feeC:
        print('Type 183')
    else:
        print('Type 983')
else:
    if feeB<feeC:
        print('Type 383')
    else:
        print('Type 983')
