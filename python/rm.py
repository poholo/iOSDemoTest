import os
n = 0
for root, dirs, files in os.walk('./'):
    for name in files:
        if name.endswith(".torrent") or name.endswith(".js") :
            n += 1
            print('删除:'+ str(name))
            os.remove(os.path.join(root, name))

print('共计' + str(n))