import Flip from './Flip';
import FlipToggle from './FlipToggle';

const closeFlipByOutsideClick = (flipNode, targetNode) => {
  if (flipNode === targetNode) return;
  if (flipNode.contains(targetNode)) return;
  new Flip(flipNode).closeFlipOpenedToggles();
};

const getToggleAgent = (toggleNode) => {
  const flipNode = toggleNode.closest('.flip');
  return new FlipToggle(toggleNode, new Flip(flipNode));
};

const openToggle = toggleNode => getToggleAgent(toggleNode).openToggle();
const toggleToggle = toggleNode => getToggleAgent(toggleNode).toggleToggle();

const delegateClickToToggle = (event) => {
  const node = event.target.closest('.flip__toggle');
  if (!node) return;
  if (!node.matches('.flip__toggle_link')) { event.preventDefault(); }
  toggleToggle(node);
};

const delegateMouseOverToToggle = (event) => {
  if (!event.target) return;
  const node = event.target.closest('.flip__toggle_hover');
  if (!node) return;
  if (node.matches('.flip__toggle_active')) return;
  openToggle(node);
};

const handleOutsideClick = (event) => {
  const nodes = document.querySelectorAll('.flip.flip_closable.flip_active');
  [...nodes].forEach(node => closeFlipByOutsideClick(node, event.target));
};

const start = () => {
  document.addEventListener('mouseover', delegateMouseOverToToggle);
  document.addEventListener('click', delegateClickToToggle);
  document.addEventListener('click', handleOutsideClick);
  document.addEventListener('touch', handleOutsideClick);
};

export default { closeFlipByOutsideClick, toggleToggle, start };
