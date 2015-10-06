module.exports.validate = (op) ->
  return op? and op.op == 'insert' and op.index? and op.data? and op.v? and op.src?

module.exports.run = (model, op) ->
  before = model.slice 0, op.index
  after = model.slice op.index

  return before + op.data + after
