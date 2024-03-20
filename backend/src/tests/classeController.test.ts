import { test, assert } from 'vitest';
const classeController = require('../controllers/classeController');

test('Test getAllClasses function', async () => {
  const req = {
    query: {
      classname: 'Math',
      letter: 'A',
      modality: 'Online',
      minId: 1,
      maxId: 10
    }
  };
  const res = {
    json: data => data,
    status: code => ({ json: message => ({ code, message }) })
  };

  const result = await classeController.getAllClasses(req, res);
  assert.equal(result.length, 10);
});

test('Test getClassById function', async () => {
  const req = { params: { id: 1 } };
  const res = {
    json: data => data,
    status: code => ({ json: message => ({ code, message }) })
  };

  const result = await classeController.getClassById(req, res);
  assert.equal(result.id, 1);
});
