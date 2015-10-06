module.exports.validate = (op) ->
  return op? and op.op == 'delete' and op.index? and op.v? and op.src?

module.exports.run = (model, op) ->
  before = model.slice 0, op.index
  after = model.slice op.index + 1

  return before + after
