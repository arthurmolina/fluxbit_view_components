import FxSelectAll from './select_all_controller'
import FxDrawer from './drawer_controller'
import FxModal from './modal_controller'
import FxRowClick from './row_click_controller'
import FxMethodLink from './method_link_controller'

export { FxSelectAll, FxDrawer, FxModal, FxRowClick, FxMethodLink }

export function registerFluxbitControllers(application) {
  application.register('fx-select-all', FxSelectAll)
  application.register('fx-drawer', FxDrawer)
  application.register('fx-modal', FxModal)
  application.register('fx-row-click', FxRowClick)
  application.register('fx-method-link', FxMethodLink)
}
