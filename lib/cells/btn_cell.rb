# frozen_string_literal: true

class BtnCell < BootstrapCells::Cell
  def self.structure
    {
      tag: {
        type: [:Stringable, :Callable],
        default: :a,
        required: false
      },
      text: {
        type: [:Stringable, :Callable],
        default: nil,
        required: false
      },
      icon: {
        type: [Hash, :Stringable, :Callable],
        default: nil,
        required: false,
        structure: {
          position: {
            type: [:Stringable, :Callable],
            default: 'right',
            required: false
          },
          value: {
            type: [:Stringable, :Callable],
            default: nil,
            required: false
          }
        }
      }
    }
  end

  def self.props
    {
      btn: {
        class: 'btn d-flex justify-content-between align-items-center'
      },
      text: {},
      icon: {
        class: 'fa'
      }
    }
  end

  def props
    instance_props = {
      btn: {
        (value_for(:tag) == :a ? :role : :type) => 'button'
      },
      text: {
        class: value_for(:icon, :position) == 'left' ? 'order-2' : nil
      },
      icon: {
        class: "fa-#{value_for(:icon)} m#{value_for(:icon, :position) == 'left' ? 'r' : 'l'}-1 #{value_for(:icon, :position) == 'left' ? 'order-1' : ''}"
      }
    }
    merge_props(defaults: self.class.props,
                overrides: instance_props)
  end
end
