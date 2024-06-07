#!/bin/python3

import requests
import sys

a = {
    "action": "findCards",
    "version": 6,
    "params": {
        "query": "deck:UwU_Deutschland"
    }
}

b = requests.post('http://localhost:8765', json=a).json()['result']

headers = {
  'authority': 'upload.wikimedia.org',
  'cache-control': 'max-age=0',
  'upgrade-insecure-requests': '1',
  'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.15.5 Chrome/87.0.4280.144 Safari/537.36',
  'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
  'dnt': '1',
  'accept-language': 'en-US,en;q=0.9',
  'sec-fetch-site': 'cross-site',
  'sec-fetch-mode': 'navigate',
  'sec-fetch-user': '?1',
  'sec-fetch-dest': 'document',
  'referer': 'https://en.wiktionary.org/',
}

# ERR = open('ERR', 'w')
'Basic (and reversed card)-75aea'
'Basic (and reversed card)-7c609'

fr = []
la = []
lb = len(b)
for o in range(len(b)):
    i = b[o]
    EC = 0
    EW = ''
    cinfo = {
        "action": "cardsInfo",
        "version": 6,
        "params": {
            "cards": [i]
        }
    }

    res = requests.post('http://localhost:8765', json=cinfo).json()['result'][0]

    if res['modelName'][-1] == 'a':
        fr.append(res['fields']['Wort_DE']['value'])
    else:
        la.append({'i': res['note'], 'w': res['fields']['base_d']['value']})
    print(f'{o}/{lb}', end = '\r', file = sys.stderr)
    # print(fr)
    # print(la)


































    continue
    cw = res[0]['fields']['Word']['value']
    words = cw.split(', ')

    for h in range(len(words)):
        words[h] = words[h].replace('’', '\'')
        words[h] = words[h].replace(' (CAP)', '')

    print(words[h])

    for w in words:
        url = f'https://en.wiktionary.org/wiki/File:Nl-{w}.ogg'
        r1 = requests.get(url, headers = headers)
        if r1.status_code != 200:
            EC = 1
            EW = w
            break
        m1 = r1.text.split('<div class="fullMedia"><p><a href="')[1].split('" class="internal"')[0]
        url2 = f"https:{m1}"
        r = requests.get(url2, headers = headers)
        if r.status_code != 200:
            EC = 2
            EW = w
            break
        with open(f'Nl-{w}.ogg', 'wb') as f:
            f.write(r.content)

    if EC != 0:
        ERR.write(f'{EC}: Could not get audio for Nl-{EW}.ogg [{o}]\n') 
        continue

    x = []
    for h in range(len(words)):
        x.append({
            "filename": f"Nl-{words[h]}.ogg",
            "path": f"/home/raiku/x/Nl-{words[h]}.ogg",
            "fields": [
                f"Audio{h + 1}"
            ]
        })

    upd = {
        "action": "updateNoteFields",
        "version": 6,
        "params": {
            "note": {
                "id": res[0]['note'],
                "fields": {
                    "Audio1": "",
                    "Audio2": ""
                },
                "audio": x
            }
        }
    }
    r = requests.post('http://localhost:8765', json=upd).content
    print(f'{o + 1}/{len(b)}', end='\r')

with open('ffr', 'w') as ffr:
    try:
        print(fr, file = ffr)
    except:
        print(fr)
with open('fla', 'w') as fla:
    try:
        print(la, file = fla)
    except:
        print(la)


# ERR.close()

