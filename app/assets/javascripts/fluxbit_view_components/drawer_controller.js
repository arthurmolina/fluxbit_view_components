import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "drawer" ];
  static values = {
    autoShow: false,
    placement: 'left',
    backdrop: true,
    bodyScrolling: false,
    edge: false,
    edgeOffset: String,
    backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30',
    onHide: Object,
    onShow: Object,
    onToggle: Object
  }

  connect() {
    this.drawers = {};

    // 2 ways of using this controller:
    if (this.drawerTargets.length === 0) {
      // 1. If there is no drawerTarget, it will toggle the element itself
      if (!this.element.id) this.element.id = 'drawer-' + Math.random().toString(36).substring(2, 15);

      this._initDrawer(this.element, this._optionsFromElements());
      this._addListeners(this.element);
      if(this.autoShowValue) this.drawers[this.element.id].show();
    } else {
      // 2. Using the drawerTarget to initialize a single drawer
      this.drawerTargets.forEach(target => {
        if (!target.id) target.id = 'drawer-' + Math.random().toString(36).substring(2, 15);

        this._initDrawer(target, this._optionsFromElements(target));
        this._addListeners(target);
        if (this.autoShowValue) this.drawers[target.id].show();
      });
    }
  }

  async _ensureDrawerLoaded() {
    if (typeof Drawer === "undefined") {
      const module = await import('flowbite');
      window.Drawer = module.Drawer;
    }
  }

  _initDrawer(target, options = {}) {
    //await this._ensureDrawerLoaded();
    this.drawers[target.id] = new Drawer(target, options);
  }

  _addListeners(target) {
      if (!this._drawerListeners) this._drawerListeners = new Set();

    ["show", "hide", "toggle"].forEach(action => {
      const eventName = `${action}Drawer:${target.id}`;
      if (!this._drawerListeners.has(eventName)) {
        document.addEventListener(eventName, () => {
          if (this.drawers[target.id]) this.drawers[target.id][action]();
        });
        this._drawerListeners.add(eventName);
      }
    });
  }
  disconnect() {
    Object.entries(this.drawers).forEach(([id, drawer]) => {
      if (drawer) {
        drawer.hide();
        drawer.destroy();
        delete this.drawers[id];
      }
    });
  }

  _optionsFromElements(target = null) {
    let options = {};
    if (this.hasPlacementValue) options["placement"] = this.placementValue;
    if (this.hasBackdropValue) options["backdrop"] = this.backdropValue;
    if (this.hasBodyScrollingValue) options["bodyScrolling"] = this.bodyScrollingValue;
    if (this.hasEdgeValue) options["edge"] = this.edgeValue;
    if (this.hasEdgeOffsetValue) options["edgeOffset"] = this.edgeOffsetValue;
    if (this.hasBackdropClassesValue) options["backdropClasses"] = this.backdropClassesValue;
    if (this.hasOnHideValue) options["onHide"] = this.onHideValue;
    if (this.hasOnShowValue) options["onShow"] = this.onShowValue;
    if (this.hasOnToggleValue) options["onToggle"] = this.onToggleValue;

    if (target) {
      if (target.dataset.autoShow !== undefined) options["autoShow"] = target.dataset.autoShow === "true";
      if (target.dataset.placement) options["placement"] = target.dataset.placement;
      if (target.dataset.backdrop !== undefined) options["backdrop"] = target.dataset.backdrop === "true";
      if (target.dataset.bodyScrolling !== undefined) options["bodyScrolling"] = target.dataset.bodyScrolling === "true";
      if (target.dataset.edge !== undefined) options["edge"] = target.dataset.edge === "true";
      if (target.dataset.edgeOffset) options["edgeOffset"] = target.dataset.edgeOffset;
      if (target.dataset.backdropClasses) options["backdropClasses"] = target.dataset.backdropClasses;
      if (target.dataset.onHide) options["onHide"] = target.dataset.onHide;
      if (target.dataset.onShow) options["onShow"] = target.dataset.onShow;
      if (target.dataset.onToggle) options["onToggle"] = target.dataset.onToggle;
    }
    return options;
  }

  _toCamelCase(str) {
    return str.replace(/-([a-z])/g, (_match, letter) => letter.toUpperCase());
  }

  toggle(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + '-id')];
    if (targetId) {
      if (this.drawers[targetId]) this.drawers[targetId].toggle();
      else console.warn(`Drawer with id ${targetId} not found.`);
    } else
      Object.entries(this.drawers).forEach(([_id, drawer]) => { if (drawer) drawer.toggle(); });
  }

  show(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + '-id')];
    if (targetId) {
      if (this.drawers[targetId]) this.drawers[targetId].show();
      else console.warn(`Drawer with id ${targetId} not found.`);
    } else
      Object.entries(this.drawers).forEach(([_id, drawer]) => { if (drawer) drawer.show(); });
  }

  hide(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + '-id')];
    if (targetId) {
      if (this.drawers[targetId]) this.drawers[targetId].hide();
      else console.warn(`Drawer with id ${targetId} not found.`);
    } else
      Object.entries(this.drawers).forEach(([_id, drawer]) => { if (drawer) drawer.hide(); });
  }
}

// document.dispatchEvent(new CustomEvent("toggleDrawer:demo-drawer"));
