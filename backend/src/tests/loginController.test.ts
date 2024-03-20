import { test, assert } from 'vitest';
const authController = require('../controllers/loginController');

test('Test getLoginPage function when authenticated', () => {
  const req = { isAuthenticated: () => true };
  const res = {
    redirect: path => assert.equal(path, "/"),
    render: (view, data) => {
      assert.equal(view, "login.ejs");
      assert.isDefined(data.errors);
    }
  };

  authController.getLoginPage(req, res);
});

test('Test getLoginPage function when not authenticated', () => {
  const req = { isAuthenticated: () => false, flash: key => [] };
  const res = {
    render: (view, data) => {
      assert.equal(view, "login.ejs");
      assert.isDefined(data.errors);
    }
  };

  authController.getLoginPage(req, res);
});

test('Test checkLoggedIn function when authenticated', () => {
  const req = { isAuthenticated: () => true };
  const res = { redirect: path => assert.equal(path, "/") };
  const next = () => {};

  authController.checkLoggedIn(req, res, next);
});

test('Test checkLoggedIn function when not authenticated', () => {
  const req = { isAuthenticated: () => false };
  const res = { redirect: path => assert.equal(path, "/login") };
  const next = () => {};

  authController.checkLoggedIn(req, res, next);
});

test('Test checkLoggedOut function when authenticated', () => {
  const req = { isAuthenticated: () => true };
  const res = { redirect: path => assert.equal(path, "/") };
  const next = () => {};

  authController.checkLoggedOut(req, res, next);
});

test('Test checkLoggedOut function when not authenticated', () => {
  const req = { isAuthenticated: () => false };
  const res = {};
  const next = () => {};

  authController.checkLoggedOut(req, res, next);
});

test('Test postLogOut function', () => {
  const req = { session: { destroy: callback => callback() } };
  const res = { redirect: path => assert.equal(path, "/login") };

  authController.postLogOut(req, res);
});