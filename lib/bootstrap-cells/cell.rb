# frozen_string_literal: true

# requirements for `content_tag` to work
require 'active_support/concern'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require 'action_view/helpers/capture_helper'
require 'action_view/helpers/output_safety_helper'
require 'action_view/context'
require 'action_view/helpers/tag_helper'

# requirements for our helper methods to work
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/deep_merge'

module BootstrapCells
  class Cell < ::Cell::ViewModel
    view_paths << "#{File.dirname(__dir__)}/cells"

    include ActionView::Helpers::TagHelper
    include ::Cell::Erb

    def props_for(key)
      defaults = try(:props) || self.class.props
      merge_props(defaults.dig(key),
                  instructions.dig(:props, key))
    end

    def value_for(key)
      return unless self.class.structure.keys.include?(key)

      value = access(instructions, key)
      fail("`#{key}` is a required field") if access_structure_value(key, :required) && !value
      return value.call                   if value.respond_to?(:call) &&
                                             structure_key_can_be?(key, :Callable)
      return value                        if structure_key_can_be?(key, value.class)
      return value.to_s                   if value.respond_to?(:to_s) &&
                                             structure_key_can_be?(key, :Stringable) &&
                                             !value.nil?

      access_structure_value(key, :default)
    end

    def meta_for(*keypath)
      defaults = try(:meta) || self.class.meta

      metadata = access(instructions, :meta, *keypath) || access(defaults, *keypath)
      return metadata.to_s if metadata
    end

    def instructions
      model.merge(options).with_indifferent_access
    end

    def merge_props(*prop_hashes)
      prop_hashes.compact
                 .map(&:deep_symbolize_keys)
                 .reduce do |memo_hash, current_hash|
                   memo_hash.deep_merge(current_hash) do |key, old_val, new_val|
                     next meld(new_val, old_val) if key == :class
                     new_val
                   end
                 end
    end

    private

    def structure_key_can_be?(keypath, type)
      access_structure_value(*keypath, :type)&.include?(type)
    end

    def access_structure_value(*keypath, value)
      access(self.class.structure, *keypath, value)
    end

    def access(hash, *keypath)
      Array.wrap(keypath).reduce(hash) { |memo, key| memo.try(:dig, key) }
    end

    def meld(*args)
      args.flatten
          .compact
          .map(&:to_s)
          .map(&:strip)
          .uniq
          .join(' ')
    end
  end
end
