@jasmineEnv = jasmine.getEnv()
@jasmineEnv.updateInterval = 1000
@htmlReporter = new jasmine.HtmlReporter()

@jasmineEnv.addReporter @htmlReporter
@jasmineEnv.specFilter = (spec) -> htmlReporter.specFilter(spec)

# SPECS
$ ->
  describe "Jasmine works!", ->
    it "Jasmine.js", ->
      expect(true).toBe true