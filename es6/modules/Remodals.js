import $ from 'jquery';
import 'remodal';

const initElement = (remodal) => {
  const $remodal = $(remodal);

  $remodal.remodal({
    hashTracking: false,
    modifier: remodal.getAttribute('data-remodal-modifier') || 'remodal_default',
  });
};

const initAll = () => {
  const nodes = document.querySelectorAll('.remodal');
  [...nodes].forEach(node => initElement(node));
};

const removeLockedClass = () => {
  document.documentElement.classList.remove('remodal-is-locked');
};

const syncScrollbarPadding = () => {
  const padding = $('body').css('padding-right');
  $('.remodal-fixed-section').css('padding-right', padding);
};

const start = () => {
  document.addEventListener('page:load', initAll);
  document.addEventListener('ajax:success', initAll);
  document.addEventListener('page:load', removeLockedClass);
  $(document).on('opening closed', '.remodal', syncScrollbarPadding);
};

export default { initAll, initElement, removeLockedClass, syncScrollbarPadding, start };
