ManageIQ.angular.app.component('hello', {
  controller: ['$timeout', function($timeout) {

    ManageIQ.angular.rxSubject.subscribe((event) => {

      var eventType = event.type;

      if (eventType === 'demo' && event.operation === 'angular1') {
        $timeout(() => this.message = 'je tu');
      }
    });
  }],
  template: `
    <i>{{$ctrl.message}}</i>
  `
});
