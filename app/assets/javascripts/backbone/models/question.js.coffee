class App.Models.Question extends Backbone.Model


class App.Collections.Questions extends Backbone.Collection
  model: App.Models.Question
  url: "admin/questions"