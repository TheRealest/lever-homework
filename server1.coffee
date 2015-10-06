net = require 'net'

parser = require './src/parser'
ops = require './src/ops'

#HOST = 'homework.lever.co'
HOST = 'localhost'
PORT = 1521

client = new net.Socket()
client.setEncoding 'utf8'
client.connect PORT, HOST, ->
  console.log '== CONNECTED ==\n'

model = ''
client.on 'data', (data) ->
  op = parser data
  console.log op
  model = ops[op.op] model, op
  console.log model

client.on 'end', ->
  console.log '\n== FINISHED =='
  console.log model
