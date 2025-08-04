import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
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

          if(attribute === "innerHTML")
            value = fromElement.innerHTML;
          else if (attribute === "value")
            value = fromElement.value;
          else if (attribute === "textContent")
            value = fromElement.textContent;
          else
            value = fromElement.getAttribute(attribute);
        } else
          value = event.params["change"][el][attr];

        if (attr === "innerHTML")
          targetElement.innerHTML = value;
        else if (attr === "value")
          targetElement.value = value;
        else if (attr === "textContent")
          targetElement.textContent = value;
        else
          targetElement.setAttribute(attr, value);
      });
    });
  }
}
