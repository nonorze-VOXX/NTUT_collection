cin = input()
a_array = [[0 for _ in range(9)] for i in range(52)]

for i in range(52):
    for j in range(9):
        if j ==0:
            a_array[i][j]=1
        elif i==0:
            a_array[i][j]=1
        else:
            a_array[i][j]=a_array[i-1][j]+a_array[i][j-1]
ans = 0
flag = False
for i in range(len(cin)-1):
    for j in range(9):
        ans+=a_array[i][j]
#print(ans)
for i in range(len(cin)):
    if i == 0 and cin[i]=='0':
        ans=0
        break
    elif cin=='1':
        ans+=1
    elif i==0 or int(cin[i])-int(cin[i-1])>0:
        #print (i)
        if i == 0:
            for j in range(int(cin[i])-1):
                #print ("ANS",ans,len(cin)-i-1,8-j)
                ans+=a_array[len(cin)-i-1][8-j]
        else:
            for j in range(int(cin[i-1]),int(cin[i])):
                #print("ANS",ans,a_array[len(cin)-i-1][9-j])
                ans+=a_array[len(cin)-i-1][9-j]
                #print("ANS2",len(cin)-i-1,9-j+1,i)
    elif int(cin[i])-int(cin[i-1])<0:
        flag=True
        break
#print(ans)
if not flag:
    ans+=1
print(ans)
