import random
mass = [[random.randint(0, 10) for _ in range(8)] for _ in range(8)]

print("Двумерный массив 8x8:")
for row in mass:
    print(row)
result = []

for row in mass:
    has_pair = -1

    for i in range(len(row) - 1):
        if row[i] + row[i + 1] == 7:
            has_pair = 1
            break

    result.append(has_pair)

print("\nРезультат:")
print(result)