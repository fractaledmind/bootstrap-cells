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
    instance_props = merge_props(btn_tag_props,
                                 btn_type_props,
                                 icon_position_props,
                                 values_props)

    merge_props(self.class.props, instance_props)
  end

  private

  def btn_tag_props
    Hash.new { |hash, key| hash[key] = {} }.tap do |h|
      if meta_for(:btn, :tag) == 'a'
        h[:btn][:role] = 'button'
        h[:btn][:href] ||= ''
      else
        h[:btn][:type] = 'button'
      end
    end
  end

  def btn_type_props
    return {} unless meta_for(:btn, :type)

    Hash.new { |hash, key| hash[key] = {} }.tap do |h|
      h[:btn][:class] = "btn-#{meta_for(:btn, :type)}"
    end
  end

  def icon_position_props
    Hash.new { |hash, key| hash[key] = {} }.tap do |h|
      if meta_for(:icon, :position) == 'left'
        h[:text][:class] = 'order-2'
        h[:icon][:class] = 'order-1 mr-1'
      else
        h[:icon][:class] = 'ml-1'
      end
    end
  end

  def values_props
    Hash.new { |hash, key| hash[key] = {} }.tap do |h|
      h[:icon][:class] = "fa-#{value_for(:icon)}"

      if value_for(:text) && value_for(:icon)
        h[:btn][:class] = 'd-flex justify-content-between align-items-center'
      end
    end
  end
end
