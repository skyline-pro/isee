import requests
import json
import re
import datetime
import time
import sys
import ddddocr

from bs4 import BeautifulSoup
from PIL import Image
import os 
from io import BytesIO
import time

N = 50

CAPTCHA_URL = 'https://healthreport.zju.edu.cn/ncov/wap/default/code'

true_label = {}

def get_captcha(eai_sess):

    hm1 = "1652082034"
    hm2 = "1652075367"
    UUkey = "d1c534350e58f788077ac6dc4d7ac975"

    HEADERS = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36"
    }

    cookie_dict = {'eai-sess': eai_sess, 'Hm_lpvt_48b682d4885d22a90111e46b972e3268': hm1, 'Hm_lvt_48b682d4885d22a90111e46b972e3268': hm2, 'UUkey': UUkey}
    
    sess = requests.Session()
    ocr = ddddocr.DdddOcr(show_ad=False)
    
    sess.cookies = requests.cookies.cookiejar_from_dict(cookie_dict)



    for i in range(N):
        print(i)
        resp = sess.get(CAPTCHA_URL, headers=HEADERS)
        # print(resp.content.decode())
        image = Image.open(BytesIO(resp.content))
        image.save("./pic/code_" + str(i) + ".png")

        captcha = ocr.classification(resp.content)

        true_label[i] = captcha

    json_str = json.dumps(true_label, indent=4)
    with open('true_label.json', 'w') as json_file:
        json_file.write(json_str)

eai_sess = 'as6aghsrs1ft42jc38bve5h3j7'  

get_captcha(eai_sess)