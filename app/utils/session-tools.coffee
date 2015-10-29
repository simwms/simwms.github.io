`import Ember from 'ember'`
{A} = Ember

simplifyError = ({detail, source}) -> 
  if typeof detail is "string"
    msg = detail
    [..., key] = source.pointer.split("/")
  else
    key = detail.key
    msg = detail.msg
  {key, msg}

unify = (obj, error) ->
  if obj.get(error.key)?
    obj.get(error.key).pushObject error.msg
  else
    obj.set error.key, A [error.msg]
  obj

hashifyErrors = (obj, errors) ->
  A errors
  .map simplifyError
  .reduce unify, obj

`export {simplifyError, unify, hashifyErrors}`