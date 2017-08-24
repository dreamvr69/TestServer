`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'workouts', 'Unit | Serializer | workouts',
  # Specify the other units that are required for this test.
  needs: ['serializer:workouts']

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
