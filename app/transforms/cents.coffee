`import DS from 'ember-data'`

CentsTransform = DS.Transform.extend
  deserialize: (serialized) ->
    serialized / 100

  serialize: (deserialized) ->
    parseInt deserialized * 100

`export default CentsTransform`
