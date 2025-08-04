import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ];
  static values = {
    autoShow: false,
    placement: 'bottom-right',
    backdrop: 'dynamic',
    backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30',
    closable: false,
    onHide: Object,
    onShow: Object,
    onToggle: Object
  }

  connect() {
    this.modals = {};

    // 2 ways of using this controller:
    if (this.modalTargets.length === 0) {
      // 1. If there is no modalTarget, it will toggle the element itself
      if (!this.element.id) this.element.id = 'modal-' + Math.random().toString(36).substring(2, 15);

      this._initModal(this.element, this._optionsFromElements());
      this._addListeners(this.element);
      if(this.autoShowValue) this.modals[this.element.id].show();
    } else {
      // 2. Using the modalTarget to initialize a single modal
      this.modalTargets.forEach(target => {
        if (!target.id) target.id = 'modal-' + Math.random().toString(36).substring(2, 15);
        this._initModal(target, this._optionsFromElements(target));
        this._addListeners(target);
        if (this.autoShowValue) this.modals[target.id].show();
      });
    }
  }

  async _ensureModalLoaded() {
    if (typeof Modal === "undefined") {
      const module = await import('flowbite');
      window.Modal = module.Modal;
    }
  }

  async _initModal(target, options = {}) {
    await this._ensureModalLoaded();
    this.modals[target.id] = new Modal(target, options);
  }

  _addListeners(target) {
      if (!this._modalListeners) this._modalListeners = new Set();

    ["show", "hide", "toggle"].forEach(action => {
      const eventName = `${action}Modal:${target.id}`;
      if (!this._modalListeners.has(eventName)) {
        document.addEventListener(eventName, () => {
          this.modals[target.id][action]();
        });
        this._modalListeners.add(eventName);
      }
    });
  }

  _optionsFromElements(target = null) {
    let options = {};
    if (this.hasPlacementValue) options["placement"] = this.placementValue;
    if (this.hasBackdropValue) options["backdrop"] = this.backdropValue;
    if (this.hasBackdropClassesValue) options["backdropClasses"] = this.backdropClassesValue;
    if (this.hasClosableValue) options["closable"] = this.closableValue;
    if (this.hasOnHideValue) options["onHide"] = this.onHideValue;
    if (this.hasOnShowValue) options["onShow"] = this.onShowValue;
    if (this.hasOnToggleValue) options["onToggle"] = this.onToggleValue;

    if (target) {
      if (target.dataset.placement) options["placement"] = target.dataset.placement;
      if (target.dataset.backdrop !== undefined) options["backdrop"] = target.dataset.backdrop === "true";
      if (target.dataset.backdropClasses) options["backdropClasses"] = target.dataset.backdropClasses;
      if (target.dataset.closable) options["closable"] = target.dataset.edgeOffset;
      if (target.dataset.onHide) options["onHide"] = target.dataset.onHide;
      if (target.dataset.onShow) options["onShow"] = target.dataset.onShow;
      if (target.dataset.onToggle) options["onToggle"] = target.dataset.onToggle;
    }
    return options;
  }

  _toCamelCase(str) {
    return str.replace(/-([a-z])/g, (match, letter) => letter.toUpperCase());
  }

  toggle(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + '-id')];
    if (targetId) {
      if (this.modals[targetId]) this.modals[targetId].toggle();
      else console.warn(`Modal with id ${targetId} not found.`);
    } else
      Object.entries(this.modals).forEach(([_id, modal]) => { if (modal) modal.toggle(); });
  }

  show(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + '-id')];
    if (targetId) {
      if (this.modals[targetId]) this.modals[targetId].show();
      else console.warn(`Modal with id ${targetId} not found.`);
    } else
      Object.entries(this.modals).forEach(([_id, modal]) => { if (modal) modal.show(); });
  }

  hide(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + '-id')];
    if (targetId) {
      if (this.modals[targetId]) this.modals[targetId].hide();
      else console.warn(`Modal with id ${targetId} not found.`);
    } else
      Object.entries(this.modals).forEach(([_id, modal]) => { if (modal) modal.hide(); });
  }
}

// document.dispatchEvent(new CustomEvent("toggleModal:demo-modal"));