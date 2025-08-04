import FxAssigner from './assigner_controller'
import FxAutoSubmit from './auto_submit_controller'
import FxDrawer from './drawer_controller'
import FxMethodLink from './method_link_controller'
import FxModal from './modal_controller'
import FxRowClick from './row_click_controller'
import FxSelectAll from './select_all_controller'

export {
  FxAssigner,
  FxAutoSubmit,
  FxDrawer,
  FxMethodLink,
  FxModal,
  FxRowClick,
  FxSelectAll
}

export function registerFluxbitControllers(application) {
  application.register('fx-assigner', FxAssigner)
  application.register('fx-auto-submit', FxAutoSubmit)
  application.register('fx-drawer', FxDrawer)
  application.register('fx-method-link', FxMethodLink)
  application.register('fx-modal', FxModal)
  application.register('fx-row-click', FxRowClick)
  application.register('fx-select-all', FxSelectAll)
}
