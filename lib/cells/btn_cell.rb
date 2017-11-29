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
        class: 'btn'
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
        tag: 'a',
        type: 'secondary'
      },
      icon: {
        position: 'right'
      }
    }
  end

  def props
    instance_props = {
      btn: {
        (meta_for(:btn, :tag) == 'a' ? :role : :type) => 'button',
        class: "btn-#{meta_for(:btn, :type)}"
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
    instance_props[:btn][:href] = '' if meta_for(:btn, :tag) == 'a'
    instance_props[:btn][:class] = 'd-flex justify-content-between align-items-center' if value_for(:text) && value_for(:icon)
    merge_props(defaults: self.class.props,
                overrides: instance_props)
  end
end
