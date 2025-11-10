# frozen_string_literal: true

module Fluxbit::Config::Form::TelephoneComponent
  mattr_accessor :default_country, default: "BR"
  mattr_accessor :default_sizing, default: 1

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :telephone_countries do
    [
      { code: "BR", name: "Brasil", dial_code: "+55", flag: "🇧🇷", mask: "(##) #####-####" },
      { code: "AR", name: "Argentina", dial_code: "+54", flag: "🇦🇷", mask: "## ####-####" },
      { code: "MX", name: "México", dial_code: "+52", flag: "🇲🇽", mask: "## #### ####" },
      { code: "CO", name: "Colombia", dial_code: "+57", flag: "🇨🇴", mask: "### ### ####" },
      { code: "CL", name: "Chile", dial_code: "+56", flag: "🇨🇱", mask: "# #### ####" },
      { code: "PE", name: "Perú", dial_code: "+51", flag: "🇵🇪", mask: "### ### ###" },
      { code: "VE", name: "Venezuela", dial_code: "+58", flag: "🇻🇪", mask: "###-###-####" },
      { code: "EC", name: "Ecuador", dial_code: "+593", flag: "🇪🇨", mask: "## ### ####" },
      { code: "BO", name: "Bolivia", dial_code: "+591", flag: "🇧🇴", mask: "# ### ####" },
      { code: "PY", name: "Paraguay", dial_code: "+595", flag: "🇵🇾", mask: "### ### ###" },
      { code: "UY", name: "Uruguay", dial_code: "+598", flag: "🇺🇾", mask: "# ### ## ##" },
      { code: "CR", name: "Costa Rica", dial_code: "+506", flag: "🇨🇷", mask: "#### ####" },
      { code: "PA", name: "Panamá", dial_code: "+507", flag: "🇵🇦", mask: "####-####" },
      { code: "CU", name: "Cuba", dial_code: "+53", flag: "🇨🇺", mask: "# ### ####" },
      { code: "DO", name: "República Dominicana", dial_code: "+1", flag: "🇩🇴", mask: "(###) ###-####" },
      { code: "GT", name: "Guatemala", dial_code: "+502", flag: "🇬🇹", mask: "#### ####" },
      { code: "HN", name: "Honduras", dial_code: "+504", flag: "🇭🇳", mask: "####-####" },
      { code: "SV", name: "El Salvador", dial_code: "+503", flag: "🇸🇻", mask: "####-####" },
      { code: "NI", name: "Nicaragua", dial_code: "+505", flag: "🇳🇮", mask: "#### ####" },
      { code: "US", name: "United States", dial_code: "+1", flag: "🇺🇸", mask: "(###) ###-####" },
      { code: "CA", name: "Canada", dial_code: "+1", flag: "🇨🇦", mask: "(###) ###-####" },
      { code: "ES", name: "España", dial_code: "+34", flag: "🇪🇸", mask: "### ## ## ##" },
      { code: "PT", name: "Portugal", dial_code: "+351", flag: "🇵🇹", mask: "### ### ###" },
      { code: "GB", name: "United Kingdom", dial_code: "+44", flag: "🇬🇧", mask: "#### ### ####" },
      { code: "DE", name: "Germany", dial_code: "+49", flag: "🇩🇪", mask: "### #########" },
      { code: "FR", name: "France", dial_code: "+33", flag: "🇫🇷", mask: "# ## ## ## ##" },
      { code: "IT", name: "Italy", dial_code: "+39", flag: "🇮🇹", mask: "### ### ####" },
      { code: "JP", name: "Japan", dial_code: "+81", flag: "🇯🇵", mask: "##-####-####" },
      { code: "CN", name: "China", dial_code: "+86", flag: "🇨🇳", mask: "### #### ####" },
      { code: "IN", name: "India", dial_code: "+91", flag: "🇮🇳", mask: "##### #####" },
      { code: "AU", name: "Australia", dial_code: "+61", flag: "🇦🇺", mask: "### ### ###" }
    ]
  end

  mattr_accessor :telephone_styles do
    {
      country_select: {
        base: "mt-1 block border border-r-0 rounded-l-lg focus:ring-blue-500 focus:border-blue-500",
        colors: {
          default: "text-slate-900 bg-slate-50 border-slate-300 dark:bg-slate-700 dark:border-slate-600 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500",
          success: "text-green-900 bg-green-50 border-green-300 dark:bg-green-700 dark:border-green-600 dark:text-white",
          danger: "text-red-900 bg-red-50 border-red-300 dark:bg-red-700 dark:border-red-600 dark:text-white",
          warning: "text-yellow-900 bg-yellow-50 border-yellow-300 dark:bg-yellow-700 dark:border-yellow-600 dark:text-white",
          info: "text-cyan-900 bg-cyan-50 border-cyan-300 dark:bg-cyan-700 dark:border-cyan-600 dark:text-white"
        },
        width: "w-24",
        sizes: [
          { padding: "p-2", text: "text-xs" },      # Small (0)
          { padding: "p-2.5", text: "text-sm" },    # Medium (1)
          { padding: "p-4", text: "text-base" }     # Large (2)
        ]
      },
      input: {
        sizes: [
          "p-2 text-xs rounded-lg",      # Small (0)
          "p-2.5 text-sm rounded-lg",    # Medium (1)
          "p-4 text-base rounded-lg"     # Large (2)
        ]
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
