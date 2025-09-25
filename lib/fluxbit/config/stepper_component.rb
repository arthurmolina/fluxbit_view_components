# frozen_string_literal: true

module Fluxbit::Config::StepperComponent
  mattr_accessor :orientation, default: :horizontal
  mattr_accessor :variant, default: :default
  mattr_accessor :color, default: :blue

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: {
        horizontal: "flex items-center w-full",
        vertical: "flex flex-col"
      },
      list: {
        default: {
          horizontal: "flex items-center w-full text-sm font-medium text-center text-gray-500 dark:text-gray-400 sm:text-base",
          vertical: "text-sm font-medium text-gray-500 dark:text-gray-400"
        },
        progress: {
          horizontal: "flex items-center w-full text-sm font-medium text-center text-gray-500 dark:text-gray-400 sm:text-base",
          vertical: "text-sm font-medium text-gray-500 dark:text-gray-400"
        },
        detailed: {
          horizontal: "flex items-center w-full text-sm font-medium text-center text-gray-500 dark:text-gray-400 sm:text-base",
          vertical: "space-y-4"
        }
      },
      item: {
        default: {
          horizontal: "flex md:w-full items-center",
          vertical: "mb-4"
        },
        progress: {
          horizontal: "flex md:w-full items-center",
          vertical: "mb-4"
        },
        detailed: {
          horizontal: "flex md:w-full items-center",
          vertical: "flex items-start p-4 border border-gray-200 rounded-lg dark:border-gray-700 relative"
        }
      },
      step: {
        default: {
          base: "flex items-center justify-center w-10 h-10 bg-gray-100 rounded-full lg:h-12 lg:w-12 dark:bg-gray-700 shrink-0",
          completed: "flex items-center justify-center w-10 h-10 rounded-full lg:h-12 lg:w-12 dark:bg-green-800 bg-green-100 shrink-0",
          active: {
            blue: "flex items-center justify-center w-10 h-10 bg-blue-100 rounded-full lg:h-12 lg:w-12 dark:bg-blue-800 shrink-0",
            green: "flex items-center justify-center w-10 h-10 bg-green-100 rounded-full lg:h-12 lg:w-12 dark:bg-green-800 shrink-0",
            red: "flex items-center justify-center w-10 h-10 bg-red-100 rounded-full lg:h-12 lg:w-12 dark:bg-red-800 shrink-0",
            yellow: "flex items-center justify-center w-10 h-10 bg-yellow-100 rounded-full lg:h-12 lg:w-12 dark:bg-yellow-800 shrink-0",
            indigo: "flex items-center justify-center w-10 h-10 bg-indigo-100 rounded-full lg:h-12 lg:w-12 dark:bg-indigo-800 shrink-0",
            purple: "flex items-center justify-center w-10 h-10 bg-purple-100 rounded-full lg:h-12 lg:w-12 dark:bg-purple-800 shrink-0"
          }
        },
        progress: {
          base: "flex items-center justify-center w-8 h-8 bg-gray-100 rounded-full dark:bg-gray-700 shrink-0",
          completed: "flex items-center justify-center w-8 h-8 rounded-full dark:bg-green-600 bg-green-600 shrink-0",
          active: {
            blue: "flex items-center justify-center w-8 h-8 bg-blue-600 rounded-full dark:bg-blue-600 shrink-0",
            green: "flex items-center justify-center w-8 h-8 bg-green-600 rounded-full dark:bg-green-600 shrink-0",
            red: "flex items-center justify-center w-8 h-8 bg-red-600 rounded-full dark:bg-red-600 shrink-0",
            yellow: "flex items-center justify-center w-8 h-8 bg-yellow-600 rounded-full dark:bg-yellow-600 shrink-0",
            indigo: "flex items-center justify-center w-8 h-8 bg-indigo-600 rounded-full dark:bg-indigo-600 shrink-0",
            purple: "flex items-center justify-center w-8 h-8 bg-purple-600 rounded-full dark:bg-purple-600 shrink-0"
          }
        },
        detailed: {
          base: "flex items-center justify-center w-12 h-12 bg-white border-2 border-gray-300 rounded-full dark:bg-gray-800 dark:border-gray-600 shrink-0",
          completed: "flex items-center justify-center w-12 h-12 bg-green-600 border-2 border-green-600 rounded-full dark:bg-green-600 dark:border-green-600 shrink-0",
          active: {
            blue: "flex items-center justify-center w-12 h-12 bg-blue-600 border-2 border-blue-600 rounded-full dark:bg-blue-600 dark:border-blue-600 shrink-0",
            green: "flex items-center justify-center w-12 h-12 bg-green-600 border-2 border-green-600 rounded-full dark:bg-green-600 dark:border-green-600 shrink-0",
            red: "flex items-center justify-center w-12 h-12 bg-red-600 border-2 border-red-600 rounded-full dark:bg-red-600 dark:border-red-600 shrink-0",
            yellow: "flex items-center justify-center w-12 h-12 bg-yellow-600 border-2 border-yellow-600 rounded-full dark:bg-yellow-600 dark:border-yellow-600 shrink-0",
            indigo: "flex items-center justify-center w-12 h-12 bg-indigo-600 border-2 border-indigo-600 rounded-full dark:bg-indigo-600 dark:border-indigo-600 shrink-0",
            purple: "flex items-center justify-center w-12 h-12 bg-purple-600 border-2 border-purple-600 rounded-full dark:bg-purple-600 dark:border-purple-600 shrink-0"
          }
        }
      },
      step_number: {
        default: {
          base: "text-gray-500 dark:text-gray-100",
          completed: "text-green-600 dark:text-green-300",
          active: {
            blue: "text-blue-600 dark:text-blue-300",
            green: "text-green-600 dark:text-green-300",
            red: "text-red-600 dark:text-red-300",
            yellow: "text-yellow-600 dark:text-yellow-300",
            indigo: "text-indigo-600 dark:text-indigo-300",
            purple: "text-purple-600 dark:text-purple-300"
          }
        },
        progress: {
          base: "hidden",
          completed: "text-white text-xs font-bold",
          active: {
            blue: "text-white text-xs font-bold",
            green: "text-white text-xs font-bold",
            red: "text-white text-xs font-bold",
            yellow: "text-white text-xs font-bold",
            indigo: "text-white text-xs font-bold",
            purple: "text-white text-xs font-bold"
          }
        },
        detailed: {
          base: "text-gray-600 dark:text-gray-300 font-semibold",
          completed: "text-white font-semibold",
          active: {
            blue: "text-white font-semibold",
            green: "text-white font-semibold",
            red: "text-white font-semibold",
            yellow: "text-white font-semibold",
            indigo: "text-white font-semibold",
            purple: "text-white font-semibold"
          }
        }
      },
      step_icon: {
        default: {
          completed: "w-3.5 h-3.5 text-green-600 dark:text-green-300",
          base: "w-4 h-4 text-gray-500 dark:text-gray-100"
        },
        progress: {
          completed: "w-3 h-3 text-white",
          base: "w-3 h-3 text-gray-500 dark:text-gray-100"
        },
        detailed: {
          completed: "w-4 h-4 text-white",
          base: "w-4 h-4 text-gray-600 dark:text-gray-300"
        }
      },
      content: {
        default: {
          horizontal: "sm:ml-4 ml-2 mt-0",
          vertical: "ml-4 mt-0"
        },
        progress: {
          horizontal: "sm:ml-4 ml-2 mt-0",
          vertical: "ml-4 mt-0"
        },
        detailed: {
          horizontal: "sm:ml-6 ml-4 mt-0",
          vertical: "ml-6 mt-0"
        }
      },
      title: {
        base: "text-gray-900 dark:text-white",
        completed: "text-green-600 dark:text-green-300",
        active: {
          blue: "text-blue-600 dark:text-blue-300",
          green: "text-green-600 dark:text-green-300",
          red: "text-red-600 dark:text-red-300",
          yellow: "text-yellow-600 dark:text-yellow-300",
          indigo: "text-indigo-600 dark:text-indigo-300",
          purple: "text-purple-600 dark:text-purple-300"
        }
      },
      description: "text-sm text-gray-500 dark:text-gray-400",
      connector: {
        default: {
          horizontal: "hidden sm:flex w-full bg-gray-200 h-0.5 dark:bg-gray-700",
          vertical: "w-0.5 h-6 bg-gray-200 dark:bg-gray-700 mx-auto"
        },
        progress: {
          horizontal: "hidden sm:flex w-full bg-gray-200 h-0.5 dark:bg-gray-700",
          vertical: "w-0.5 h-6 bg-gray-200 dark:bg-gray-700 mx-auto"
        },
        detailed: {
          horizontal: "hidden sm:flex w-full bg-gray-200 h-0.5 dark:bg-gray-700",
          vertical: "w-0.5 h-6 bg-gray-200 dark:bg-gray-700 mx-auto"
        },
        completed: {
          default: {
            horizontal: "hidden sm:flex w-full bg-green-200 h-0.5 dark:bg-green-700",
            vertical: "w-0.5 h-6 bg-green-200 dark:bg-green-700 mx-auto"
          },
          progress: {
            horizontal: "hidden sm:flex w-full bg-green-200 h-0.5 dark:bg-green-700",
            vertical: "w-0.5 h-6 bg-green-200 dark:bg-green-700 mx-auto"
          },
          detailed: {
            horizontal: "hidden sm:flex w-full bg-green-200 h-0.5 dark:bg-green-700",
            vertical: "w-0.5 h-6 bg-green-200 dark:bg-green-700 mx-auto"
          }
        },
        active: {
          blue: {
            default: {
              horizontal: "hidden sm:flex w-full bg-blue-200 h-0.5 dark:bg-blue-700",
              vertical: "w-0.5 h-6 bg-blue-200 dark:bg-blue-700 mx-auto"
            },
            progress: {
              horizontal: "hidden sm:flex w-full bg-blue-200 h-0.5 dark:bg-blue-700",
              vertical: "w-0.5 h-6 bg-blue-200 dark:bg-blue-700"
            },
            detailed: {
              horizontal: "hidden sm:flex w-full bg-blue-200 h-0.5 dark:bg-blue-700",
              vertical: "w-0.5 h-6 bg-blue-200 dark:bg-blue-700"
            }
          },
          green: {
            default: {
              horizontal: "hidden sm:flex w-full bg-green-200 h-0.5 dark:bg-green-700",
              vertical: "ml-5 w-0.5 h-6 bg-green-200 dark:bg-green-700"
            },
            progress: {
              horizontal: "hidden sm:flex w-full bg-green-200 h-0.5 dark:bg-green-700",
              vertical: "w-0.5 h-6 bg-green-200 dark:bg-green-700 mx-auto"
            },
            detailed: {
              horizontal: "hidden sm:flex w-full bg-green-200 h-0.5 dark:bg-green-700",
              vertical: "w-0.5 h-6 bg-green-200 dark:bg-green-700 mx-auto"
            }
          },
          red: {
            default: {
              horizontal: "hidden sm:flex w-full bg-red-200 h-0.5 dark:bg-red-700",
              vertical: "ml-5 w-0.5 h-6 bg-red-200 dark:bg-red-700"
            },
            progress: {
              horizontal: "hidden sm:flex w-full bg-red-200 h-0.5 dark:bg-red-700",
              vertical: "w-0.5 h-6 bg-red-200 dark:bg-red-700 mx-auto"
            },
            detailed: {
              horizontal: "hidden sm:flex w-full bg-red-200 h-0.5 dark:bg-red-700",
              vertical: "w-0.5 h-6 bg-red-200 dark:bg-red-700 mx-auto"
            }
          },
          yellow: {
            default: {
              horizontal: "hidden sm:flex w-full bg-yellow-200 h-0.5 dark:bg-yellow-700",
              vertical: "ml-5 w-0.5 h-6 bg-yellow-200 dark:bg-yellow-700"
            },
            progress: {
              horizontal: "hidden sm:flex w-full bg-yellow-200 h-0.5 dark:bg-yellow-700",
              vertical: "w-0.5 h-6 bg-yellow-200 dark:bg-yellow-700 mx-auto"
            },
            detailed: {
              horizontal: "hidden sm:flex w-full bg-yellow-200 h-0.5 dark:bg-yellow-700",
              vertical: "w-0.5 h-6 bg-yellow-200 dark:bg-yellow-700 mx-auto"
            }
          },
          indigo: {
            default: {
              horizontal: "hidden sm:flex w-full bg-indigo-200 h-0.5 dark:bg-indigo-700",
              vertical: "ml-5 w-0.5 h-6 bg-indigo-200 dark:bg-indigo-700"
            },
            progress: {
              horizontal: "hidden sm:flex w-full bg-indigo-200 h-0.5 dark:bg-indigo-700",
              vertical: "w-0.5 h-6 bg-indigo-200 dark:bg-indigo-700 mx-auto"
            },
            detailed: {
              horizontal: "hidden sm:flex w-full bg-indigo-200 h-0.5 dark:bg-indigo-700",
              vertical: "w-0.5 h-6 bg-indigo-200 dark:bg-indigo-700 mx-auto"
            }
          },
          purple: {
            default: {
              horizontal: "hidden sm:flex w-full bg-purple-200 h-0.5 dark:bg-purple-700",
              vertical: "ml-5 w-0.5 h-6 bg-purple-200 dark:bg-purple-700"
            },
            progress: {
              horizontal: "hidden sm:flex w-full bg-purple-200 h-0.5 dark:bg-purple-700",
              vertical: "w-0.5 h-6 bg-purple-200 dark:bg-purple-700 mx-auto"
            },
            detailed: {
              horizontal: "hidden sm:flex w-full bg-purple-200 h-0.5 dark:bg-purple-700",
              vertical: "w-0.5 h-6 bg-purple-200 dark:bg-purple-700 mx-auto"
            }
          }
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end