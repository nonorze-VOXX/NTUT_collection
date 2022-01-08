from typing import Pattern


def s(tmp):
    if '[' in tmp:
        st = []
        times = []
        ans = ""
        for i in range(len(tmp)):
            if tmp[i] == ']':

                if len(st) == 1:
                    ans = ans + times[len(times)-1] * \
                        s(tmp[st[len(st)-1]+1:i])

                del st[len(st)-1]
                del times[len(times)-1]
            elif tmp[i] == '[':
                if len(st) == 0:

                    ans = ans[:len(ans)-1]

                st.append(i)
                times.append(int(tmp[i-1]))
            elif len(st) == 0:
                ans = ans + tmp[i]
        return ans
    else:
        return tmp


print(s(input()))
