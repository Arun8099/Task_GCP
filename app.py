pp.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
        return "Hello, World! Welcome to the Sample App!"

    if __name__ == '__main__':
            app.run(host='0.0.0.0', port=8080, debug=True)
