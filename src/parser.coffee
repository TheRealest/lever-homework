module.exports = (data) ->
  str = data.split('\0')[0]
  return JSON.parse str
