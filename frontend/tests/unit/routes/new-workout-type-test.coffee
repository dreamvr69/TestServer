`import { moduleFor, test } from 'ember-qunit'`

moduleFor 'route:new-workout-type', 'Unit | Route | new workout type', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
