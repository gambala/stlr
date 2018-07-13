const delegate = (eventName) => {
  document.addEventListener(eventName, dispatch);
}

const dispatch = (oldEvent) => {
  const newEvent = document.createEvent('HTMLEvents');
  newEvent.initEvent('page:load', true, true);
  newEvent.eventName = 'page:load';
  document.dispatchEvent(newEvent);
};

export default { delegate, dispatch };
