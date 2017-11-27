# frozen_string_literal: true

class AlertCell < BootstrapCells::Cell
  def self.structure
    {
      title: {
        type: %i[Stringable Callable],
        default: nil,
        required: false
      },
      body: {
        type: %i[Stringable Callable],
        default: nil,
        required: false
      }
    }
  end

  def self.props
    {
      alert: {
        class: 'alert',
        role: 'alert'
      },
      title: {
        class: 'alert-title'
      },
      body: {
        class: 'alert-body'
      }
    }
  end

  def self.meta
    {
      alert: {
        dismissable: false,
        type: nil
      }
    }
  end

  def props
    instance_props = {
      alert: {
        class: meld(
          ('alert-dismissable' if meta_for(:alert, :dismissable)),
          ("alert-#{meta_for(:alert, :type)}" if meta_for(:alert, :type)),
          ('border-silver' unless meta_for(:alert, :type))
        )
      }
    }
    merge_props(defaults: self.class.props,
                overrides: instance_props)
  end
end
