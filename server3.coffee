net = require 'net'

parser = require './src/parser'
actions = require './src/actions'

#HOST = 'homework.lever.co'
HOST = 'localhost'
PORT = 1523

client = new net.Socket()
client.setEncoding 'utf8'
client.connect PORT, HOST, ->
  console.log '== CONNECTED ==\n'

model =
  snapshots: ['']
  ops: []
badSources = []

client.on 'data', (data) ->
  op = parser data
  badSources.push op.src unless actions[op.op].validate op
  model.ops[op.v] = op unless model.ops[op.v]?

client.on 'end', ->
  for op in model.ops
    if op.src in badSources
      model.snapshots[op.v+1] = model.snapshots[op.v]
    else
      model.snapshots[op.v+1] = actions[op.op].run model.snapshots[op.v], op
    console.log model.snapshots[op.v+1]

  console.log '\n== FINISHED =='
  console.log model.snapshots[model.snapshots.length-1]
