# 1. write an http api with endpoints defined as below (please choose your any language and frame work of your choice to implement)
#     1. **/counter**: ouput format :: {"counter":"123"}
#         1. GET will increment the counter by 1 and return the same value.
#         2. POST will increment the counter by 2 and return the same value.
#         3. DELETE will decrement the counter by 1 and return the same value.

from flask import Flask, json, request, jsonify, render_template

import os, socket

counter = 0

api = Flask(__name__)


@api.route('/', methods=['GET'])
def get_counter():
  global counter
  counter += 1

  return str(counter)

@api.route('/', methods=['POST'])
def post_counter():
  global counter
  counter += 2

  return str(counter)

@api.route('/', methods=['DELETE'])
def delete_counter():
  global counter
  counter -= 1

  return str(counter)

@api.route('/info', methods=['GET'])
def get_info():
  return {os.getenv("ENVIRONMENT")}

info = [
  {'git': 'stg',
  'branch': 'stg',
  'env': 'stg',
  'hostname': 'hostname'}
]

@api.route('/info/', methods=['GET'])
def api_all():
    return jsonify(info)

@api.route("/info_test")
def index():
    try:
        host_name = socket.gethostname()
        host_ip = socket.gethostbyname(host_name)
        return render_template('info.json', hostname=host_name, ip=host_ip, env=os.environ)
    except:
        return render_template('error.html')

if __name__ == '__main__':
    api.run() 

