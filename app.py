# 1. write an http api with endpoints defined as below (please choose your any language and frame work of your choice to implement)
#     1. **/counter**: ouput format :: {"counter":"123"}
#         1. GET will increment the counter by 1 and return the same value.
#         2. POST will increment the counter by 2 and return the same value.
#         3. DELETE will decrement the counter by 1 and return the same value.

from flask import Flask, json

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

if __name__ == '__main__':
    api.run() 