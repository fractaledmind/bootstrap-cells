# frozen_string_literal: true

class BtnCell < BootstrapCells::Cell
  def self.structure
    {
      text: {
        type: %i[Stringable Callable],
        default: nil,
        required: true
      },
      icon: {
        type: %i[Stringable Callable],
        default: nil,
        required: false
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

  def self.meta
    {
      btn: {
        tag: 'a'
      },
      icon: {
        position: 'right'
      }
    }
  end

  def props
    instance_props = {
      btn: {
        (meta_for(:btn, :tag) == 'a' ? :role : :type) => 'button'
      },
      text: {
        class: meta_for(:icon, :position) == 'left' ? 'order-2' : nil
      },
      icon: {
        class: meld(
          "fa-#{value_for(:icon)}",
          "m#{meta_for(:icon, :position) == 'left' ? 'r' : 'l'}-1",
          meta_for(:icon, :position) == 'left' ? 'order-1' : ''
        )
      }
    }
    merge_props(defaults: self.class.props,
                overrides: instance_props)
  end
end
