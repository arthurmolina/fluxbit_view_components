import { Controller } from "@hotwired/stimulus";

class FxAssigner extends Controller {
  assign(event) {
    if (event.params["preventDefault"] === "true") {
      event.preventDefault();
      event.stopPropagation();
    }
    Object.keys(event.params["change"]).forEach(el => {
      const targetElement = document.querySelector(el);
      if (!targetElement) {
        console.error(`fx-assigner: Target element "${el}" not found.`);
        return;
      }
      Object.keys(event.params["change"][el]).forEach(attr => {
        let value = "";
        if (typeof event.params["change"][el][attr] == "object") {
          const element = event.params["change"][el][attr]["element"];
          const attribute = event.params["change"][el][attr]["attribute"];
          const fromElement = document.querySelector(element);
          if (!fromElement) {
            console.error(`fx-assigner: Element "${element}" not found.`);
            return;
          }
          if (attribute === "innerHTML") value = fromElement.innerHTML; else if (attribute === "value") value = fromElement.value; else if (attribute === "textContent") value = fromElement.textContent; else value = fromElement.getAttribute(attribute);
        } else value = event.params["change"][el][attr];
        if (attr === "innerHTML") targetElement.innerHTML = value; else if (attr === "value") targetElement.value = value; else if (attr === "textContent") targetElement.textContent = value; else targetElement.setAttribute(attr, value);
      });
    });
  }
}

class FxAutoSubmit extends Controller {
  static values={
    delay: {
      type: Number,
      default: 150
    }
  };
  connect() {
    this.timeout = null;
  }
  submit(event) {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
    this.timeout = setTimeout(() => {
      if (event.params["formId"]) {
        const form = document.getElementById(event.params["formId"]);
        if (!form) {
          console.error(`fx-auto-submit: Form with ID "${event.params["formId"]}" not found.`);
          return;
        }
        form.requestSubmit();
        return;
      }
      this.element.requestSubmit();
    }, this.delayValue);
  }
  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
  }
}

class FxDrawer extends Controller {
  static targets=[ "drawer" ];
  static values={
    autoShow: false,
    placement: "left",
    backdrop: true,
    bodyScrolling: false,
    edge: false,
    edgeOffset: String,
    backdropClasses: "bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30",
    onHide: Object,
    onShow: Object,
    onToggle: Object
  };
  connect() {
    this.drawers = {};
    if (this.drawerTargets.length === 0) {
      if (!this.element.id) this.element.id = "drawer-" + Math.random().toString(36).substring(2, 15);
      this._initDrawer(this.element, this._optionsFromElements());
      this._addListeners(this.element);
      if (this.autoShowValue) this.drawers[this.element.id].show();
    } else {
      this.drawerTargets.forEach(target => {
        if (!target.id) target.id = "drawer-" + Math.random().toString(36).substring(2, 15);
        this._initDrawer(target, this._optionsFromElements(target));
        this._addListeners(target);
        if (this.autoShowValue) this.drawers[target.id].show();
      });
    }
  }
  async _ensureDrawerLoaded() {
    if (typeof Drawer === "undefined") {
      const module = await import("flowbite");
      window.Drawer = module.Drawer;
    }
  }
  _initDrawer(target, options = {}) {
    this.drawers[target.id] = new Drawer(target, options);
  }
  _addListeners(target) {
    if (!this._drawerListeners) this._drawerListeners = new Set;
    [ "show", "hide", "toggle" ].forEach(action => {
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
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + "-id")];
    if (targetId) {
      if (this.drawers[targetId]) this.drawers[targetId].toggle(); else console.warn(`Drawer with id ${targetId} not found.`);
    } else Object.entries(this.drawers).forEach(([_id, drawer]) => {
      if (drawer) drawer.toggle();
    });
  }
  show(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + "-id")];
    if (targetId) {
      if (this.drawers[targetId]) this.drawers[targetId].show(); else console.warn(`Drawer with id ${targetId} not found.`);
    } else Object.entries(this.drawers).forEach(([_id, drawer]) => {
      if (drawer) drawer.show();
    });
  }
  hide(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + "-id")];
    if (targetId) {
      if (this.drawers[targetId]) this.drawers[targetId].hide(); else console.warn(`Drawer with id ${targetId} not found.`);
    } else Object.entries(this.drawers).forEach(([_id, drawer]) => {
      if (drawer) drawer.hide();
    });
  }
}

