# frozen_string_literal: true

class EntryCell < BootstrapCells::Cell
  def self.structure
    {
      key: {
        type: %i[Stringable Callable],
        required: true
      },
      value: {
        type: %i[Stringable Callable],
        default: '—',
        required: false
      }
    }
  end

  def self.props
    {
      entry: {
        class: 'my-0'
      },
      key: {},
      value: {}
    }
  end

  def self.meta
    {
      entry: {
        type: 'column'
      }
    }
  end

  def props
    instance_props = entry_type_props

    merge_props(self.class.props,
                instance_props)
  end

  private

  def entry_type_props
    Hash.new { |hash, key| hash[key] = {} }.tap do |h|
      if meta_for(:entry, :type) == 'row'
        h[:entry][:class] = 'd-flex'
        h[:key][:class] = 'col-4 text-center mb-0'
        h[:value][:class] = 'col mb-0'
      else
        h[:entry][:class] = 'text-center'
      end
    end
  end
end
