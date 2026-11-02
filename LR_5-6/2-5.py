numbers = list(map(int, input("Введите числа через пробел: ").split()))
chastoechislo = None
max_schet = 0

for chislo in numbers:
    schet = 0
    for drugoe_chislo in numbers:
        if drugoe_chislo == chislo:
            schet += 1

    if schet > max_schet:
        max_schet = schet
        chastoechislo = chislo

print(f"Самое частое число: {chastoechislo}")
print(f"Оно встречается {max_schet} раз")