class FxMethodLink extends Controller {
  static values={
    method: "get",
    url: String,
    params: Object,
    formDataId: String,
    debug: false,
    eventType: "click"
  };
  connect() {
    this.element.addEventListener(this.eventTypeValue, this.click.bind(this));
  }
  disconnect() {
    this.element.removeEventListener(this.eventTypeValue, this.click.bind(this));
  }
  click(event) {
    event.preventDefault();
    event.stopPropagation();
    const formData = this.createFormData();
    if (this.hasParamsValue) this.addParams(formData);
    const url = this.hasUrlValue ? this.urlValue : this.element.href;
    this.submitRequest(url, formData);
  }
  createFormData() {
    const formData = new FormData;
    if (this.hasFormDataIdValue) {
      const existingForm = document.getElementById(this.formDataIdValue);
      const formElements = existingForm.querySelectorAll("input, select, textarea");
      formElements.forEach(element => {
        if (element.name && (element.type !== "checkbox" || element.checked)) formData.append(element.name, element.value);
      });
    }
    formData.append("_method", (this.methodValue || formData.method).toUpperCase());
    formData.append("authenticity_token", this.getCSRFToken());
    return formData;
  }
  addParams(formData) {
    this.appendNestedParams(formData, this.paramsValue, "");
  }
  appendNestedParams(formData, obj, prefix) {
    Object.entries(obj).forEach(([key, value]) => {
      const fullKey = prefix ? `${prefix}[${key}]` : key;
      if (typeof value === "object" && value !== null) {
        if (this.isElementReference(value)) {
          const resolvedValue = this.resolveElementValue(value);
          formData.append(fullKey, resolvedValue);
        } else {
          this.appendNestedParams(formData, value, fullKey);
        }
      } else {
        formData.append(fullKey, value);
      }
    });
  }
  isElementReference(obj) {
    return obj.hasOwnProperty("element") && obj.hasOwnProperty("attribute");
  }
  resolveElementValue(elementRef) {
    const {element: element, attribute: attribute} = elementRef;
    const domElement = document.querySelector(element);
    if (!domElement) {
      console.error(`fx-method-link: Element "${element}" not found.`);
      return "";
    }
    switch (attribute) {
     case "innerHTML":
      return domElement.innerHTML;

     case "value":
      return domElement.value;

     case "textContent":
      return domElement.textContent;

     default:
      return domElement.getAttribute(attribute) || "";
    }
  }
  submitRequest(url, formData) {
    if (this.debugValue) {
      console.log("Submitting form data:");
      for (let [key, value] of formData.entries()) {
        console.log(`${key}: ${value}`);
      }
    }
    fetch(url, {
      method: "POST",
      body: formData,
      headers: {
        Accept: "text/vnd.turbo-stream.html, text/html",
        "X-Requested-With": "XMLHttpRequest"
      }
    }).then(response => {
      if (response.ok) {
        if (response.headers.get("Content-Type")?.includes("turbo-stream")) {
          return response.text().then(html => {
            Turbo.renderStreamMessage(html);
          });
        } else {
          window.location.reload();
        }
      } else {
        console.error("Request failed:", response.statusText);
      }
    }).catch(error => {
      console.error("Network error:", error);
    });
  }
  getCSRFToken() {
    const token = document.querySelector('meta[name="csrf-token"]');
    return token ? token.getAttribute("content") : "";
  }
}

class FxModal extends Controller {
  static targets=[ "modal" ];
  static values={
    autoShow: false,
    placement: "bottom-right",
    backdrop: "dynamic",
    backdropClasses: "bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30",
    closable: false,
    onHide: Object,
    onShow: Object,
    onToggle: Object
  };
  connect() {
    this.modals = {};
    if (this.modalTargets.length === 0) {
      if (!this.element.id) this.element.id = "modal-" + Math.random().toString(36).substring(2, 15);
      this._initModal(this.element, this._optionsFromElements());
      this._addListeners(this.element);
      if (this.autoShowValue) this.modals[this.element.id].show();
    } else {
      this.modalTargets.forEach(target => {
        if (!target.id) target.id = "modal-" + Math.random().toString(36).substring(2, 15);
        this._initModal(target, this._optionsFromElements(target));
        this._addListeners(target);
        if (this.autoShowValue) this.modals[target.id].show();
      });
    }
  }
  async _ensureModalLoaded() {
    if (typeof Modal === "undefined") {
      const module = await import("flowbite");
      window.Modal = module.Modal;
    }
  }
  async _initModal(target, options = {}) {
    await this._ensureModalLoaded();
    this.modals[target.id] = new Modal(target, options);
  }
  _addListeners(target) {
    if (!this._modalListeners) this._modalListeners = new Set;
    [ "show", "hide", "toggle" ].forEach(action => {
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
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + "-id")];
    if (targetId) {
      if (this.modals[targetId]) this.modals[targetId].toggle(); else console.warn(`Modal with id ${targetId} not found.`);
    } else Object.entries(this.modals).forEach(([_id, modal]) => {
      if (modal) modal.toggle();
    });
  }
  show(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + "-id")];
    if (targetId) {
      if (this.modals[targetId]) this.modals[targetId].show(); else console.warn(`Modal with id ${targetId} not found.`);
    } else Object.entries(this.modals).forEach(([_id, modal]) => {
      if (modal) modal.show();
    });
  }
  hide(event) {
    const targetId = event.target.dataset[this._toCamelCase(this.identifier + "-id")];
    if (targetId) {
      if (this.modals[targetId]) this.modals[targetId].hide(); else console.warn(`Modal with id ${targetId} not found.`);
    } else Object.entries(this.modals).forEach(([_id, modal]) => {
      if (modal) modal.hide();
    });
  }
}

