describe('App.Models.Question', function() {
    it('should be defined', function() {
        expect(App.Models.Question).toBeDefined();
    });

    it('can be instantiated', function() {
        var question = new App.Models.Question();
        expect(question).not.toBeNull();
    });
});