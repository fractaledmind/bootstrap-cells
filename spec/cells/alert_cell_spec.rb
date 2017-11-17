# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AlertCell do
  let(:cell) { described_class.call(instructions) }
  let(:rendered) { cell.call }
  subject { Capybara.string(rendered) }

  # it { p rendered }

  describe 'HTML structure' do
    context 'when empty instructions' do
      let(:instructions) { {} }

      it { should have_selector('div.alert[role="alert"]') }
      # it { should_not have_selector('a > span') }
      # it { should_not have_selector('a > i') }

      # context 'and props are passed' do
      #   let(:instructions) do
      #     {
      #       props: {
      #         btn: { class: 'test', id: 'btn' },
      #         text: { class: 'test', id: 'text' },
      #         icon: { class: 'test', id: 'icon' }
      #       }
      #     }
      #   end

      #   it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center.test#btn[role="button"]') }
      #   it { should_not have_selector('a > span') }
      #   it { should_not have_selector('a > i') }
      # end
    end
  end
end
