import FxAssigner from './assigner_controller'
import FxAutoSubmit from './auto_submit_controller'
import FxDrawer from './drawer_controller'
import FxMethodLink from './method_link_controller'
import FxModal from './modal_controller'
import FxProgress from './progress_controller'
import FxRowClick from './row_click_controller'
import FxSelectAll from './select_all_controller'
import FxSpinnerPercent from './spinner_percent_controller'
import FxThemeButton from './theme_button_controller'

export {
  FxAssigner,
  FxAutoSubmit,
  FxDrawer,
  FxMethodLink,
  FxModal,
  FxProgress,
  FxRowClick,
  FxSelectAll,
  FxSpinnerPercent,
  FxThemeButton
}

export function registerFluxbitControllers(application) {
  application.register('fx-assigner', FxAssigner)
  application.register('fx-auto-submit', FxAutoSubmit)
  application.register('fx-drawer', FxDrawer)
  application.register('fx-method-link', FxMethodLink)
  application.register('fx-modal', FxModal)
  application.register('fx-progress', FxProgress)
  application.register('fx-row-click', FxRowClick)
  application.register('fx-select-all', FxSelectAll)
  application.register('fx-spinner-percent', FxSpinnerPercent)
  application.register('fx-theme-button', FxThemeButton)

  // Make controllers globally accessible for vanilla JS
  if (typeof window !== 'undefined') {
    window.FluxbitControllers = {
      FxProgress,
      FxModal,
      FxDrawer,
      FxAssigner,
      FxAutoSubmit,
      FxMethodLink,
      FxRowClick,
      FxSelectAll,
      FxSpinnerPercent,
      FxThemeButton
    }
  }
}
