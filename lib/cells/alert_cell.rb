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
    instance_props = merge_props(alert_type_props,
                                 alert_dismissable_props)

    merge_props(self.class.props,
                instance_props)
  end

  private

  def alert_type_props
    Hash.new { |hash, key| hash[key] = {} }.tap do |h|
      if meta_for(:alert, :type)
        h[:alert][:class] = "alert-#{meta_for(:alert, :type)}"
      else
        h[:alert][:class] = 'border-secondary'
      end
    end
  end

  def alert_dismissable_props
    return {} unless meta_for(:alert, :dismissable)

    Hash.new { |hash, key| hash[key] = {} }.tap do |h|
      h[:alert][:class] = 'alert-dismissable'
    end
  end
end
