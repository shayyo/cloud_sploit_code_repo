import time
from flask import request
from flask import jsonify
import redis
from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)


def get_my_ip():
    #return jsonify({'ip': request.remote_addr}), 200
    #return request.remote_addr
    cache.set(request.remote_addr, request.remote_addr)


def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/', methods=["GET"])
def hello():
    count = get_hit_count()
    ip = get_my_ip()
    return 'Hello World I have been seen {} times.\n'.format(count)
