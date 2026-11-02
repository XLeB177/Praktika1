import random
def MinNum1(a):
    m = abs(a[0]) # локальная переменная
    for i in range(1, 10):
        if abs(a[i]) < m:
            m = abs(a[i])
    print(m)

def MinNum2(a):
    m = 100 # локальная переменная
    for i in range(10):
        if a[i] < m and a[i] < 0:
            m = a[i]
    print(m)

mass = [] # глобальная переменная
for i in range(10):
    mass.append(random.randint(-100, 100))
print(*mass)
MinNum1(mass)
MinNum2(mass)