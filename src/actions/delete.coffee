module.exports = (model, op) ->
  before = model.slice 0, op.index
  after = model.slice op.index + 1

  return before + after
