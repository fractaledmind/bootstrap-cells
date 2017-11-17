# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BtnCell do
  let(:cell) { described_class.call(instructions) }
  let(:rendered) { cell.call }
  subject { Capybara.string(rendered) }

  # it { p rendered }

  describe 'HTML structure' do
    context 'when empty instructions' do
      let(:instructions) { {} }

      it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
      it { should_not have_selector('a > span') }
      it { should_not have_selector('a > i') }

      context 'and props are passed' do
        let(:instructions) do
          {
            props: {
              btn: { class: 'test', id: 'btn' },
              text: { class: 'test', id: 'text' },
              icon: { class: 'test', id: 'icon' }
            }
          }
        end

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center.test#btn[role="button"]') }
        it { should_not have_selector('a > span') }
        it { should_not have_selector('a > i') }
      end
    end

    context 'when `text` only is defined' do
      context 'as String' do
        let(:text) { 'TEXT' }
        let(:instructions) { { text: text } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('a > span', text: text) }
        it { should_not have_selector('a > i') }

        context 'and props are passed' do
          let(:instructions) { { text: text, props: { text: { class: 'test', id: 'text' } } } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span.test#text', text: text) }
          it { should_not have_selector('a > i') }
        end
      end

      context 'as Stringable' do
        let(:text) { :TEXT }
        let(:instructions) { { text: text } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('a > span', text: text) }
        it { should_not have_selector('a > i') }

        context 'and props are passed' do
          let(:instructions) { { text: text, props: { text: { class: 'test', id: 'text' } } } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span.test#text', text: text) }
          it { should_not have_selector('a > i') }
        end
      end

      context 'as Callable' do
        let(:text) { ->() { 'TEXT' } }
        let(:instructions) { { text: text } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('a > span', text: text.call) }
        it { should_not have_selector('a > i') }

        context 'and props are passed' do
          let(:instructions) { { text: text, props: { text: { class: 'test', id: 'text' } } } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span.test#text', text: text.call) }
          it { should_not have_selector('a > i') }
        end
      end
    end

    context 'when `icon` only is defined' do
      context 'as String' do
        let(:icon) { 'icon' }
        let(:instructions) { { icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should_not have_selector('a > span') }
        it { should have_selector("a > i.fa.fa-#{icon}.ml-1") }

        context 'and props are passed' do
          let(:instructions) { { icon: icon, props: { icon: { class: 'test', id: 'icon' } } } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should_not have_selector('a > span') }
          it { should have_selector("a > i.fa.fa-#{icon}.ml-1.test#icon") }
        end
      end

      context 'as Stringable' do
        let(:icon) { :icon }
        let(:instructions) { { icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should_not have_selector('a > span') }
        it { should have_selector("a > i.fa.fa-#{icon}.ml-1") }

        context 'and props are passed' do
          let(:instructions) { { icon: icon, props: { icon: { class: 'test', id: 'icon' } } } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should_not have_selector('a > span') }
          it { should have_selector("a > i.fa.fa-#{icon}.ml-1.test#icon") }
        end
      end

      context 'as Callable' do
        let(:icon) { ->() { 'icon' } }
        let(:instructions) { { icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should_not have_selector('a > span') }
        it { should have_selector("a > i.fa.fa-#{icon.call}.ml-1") }

        context 'and props are passed' do
          let(:instructions) { { icon: icon, props: { icon: { class: 'test', id: 'icon' } } } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should_not have_selector('a > span') }
          it { should have_selector("a > i.fa.fa-#{icon.call}.ml-1.test#icon") }
        end
      end

      context 'as Hash' do
        let(:instructions) { { icon: icon } }

        context 'with position empty' do
          let(:icon) { { value: 'icon' } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should_not have_selector('a > span') }
          it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1") }

          context 'and props are passed' do
            let(:instructions) { { icon: icon, props: { icon: { class: 'test', id: 'icon' } } } }

            it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
            it { should_not have_selector('a > span') }
            it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1.test#icon") }
          end
        end

        context 'with position as right' do
          let(:icon) { { position: 'right', value: 'icon' } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should_not have_selector('a > span') }
          it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1") }

          context 'and props are passed' do
            let(:instructions) { { icon: icon, props: { icon: { class: 'test', id: 'icon' } } } }

            it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
            it { should_not have_selector('a > span') }
            it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1.test#icon") }
          end
        end

        context 'with position as left' do
          let(:icon) { { position: 'left', value: 'icon' } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should_not have_selector('a > span') }
          it { should have_selector("a > i.fa.fa-#{icon[:value]}.mr-1.order-1") }

          context 'and props are passed' do
            let(:instructions) { { icon: icon, props: { icon: { class: 'test', id: 'icon' } } } }

            it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
            it { should_not have_selector('a > span') }
            it { should have_selector("a > i.fa.fa-#{icon[:value]}.mr-1.order-1.test#icon") }
          end
        end
      end
    end

    context 'when `text` and `icon` are both defined' do
      context 'as Strings' do
        let(:text) { 'TEXT' }
        let(:icon) { 'icon' }
        let(:instructions) { { text: text, icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('a > span', text: text) }
        it { should have_selector("a > i.fa.fa-#{icon}.ml-1") }

        context 'and props are passed' do
          let(:instructions) do
            {
              text: text, icon: icon,
              props: {
                text: { class: 'test', id: 'text' },
                icon: { class: 'test', id: 'icon' }
              }
            }
          end

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span.test#text', text: text) }
          it { should have_selector("a > i.fa.fa-#{icon}.ml-1.test#icon") }
        end
      end

      context 'as Stringables' do
        let(:text) { 555 }
        let(:icon) { :icon }
        let(:instructions) { { text: text, icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('a > span', text: text) }
        it { should have_selector("a > i.fa.fa-#{icon}.ml-1") }

        context 'and props are passed' do
          let(:instructions) do
            {
              text: text, icon: icon,
              props: {
                text: { class: 'test', id: 'text' },
                icon: { class: 'test', id: 'icon' }
              }
            }
          end

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span.test#text', text: text) }
          it { should have_selector("a > i.fa.fa-#{icon}.ml-1.test#icon") }
        end
      end

      context 'as Callables' do
        let(:text) { ->() { 'TEXT' } }
        let(:icon) { ->() { 'icon' } }
        let(:instructions) { { text: text, icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('a > span', text: text.call) }
        it { should have_selector("a > i.fa.fa-#{icon.call}.ml-1") }

        context 'and props are passed' do
          let(:instructions) do
            {
              text: text, icon: icon,
              props: {
                text: { class: 'test', id: 'text' },
                icon: { class: 'test', id: 'icon' }
              }
            }
          end

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span.test#text', text: text.call) }
          it { should have_selector("a > i.fa.fa-#{icon.call}.ml-1.test#icon") }
        end
      end

      context 'with `icon` as Hash' do
        let(:text) { 'TEXT' }
        let(:instructions) { { text: text, icon: icon } }

        context 'with position empty' do
          let(:icon) { { value: 'icon' } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span', text: text) }
          it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1") }

          context 'and props are passed' do
            let(:instructions) do
              {
                text: text, icon: icon,
                props: {
                  text: { class: 'test', id: 'text' },
                  icon: { class: 'test', id: 'icon' }
                }
              }
            end

            it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
            it { should have_selector('a > span.test#text', text: text) }
            it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1.test#icon") }
          end
        end

        context 'with position as right' do
          let(:icon) { { position: 'right', value: 'icon' } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span', text: text) }
          it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1") }

          context 'and props are passed' do
            let(:instructions) do
              {
                text: text, icon: icon,
                props: {
                  text: { class: 'test', id: 'text' },
                  icon: { class: 'test', id: 'icon' }
                }
              }
            end

            it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
            it { should have_selector('a > span.test#text', text: text) }
            it { should have_selector("a > i.fa.fa-#{icon[:value]}.ml-1.test#icon") }
          end
        end

        context 'with position as left' do
          let(:icon) { { position: 'left', value: 'icon' } }

          it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
          it { should have_selector('a > span.order-2', text: text) }
          it { should have_selector("a > i.fa.fa-#{icon[:value]}.mr-1.order-1") }

          context 'and props are passed' do
            let(:instructions) do
              {
                text: text, icon: icon,
                props: {
                  text: { class: 'test', id: 'text' },
                  icon: { class: 'test', id: 'icon' }
                }
              }
            end

            it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
            it { should have_selector('a > span.test#text', text: text) }
            it { should have_selector("a > i.fa.fa-#{icon[:value]}.mr-1.order-1.test#icon") }
          end
        end
      end
    end
  end
end
