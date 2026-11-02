n = 20
mass = []
for i in range(n):
    a = int(input(f'Введите {i+1} элемент масссива: '))
    mass.append(a)

for i in range(n):
    if mass[i] > 0:
        mass[i] = 0
    else:
        mass[i] *= mass[i]

print(*mass)