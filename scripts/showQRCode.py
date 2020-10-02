#! /usr/bin/env python
import base64
import re
import sys

try:
    import qrcode
    import requests
except ImportError:
    sys.exit('请安装依赖: pip install qrcode requests')

ip = '127.0.0.1'
port = 8888
login_url = f'http://{ip}:{port}/v1/Login/GetQRcode'


def main():
    print(f'获取二维码 {login_url}')
    try:
        resp = requests.get(login_url, timeout=10)
        b64 = re.findall(r'base64,(.*?)"', resp.text)[0]
    except Exception:
        sys.exit('获取二维码失败')

    content = base64.b64decode(b64)

    print('解码二维码')
    files = {'file': ('qrcode.png', content, 'image/png')}
    try:
        resp = requests.post('https://zxing.org/w/decode', files=files, timeout=10)
        qrcode_data = re.findall(
            r'<td>Raw text</td><td><pre>(.*?)</pre></td>', resp.text
        )[0]
    except Exception:
        sys.exit('二维码解码失败')

    qr = qrcode.QRCode()
    qr.add_data(qrcode_data)
    qr.make()
    qr.print_ascii()


if __name__ == "__main__":
    main()
