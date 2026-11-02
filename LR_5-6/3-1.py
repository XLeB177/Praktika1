n = 20
mass = []
for i in range(n):
    a = int(input(f'Введите {i+1} элемент масссива: '))
    mass.append(a)

for i in range(n):
    if i > 0:
        del1 = i
        break


if del1 == min(mass):
    mass.pop(del1)
else:
    mass.pop(del1)
    mass.pop(min(mass))
print(*mass)

