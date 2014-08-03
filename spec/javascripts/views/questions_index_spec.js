describe('App.Views.Questions', function() {
  
  beforeEach(function() {
    this.server = sinon.fakeServer.create();
  });

  afterEach(function() {
    this.server.restore();
  });
   
  it('renders a questions ul', function() {
    //questionsView = new App.Views.Questions({collection: [{name: 'hello'}]});
    var questionsView = new App.Views.Questions({
            collection: new App.Collections.Questions()
          });
    questionsView.render();
    expect(questionsView.$el).toContainElement('ul.questions')
  });

});
