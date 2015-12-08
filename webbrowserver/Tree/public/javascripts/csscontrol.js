var ta = document.querySelector('textarea');

autosize(ta);

// Dispatch a 'autosize:update' event to trigger a resize:
var evt = document.createEvent('Event');
evt.initEvent('autosize:update', true, false);
ta.dispatchEvent(evt);
