# frozen_string_literal: true

class EntryCell < BootstrapCells::Cell
  def self.structure
    {
      key: {
        type: [:Stringable, :Callable],
        default: nil,
        required: false
      },
      value: {
        type: [:Stringable, :Callable],
        default: '—',
        required: false
      }
    }
  end

  def self.props
    {
      entry: {
        class: 'text-center my-0'
      },
      key: {},
      value: {}
    }
  end
end
