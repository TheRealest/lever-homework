net = require 'net'

parser = require './src/parser'
actions = require './src/actions'

#HOST = 'homework.lever.co'
HOST = 'localhost'
PORT = 1522

client = new net.Socket()
client.setEncoding 'utf8'
client.connect PORT, HOST, ->
  console.log '== CONNECTED ==\n'

model =
  snapshots: ['']
  ops: []

client.on 'data', (data) ->
  op = parser data
  model.ops[op.v] = op unless model.ops[op.v]?

client.on 'end', ->
  for op in model.ops
    model.snapshots[op.v+1] = actions[op.op] model.snapshots[op.v], op
    console.log model.snapshots[op.v+1]

  console.log '\n== FINISHED =='
  console.log model.snapshots[model.snapshots.length-1]
