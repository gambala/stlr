import FlipToggle from './FlipToggle';

export default class Flip {
  constructor(node) {
    this.node = node;
    this.toggleAgents = this.buildToggleAgents();
  }

  buildToggleAgents() {
    const toggleNodes = Array.from(this.node.querySelectorAll('.flip__toggle'));
    const subFlipNodes = Array.from(this.node.querySelectorAll('.flip__target'));
    const subToggleNodes = subFlipNodes
      .map(node => node.querySelectorAll('.flip__toggle'))
      .reduce((a, nodes) => [...a, ...nodes], []);
    const thisToggles = toggleNodes.filter(x => subToggleNodes.indexOf(x) === -1);
    if (!thisToggles.length) return [];
    return thisToggles.map(node => new FlipToggle(node, this));
  }

  closeFlipOpenedToggles() {
    this.toggleAgents.forEach(toggleAgent => toggleAgent.closeOpenedToggle());
  }

  makeActive() {
    this.node.classList.add('flip_active');
  }

  makeInactive() {
    this.node.classList.remove('flip_active');
    this.toggleAgents.forEach(toggleAgent => toggleAgent.makeInactive());
  }
}
