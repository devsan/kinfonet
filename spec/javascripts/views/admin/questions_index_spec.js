describe("App.Views.Questions", function() {
  var view;
  beforeEach(function() {
    attributes = {"id":1,
                  "name":"Question Number 1",
                  "enabled": true
                };
    question = new App.Models.Question(attributes);
  view = new App.Views.Questions()

});