class FxRowClick extends Controller {
  static values={
    url: String,
    frame: String
  };
  connect() {
    if (this.element.tagName !== "TR") {
      console.warn("row-click controller should only be used on <tr> tags");
      return;
    }
    this.element.addEventListener("click", this.navigate.bind(this));
  }
  disconnect() {
    this.element.removeEventListener("click", this.navigate.bind(this));
  }
  navigate(event) {
    if (event.target === event.currentTarget || !event.target.closest("button, a, input, select, textarea")) {
      if (this.frameValue) {
        window.Turbo.visit(this.urlValue, {
          frame: this.frameValue
        });
      } else {
        window.Turbo.visit(this.urlValue);
      }
    }
  }
}

class FxSelectAll extends Controller {
  static targets=[ "selectAll", "select", "disableOnEmptySelect", "enableOnEmptySelect", "hideOnEmptySelect", "showOnEmptySelect", "count" ];
  static values={
    disableIndeterminate: {
      type: Boolean,
      default: false
    }
  };
  initialize() {
    this.toggle = this.toggle.bind(this);
    this.refresh = this.refresh.bind(this);
  }
  selectAllTargetConnected(checkbox) {
    checkbox.addEventListener("change", this.toggle);
    this.refresh();
  }
  selectTargetConnected(checkbox) {
    checkbox.addEventListener("change", this.refresh);
    this.refresh();
  }
  selectAllTargetDisconnected(checkbox) {
    checkbox.removeEventListener("change", this.toggle);
    this.refresh();
  }
  selectTargetDisconnected(checkbox) {
    checkbox.removeEventListener("change", this.refresh);
    this.refresh();
  }
  toggle(e) {
    e.preventDefault();
    this.selectTargets.forEach(checkbox => {
      checkbox.checked = e.target.checked;
      this.triggerInputEvent(checkbox);
    });
    this.refresh();
  }
  refresh() {
    const checkboxesCount = this.selectTargets.length;
    const checkboxesCheckedCount = this.checked.length;
    if (this.disableIndeterminateValue) {
      this.selectAllTarget.checked = checkboxesCheckedCount === checkboxesCount;
    } else {
      this.selectAllTarget.checked = checkboxesCheckedCount > 0;
      this.selectAllTarget.indeterminate = checkboxesCheckedCount > 0 && checkboxesCheckedCount < checkboxesCount;
    }
    this.updateVisibility();
    this.updateDisabledState();
    this.updateCount();
  }
  updateVisibility() {
    const hasChecked = this.checkedCount() > 0;
    this.hideOnEmptySelectTargets.forEach(el => {
      el.classList.toggle("hidden", hasChecked);
    });
    this.showOnEmptySelectTargets.forEach(el => {
      el.classList.toggle("hidden", !hasChecked);
    });
  }
  updateDisabledState() {
    const hasChecked = this.checkedCount() > 0;
    this.disableOnEmptySelectTargets.forEach(el => {
      el.disabled = !hasChecked;
    });
    this.enableOnEmptySelectTargets.forEach(el => {
      el.disabled = hasChecked;
    });
  }
  updateCount() {
    this.countTargets.forEach(el => {
      el.textContent = this.checkedCount().toString();
    });
  }
  triggerInputEvent(checkbox) {
    const event = new Event("input", {
      bubbles: false,
      cancelable: true
    });
    checkbox.dispatchEvent(event);
  }
  checkedCount() {
    return this.checked.length;
  }
  get checked() {
    return this.selectTargets.filter(checkbox => checkbox.checked);
  }
  get unchecked() {
    return this.selectTargets.filter(checkbox => !checkbox.checked);
  }
}

function registerFluxbitControllers(application) {
  application.register("fx-assigner", FxAssigner);
  application.register("fx-auto-submit", FxAutoSubmit);
  application.register("fx-drawer", FxDrawer);
  application.register("fx-method-link", FxMethodLink);
  application.register("fx-modal", FxModal);
  application.register("fx-row-click", FxRowClick);
  application.register("fx-select-all", FxSelectAll);
}

export { FxAssigner, FxAutoSubmit, FxDrawer, FxMethodLink, FxModal, FxRowClick, FxSelectAll, registerFluxbitControllers };
