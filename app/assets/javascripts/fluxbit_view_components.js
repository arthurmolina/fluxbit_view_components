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

class FxProgress extends Controller {
  static targets=[ "bar", "textLabel", "progressLabel" ];
  static values={
    progress: {
      type: Number,
      default: 0
    },
    animate: {
      type: Boolean,
      default: true
    },
    speed: {
      type: String,
      default: "normal"
    }
  };
  connect() {
    this.updateProgress();
    this.updateBarTransition();
  }
  progressValueChanged() {
    this.updateProgress();
  }
  animateValueChanged() {
    this.updateBarTransition();
  }
  speedValueChanged() {
    this.updateBarTransition();
  }
  updateProgress() {
    const clampedProgress = Math.max(0, Math.min(100, this.progressValue));
    if (this.hasBarTarget) {
      this.barTarget.style.width = `${clampedProgress}%`;
      this.barTarget.setAttribute("aria-valuenow", clampedProgress);
    }
    if (this.hasProgressLabelTarget) {
      this.progressLabelTarget.textContent = `${clampedProgress}%`;
    }
    this.element.setAttribute("aria-valuenow", clampedProgress);
  }
  updateBarTransition() {
    if (!this.hasBarTarget) return;
    if (this.animateValue) {
      let duration;
      switch (this.speedValue) {
       case "slow":
        duration = "2s";
        break;

       case "fast":
        duration = "0.3s";
        break;

       case "very_fast":
        duration = "0.1s";
        break;

       case "normal":
       default:
        duration = "0.6s";
        break;
      }
      this.barTarget.style.transition = `width ${duration} ease-out`;
    } else {
      this.barTarget.style.transition = "none";
    }
  }
  setProgress(progress) {
    this.progressValue = progress;
  }
  incrementProgress(amount = 1) {
    this.progressValue = Math.min(100, this.progressValue + amount);
  }
  decrementProgress(amount = 1) {
    this.progressValue = Math.max(0, this.progressValue - amount);
  }
  reset() {
    this.progressValue = 0;
  }
  complete() {
    this.progressValue = 100;
  }
  setSpeed(speed) {
    this.speedValue = speed;
  }
  setAnimate(animate) {
    this.animateValue = animate;
  }
  animateToProgress(targetProgress, duration = 1e3) {
    const startProgress = this.progressValue;
    const difference = targetProgress - startProgress;
    const startTime = performance.now();
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
    }
    const animate = currentTime => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const easeOut = 1 - Math.pow(1 - progress, 3);
      const currentProgress = startProgress + difference * easeOut;
      this.updateProgressDirect(Math.round(currentProgress));
      if (progress < 1) {
        this.animationId = requestAnimationFrame(animate);
      } else {
        this.progressValue = targetProgress;
        this.animationId = null;
      }
    };
    this.animationId = requestAnimationFrame(animate);
  }
  updateProgressDirect(progress) {
    const clampedProgress = Math.max(0, Math.min(100, progress));
    if (this.hasBarTarget) {
      this.barTarget.style.width = `${clampedProgress}%`;
      this.barTarget.setAttribute("aria-valuenow", clampedProgress);
    }
    if (this.hasProgressLabelTarget) {
      this.progressLabelTarget.textContent = `${clampedProgress}%`;
    }
    this.element.setAttribute("aria-valuenow", clampedProgress);
  }
  increment(event) {
    const amount = parseInt(event.params?.amount) || 1;
    const progressId = event.params?.id;
    if (progressId) {
      this.updateProgressById(progressId, controller => controller.incrementProgress(amount));
    } else {
      this.incrementProgress(amount);
    }
  }
  decrement(event) {
    const amount = parseInt(event.params?.amount) || 1;
    const progressId = event.params?.id;
    if (progressId) {
      this.updateProgressById(progressId, controller => controller.decrementProgress(amount));
    } else {
      this.decrementProgress(amount);
    }
  }
  resetProgress(event) {
    const progressId = event.params?.id;
    if (progressId) {
      this.updateProgressById(progressId, controller => controller.reset());
    } else {
      this.reset();
    }
  }
  completeProgress(event) {
    const progressId = event.params?.id;
    if (progressId) {
      this.updateProgressById(progressId, controller => controller.complete());
    } else {
      this.complete();
    }
  }
  animateTo(event) {
    const target = parseInt(event.params?.target) || 100;
    const duration = parseInt(event.params?.duration) || 1e3;
    const progressId = event.params?.id;
    if (progressId) {
      this.updateProgressById(progressId, controller => controller.animateToProgress(target, duration));
    } else {
      this.animateToProgress(target, duration);
    }
  }
  updateSpeed(event) {
    const speed = event.params?.speed || "normal";
    const progressId = event.params?.id;
    if (progressId) {
      this.updateProgressById(progressId, controller => controller.setSpeed(speed));
    } else {
      this.setSpeed(speed);
    }
  }
  updateProgressById(progressId, callback) {
    const progressContainer = this.element.querySelector(`[data-progress-id="${progressId}"]`);
    if (!progressContainer) return;
    const progressBar = progressContainer.querySelector('div[style*="width"]');
    const textLabel = progressContainer.parentElement.querySelector("span:first-child");
    const progressLabel = progressContainer.parentElement.querySelector("span:last-child");
    if (!progressBar) return;
    const tempController = {
      barElement: progressBar,
      textLabelElement: textLabel,
      progressLabelElement: progressLabel,
      containerElement: progressContainer,
      setProgress: progress => {
        const clampedProgress = Math.max(0, Math.min(100, progress));
        this.updateSpecificProgress(progressBar, progressLabel, clampedProgress);
      },
      incrementProgress: (amount = 1) => {
        const currentProgress = this.getCurrentProgress(progressBar);
        const newProgress = Math.min(100, currentProgress + amount);
        this.updateSpecificProgress(progressBar, progressLabel, newProgress);
      },
      decrementProgress: (amount = 1) => {
        const currentProgress = this.getCurrentProgress(progressBar);
        const newProgress = Math.max(0, currentProgress - amount);
        this.updateSpecificProgress(progressBar, progressLabel, newProgress);
      },
      reset: () => {
        this.updateSpecificProgress(progressBar, progressLabel, 0);
      },
      complete: () => {
        this.updateSpecificProgress(progressBar, progressLabel, 100);
      },
      animateToProgress: (targetProgress, duration = 1e3) => {
        const currentProgress = this.getCurrentProgress(progressBar);
        this.animateSpecificProgress(progressBar, progressLabel, currentProgress, targetProgress, duration);
      },
      setSpeed: speed => {
        let duration;
        switch (speed) {
         case "slow":
          duration = "2s";
          break;

         case "fast":
          duration = "0.3s";
          break;

         case "very_fast":
          duration = "0.1s";
          break;

         default:
          duration = "0.6s";
          break;
        }
        progressBar.style.transition = `width ${duration} ease-out`;
      }
    };
    if (callback) {
      callback(tempController);
    }
  }
  getCurrentProgress(progressBar) {
    const widthStyle = progressBar.style.width;
    return parseInt(widthStyle.replace("%", "")) || 0;
  }
  updateSpecificProgress(progressBar, progressLabel, progress) {
    const clampedProgress = Math.max(0, Math.min(100, progress));
    progressBar.style.width = `${clampedProgress}%`;
    progressBar.setAttribute("aria-valuenow", clampedProgress);
    if (progressLabel) {
      progressLabel.textContent = `${clampedProgress}%`;
    }
  }
  animateSpecificProgress(progressBar, progressLabel, startProgress, targetProgress, duration) {
    const difference = targetProgress - startProgress;
    const startTime = performance.now();
    const animate = currentTime => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const easeOut = 1 - Math.pow(1 - progress, 3);
      const currentProgress = startProgress + difference * easeOut;
      this.updateSpecificProgress(progressBar, progressLabel, Math.round(currentProgress));
      if (progress < 1) {
        requestAnimationFrame(animate);
      } else {
        this.updateSpecificProgress(progressBar, progressLabel, targetProgress);
      }
    };
    requestAnimationFrame(animate);
  }
  disconnect() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
      this.animationId = null;
    }
  }
  static getController(element) {
    if (typeof element === "string") {
      element = document.querySelector(element);
    }
    if (!element) return null;
    const controllerElement = element.closest('[data-controller*="fx-progress"]');
    if (!controllerElement) return null;
    return window.Stimulus?.getControllerForElementAndIdentifier(controllerElement, "fx-progress") || application?.getControllerForElementAndIdentifier(controllerElement, "fx-progress");
  }
  static updateProgress(selector, progress) {
    const controller = this.getController(selector);
    if (controller) controller.setProgress(progress);
  }
  static incrementProgress(selector, amount = 10) {
    const controller = this.getController(selector);
    if (controller) controller.incrementProgress(amount);
  }
  static animateProgress(selector, target, duration = 1e3) {
    const controller = this.getController(selector);
    if (controller) controller.animateToProgress(target, duration);
  }
  static resetProgress(selector) {
    const controller = this.getController(selector);
    if (controller) controller.reset();
  }
  static completeProgress(selector) {
    const controller = this.getController(selector);
    if (controller) controller.complete();
  }
  static updateProgressById(selector, progressId, callback) {
    const controller = this.getController(selector);
    if (controller) controller.updateProgressById(progressId, callback);
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

class FxSpinnerPercent extends Controller {
  static targets=[ "progress", "text" ];
  static values={
    percent: {
      type: Number,
      default: 0
    },
    animate: {
      type: Boolean,
      default: false
    },
    speed: {
      type: String,
      default: "normal"
    },
    hasCustomText: {
      type: Boolean,
      default: false
    }
  };
  connect() {
    this.circumference = 2 * Math.PI * 45;
    this.updateProgress();
    this.updateAnimation();
  }
  percentValueChanged() {
    this.updateProgress();
  }
  animateValueChanged() {
    this.updateAnimation();
  }
  speedValueChanged() {
    this.updateAnimation();
  }
  updateProgress() {
    const clampedPercent = Math.max(0, Math.min(100, this.percentValue));
    const offset = this.circumference - clampedPercent / 100 * this.circumference;
    if (this.hasProgressTarget) {
      this.progressTarget.style.strokeDashoffset = offset;
      this.progressTarget.setAttribute("aria-valuenow", clampedPercent);
    }
    if (this.hasTextTarget && !this.hasCustomTextValue) {
      this.textTarget.textContent = `${clampedPercent}%`;
    }
    this.element.setAttribute("aria-valuenow", clampedPercent);
  }
  updateAnimation() {
    const svg = this.element.querySelector("svg");
    if (!svg) return;
    if (this.animateValue) {
      let duration;
      switch (this.speedValue) {
       case "slow":
        duration = "3s";
        break;

       case "fast":
        duration = "0.5s";
        break;

       case "very_fast":
        duration = "0.3s";
        break;

       case "normal":
       default:
        duration = "1s";
        break;
      }
      svg.style.animation = `spin ${duration} linear infinite`;
    } else {
      svg.style.animation = "";
    }
  }
  setPercent(percent) {
    this.percentValue = percent;
  }
  setAnimate(animate) {
    this.animateValue = animate;
  }
  startAnimation() {
    this.animateValue = true;
  }
  stopAnimation() {
    this.animateValue = false;
  }
  setSpeed(speed) {
    this.speedValue = speed;
  }
  animateToPercent(targetPercent, duration = 1e3) {
    const startPercent = this.percentValue;
    const difference = targetPercent - startPercent;
    const startTime = performance.now();
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
    }
    const animate = currentTime => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const easeOut = 1 - Math.pow(1 - progress, 3);
      const currentPercent = startPercent + difference * easeOut;
      this.updateProgressDirect(Math.round(currentPercent));
      if (progress < 1) {
        this.animationId = requestAnimationFrame(animate);
      } else {
        this.percentValue = targetPercent;
        this.animationId = null;
      }
    };
    this.animationId = requestAnimationFrame(animate);
  }
  updateProgressDirect(percent) {
    const clampedPercent = Math.max(0, Math.min(100, percent));
    const offset = this.circumference - clampedPercent / 100 * this.circumference;
    if (this.hasProgressTarget) {
      this.progressTarget.style.strokeDashoffset = offset;
      this.progressTarget.setAttribute("aria-valuenow", clampedPercent);
    }
    if (this.hasTextTarget && !this.hasCustomTextValue) {
      this.textTarget.textContent = `${clampedPercent}%`;
    }
    this.element.setAttribute("aria-valuenow", clampedPercent);
  }
  disconnect() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
      this.animationId = null;
    }
  }
}

function registerFluxbitControllers(application) {
  application.register("fx-assigner", FxAssigner);
  application.register("fx-auto-submit", FxAutoSubmit);
  application.register("fx-drawer", FxDrawer);
  application.register("fx-method-link", FxMethodLink);
  application.register("fx-modal", FxModal);
  application.register("fx-progress", FxProgress);
  application.register("fx-row-click", FxRowClick);
  application.register("fx-select-all", FxSelectAll);
  application.register("fx-spinner-percent", FxSpinnerPercent);
  if (typeof window !== "undefined") {
    window.FluxbitControllers = {
      FxProgress: FxProgress,
      FxModal: FxModal,
      FxDrawer: FxDrawer,
      FxAssigner: FxAssigner,
      FxAutoSubmit: FxAutoSubmit,
      FxMethodLink: FxMethodLink,
      FxRowClick: FxRowClick,
      FxSelectAll: FxSelectAll,
      FxSpinnerPercent: FxSpinnerPercent
    };
  }
}

export { FxAssigner, FxAutoSubmit, FxDrawer, FxMethodLink, FxModal, FxProgress, FxRowClick, FxSelectAll, FxSpinnerPercent, registerFluxbitControllers };
