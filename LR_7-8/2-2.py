text = input("Введите текст: ")
x = False
w = False
for i in text:
    if i == "x":
        x = True
        break
    elif i == "w":
        w = True
        break

if x:
    print("первым встречается x")
elif w:
    print("первым встречается w")