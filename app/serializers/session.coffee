`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

SessionSerializer = ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    user:
      deserialize: "records"
      serialize: false


`export default SessionSerializer`
