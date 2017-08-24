`import DS from 'ember-data'`

Event = DS.Model.extend {
  name: DS.attr(),
  begin: DS.attr(),
  end: DS.attr()
}

`export default Event`
