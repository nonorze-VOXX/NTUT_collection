s= input()
bool =1
sum =0
for i in range(len(s)):
    if ord(s[i])-ord('a')>=0 and ord(s[i])-ord('a')<26:
        print(s[i],end="")
        bool=0
    elif ord(s[i])-ord('A')>=0 and ord(s[i])-ord('A')<26:
        sum+=1
if bool:
    print("No lowercase letters",end="  ")
print()
print(len(s))
print(sum)
