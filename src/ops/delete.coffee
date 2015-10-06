module.exports = (model, op) ->
  console.log 'insert op'

  before = model.slice 0, op.index
  after = model.slice op.index + 1

  return before + after
