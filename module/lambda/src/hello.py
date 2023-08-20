import requests

# google.comへのHTTP GETリクエストを行う
response = requests.get('https://www.google.com')

# レスポンスのステータスコードを表示
print(f"ステータスコード: {response.status_code}")

# レスポンスの最初の50文字を表示
print(response.text[:50])
