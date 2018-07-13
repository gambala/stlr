export default class FlipToggle {
  constructor(node, flipAgent) {
    this.node = node;
    this.flipAgent = flipAgent;
    this.targetNode = document.getElementById(this.node.getAttribute('data-target'));
    this.targetFlipNode = this.targetNode.parentNode.closest('.flip');
  }

  closeOpenedToggle() {
    if (this.isToggleOpened()) { this.closeToggle(); }
  }

  closeToggle() {
    this.makeInactive();
    this.flipAgent.makeInactive();
  }

  isToggleCloser() {
    return this.node.matches('.flip__toggle_closer');
  }

  isToggleOpener() {
    return this.node.matches('.flip__toggle_opener');
  }

  isToggleOpened() {
    return this.node.matches('.flip__toggle_active');
  }

  makeInactive() {
    this.node.classList.remove('flip__toggle_active');
    this.targetNode.classList.remove('flip__target_active');
    this.targetFlipNode.classList.remove('flip_active');
  }

  openToggle() {
    this.flipAgent.closeFlipOpenedToggles();
    this.node.classList.add('flip__toggle_active');
    this.targetNode.classList.add('flip__target_active');
    this.flipAgent.makeActive();
  }

  toggleToggle() {
    if (this.isToggleOpener()) return this.openToggle();
    if (this.isToggleCloser()) return this.closeToggle();
    if (this.isToggleOpened()) return this.closeToggle();
    return this.openToggle();
  }
}
