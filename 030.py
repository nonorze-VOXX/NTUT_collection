def main():
    vec =input()
    vec1=input()
    vec = vec.split()
    vec1 = vec1.split()
    dic = {}
    for i in range(len(vec)):
        dic[int(vec1[i])]=vec[i]
    keys_vec=sorted(dic.keys())
    print(sorted(dic.keys()))
    for i in keys_vec:
        print(dic[i],end='')
    print()
    
main()