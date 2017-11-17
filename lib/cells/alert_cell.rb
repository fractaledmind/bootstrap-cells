# frozen_string_literal: true

class AlertCell < BootstrapCells::Cell
  def self.structure
    {
      title: {
        type: [:Stringable, :Callable],
        default: nil,
        required: false
      },
      body: {
        type: [:Stringable, :Callable],
        default: '—',
        required: false
      }
    }
  end

  def self.props
    {
      alert: {
        class: 'alert',
        role: 'alert'
      }
    }
  end

  def props
    instance_props = {
      alert: {
        class: ''
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
