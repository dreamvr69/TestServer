`import DS from 'ember-data'`

Project = DS.Model.extend {
  name: DS.attr(),
  begin: DS.attr(),
  end: DS.attr()
}

`export default Project`
