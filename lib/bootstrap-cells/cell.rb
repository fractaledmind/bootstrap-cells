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

    def props_for(k)
      defaults = try(:props) || self.class.props
      merge_props(defaults: defaults.dig(k),
                  overrides: instructions.dig(:props, k))
    end

    def value_for(*keypath)
      # return unless self.class.structure.keys.include?(k)
      value = keypath.reduce(instructions) { |m, k| m.try(:dig, k) }
      return value.call                   if value.respond_to?(:call) &&
                                             structure_key_can_be?(keypath, :Callable)
      return value_for(*keypath, :value)  if value.is_a?(Hash) &&
                                             structure_key_can_be?(keypath, Hash)
      return value                        if structure_key_can_be?(keypath, value.class)
      return value.to_s                   if value.respond_to?(:to_s) &&
                                             structure_key_can_be?(keypath, :Stringable) &&
                                             !value.nil?

      access_structure_value(*keypath, :default)
    end

    def meta_for(*keypath)
      defaults = try(:meta) || self.class.meta

      access(instructions, :meta, *keypath) || access(defaults, *keypath)
    end

    def instructions
      model.merge(options).with_indifferent_access
    end

    def merge_props(defaults:, overrides:)
      defaults = (defaults || {}).deep_symbolize_keys
      overrides = (overrides || {}).deep_symbolize_keys
      defaults.deep_merge(overrides) { |k, o, n| k == :class ? meld(n, o) : n }
    end

    private

    def structure_key_can_be?(keypath, type)
      access_structure_value(*keypath, :type)&.include?(type)
    end

    def access_structure_value(*keypath, value)
      access(self.class.structure, *structure_keypath(*keypath), value)
    end

    def structure_keypath(*keypath)
      Array.wrap(keypath).flat_map { |i| [i, :structure] }[0..-2]
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
