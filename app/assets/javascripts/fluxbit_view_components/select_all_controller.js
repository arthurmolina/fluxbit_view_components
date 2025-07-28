import { Controller } from "@hotwired/stimulus";

// This controller manages the behavior of a select all checkbox and its associated checkboxes
// It allows users to select or deselect all items in a list and provides visual feedback based on the selection state.
// It also updates the visibility and enabled/disabled state of other elements based on the selection state
// The code is based on Stimulus Component Checkbox Select All 
// (https://github.com/stimulus-components/stimulus-components/tree/master/components/checkbox-select-all)
//
// Copyright (c) 2024 Guillaume Briday <guillaumebriday@gmail.com>
// Licensed under the MIT License
// Modified by Arthur Molina <arthurmolina@gmail.com>, 2025
export default class extends Controller {
  static targets = [
    "selectAll",
    "select",
    "disableOnEmptySelect",
    "enableOnEmptySelect",
    "hideOnEmptySelect",
    "showOnEmptySelect",
    "count"
  ];

  static values = {
    disableIndeterminate: {
      type: Boolean,
      default: false,
    },
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

    this.selectTargets.forEach((checkbox) => {
      checkbox.checked = e.target.checked;
      this.triggerInputEvent(checkbox);
    });
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
    this.hideOnEmptySelectTargets.forEach((el) => {
      el.classList.toggle("hidden", hasChecked);
    });
    this.showOnEmptySelectTargets.forEach((el) => {
      el.classList.toggle("hidden", !hasChecked);
    });
  }

  updateDisabledState() {
    const hasChecked = this.checkedCount() > 0;
    this.disableOnEmptySelectTargets.forEach((el) => {
      el.disabled = !hasChecked;
    });
    this.enableOnEmptySelectTargets.forEach((el) => {
      el.disabled = hasChecked;
    });
  }

  updateCount() {
    this.countTargets.forEach((el) => {
      el.textContent = this.checkedCount().toString();
    });
  }

  triggerInputEvent(checkbox) {
    const event = new Event("input", { bubbles: false, cancelable: true });
    checkbox.dispatchEvent(event);
  }

  checkedCount() {
    return this.checked.length;
  }

  get checked() {
    return this.selectTargets.filter((checkbox) => checkbox.checked);
  }

  get unchecked() {
    return this.selectTargets.filter((checkbox) => !checkbox.checked);
  }
}