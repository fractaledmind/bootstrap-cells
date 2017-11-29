# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EntryCell do
  let(:cell) { described_class.call(instructions) }
  let(:rendered) { cell.call }
  subject { Capybara.string(rendered) }

  # it { p rendered }

  describe 'HTML structure' do
    context 'when empty instructions' do
      let(:instructions) { {} }

      it { should have_selector('dl.text-center.my-0') }
      it { should have_selector('dl > dt', text: nil) }
      it { should have_selector('dl > dd', text: '—') }

      context 'and props are passed' do
        let(:instructions) do
          {
            props: {
              entry: { class: 'test', id: 'entry', data: { attribute: 'foo' } },
              key: { class: 'test', id: 'key', data: { attribute: 'foo' } },
              value: { class: 'test', id: 'value', data: { attribute: 'foo' } }
            }
          }
        end

        it { should have_selector('dl.text-center.my-0.test#entry') }
        it { should have_selector('dl > dt.test#key', text: nil) }
        it { should have_selector('dl > dd.test#value', text: '—') }
      end

      context 'and meta are passed' do
        context 'where type is row' do
          let(:instructions) do
            {
              meta: {
                entry: { type: 'row' }
              }
            }
          end

          it { should have_selector('dl.d-flex.my-0') }
          it { should have_selector('dl > dt.col-4.text-center.mb-0', text: nil) }
          it { should have_selector('dl > dd.col.mb-0', text: '—') }
        end
      end
    end

    context 'when `key` only is defined' do
      context 'as String' do
        let(:key) { 'KEY' }
        let(:instructions) { { key: key } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: key) }
        it { should have_selector('dl > dd', text: '—') }

        context 'and props are passed' do
          let(:instructions) { { key: key, props: { key: { class: 'test', id: 'key' } } } }

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt.test#key', text: key) }
          it { should have_selector('dl > dd', text: '—') }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                key: key,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: key) }
            it { should have_selector('dl > dd.col.mb-0', text: '—') }
          end
        end
      end

      context 'as Stringable' do
        let(:key) { :KEY }
        let(:instructions) { { key: key } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: key) }
        it { should have_selector('dl > dd', text: '—') }

        context 'and props are passed' do
          let(:instructions) { { key: key, props: { key: { class: 'test', id: 'key' } } } }

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt.test#key', text: key) }
          it { should have_selector('dl > dd', text: '—') }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                key: key,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: key) }
            it { should have_selector('dl > dd.col.mb-0', text: '—') }
          end
        end
      end

      context 'as Callable' do
        let(:key) { ->() { 'KEY' } }
        let(:instructions) { { key: key } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: key.call) }
        it { should have_selector('dl > dd', text: '—') }

        context 'and props are passed' do
          let(:instructions) { { key: key, props: { key: { class: 'test', id: 'key' } } } }

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt.test#key', text: key.call) }
          it { should have_selector('dl > dd', text: '—') }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                key: key,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: key.call) }
            it { should have_selector('dl > dd.col.mb-0', text: '—') }
          end
        end
      end
    end

    context 'when `value` only is defined' do
      context 'as String' do
        let(:value) { 'VALUE' }
        let(:instructions) { { value: value } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: nil) }
        it { should have_selector('dl > dd', text: value) }

        context 'and props are passed' do
          let(:instructions) { { value: value, props: { value: { class: 'test', id: 'value' } } } }

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt', text: nil) }
          it { should have_selector('dl > dd.test#value', text: value) }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                value: value,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: nil) }
            it { should have_selector('dl > dd.col.mb-0', text: value) }
          end
        end
      end

      context 'as Stringable' do
        let(:value) { :VALUE }
        let(:instructions) { { value: value } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: nil) }
        it { should have_selector('dl > dd', text: value) }

        context 'and props are passed' do
          let(:instructions) { { value: value, props: { value: { class: 'test', id: 'value' } } } }

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt', text: nil) }
          it { should have_selector('dl > dd.test#value', text: value) }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                value: value,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: nil) }
            it { should have_selector('dl > dd.col.mb-0', text: value) }
          end
        end
      end

      context 'as Callable' do
        let(:value) { ->() { 'VALUE' } }
        let(:instructions) { { value: value } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: nil) }
        it { should have_selector('dl > dd', text: value.call) }

        context 'and props are passed' do
          let(:instructions) { { value: value, props: { value: { class: 'test', id: 'value' } } } }

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt', text: nil) }
          it { should have_selector('dl > dd.test#value', text: value.call) }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                value: value,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: nil) }
            it { should have_selector('dl > dd.col.mb-0', text: value.call) }
          end
        end
      end
    end

    context 'when `key` and `value` are defined' do
      context 'as Strings' do
        let(:key) { 'KEY' }
        let(:value) { 'VALUE' }
        let(:instructions) { { key: key, value: value } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: key) }
        it { should have_selector('dl > dd', text: value) }

        context 'and props are passed' do
          let(:instructions) do
            { key: key, value: value,
              props: {
                key: { class: 'test', id: 'key' },
                value: { class: 'test', id: 'value' }
              } }
          end

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt.test#key', text: key) }
          it { should have_selector('dl > dd.test#value', text: value) }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                key: key,
                value: value,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: key) }
            it { should have_selector('dl > dd.col.mb-0', text: value) }
          end
        end
      end

      context 'as Stringables' do
        let(:key) { :KEY }
        let(:value) { :VALUE }
        let(:instructions) { { key: key, value: value } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: key) }
        it { should have_selector('dl > dd', text: value) }

        context 'and props are passed' do
          let(:instructions) do
            { key: key, value: value,
              props: {
                key: { class: 'test', id: 'key' },
                value: { class: 'test', id: 'value' }
              } }
          end

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt.test#key', text: key) }
          it { should have_selector('dl > dd.test#value', text: value) }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                key: key,
                value: value,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: key) }
            it { should have_selector('dl > dd.col.mb-0', text: value) }
          end
        end
      end

      context 'as Callables' do
        let(:key) { ->() { 'KEY' } }
        let(:value) { ->() { 'VALUE' } }
        let(:instructions) { { key: key, value: value } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: key.call) }
        it { should have_selector('dl > dd', text: value.call) }

        context 'and props are passed' do
          let(:instructions) do
            { key: key, value: value,
              props: {
                key: { class: 'test', id: 'key' },
                value: { class: 'test', id: 'value' }
              } }
          end

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt.test#key', text: key.call) }
          it { should have_selector('dl > dd.test#value', text: value.call) }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                key: key,
                value: value,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: key.call) }
            it { should have_selector('dl > dd.col.mb-0', text: value.call) }
          end
        end
      end

      context 'but are different kinds of values' do
        let(:key) { ->() { 'KEY' } }
        let(:value) { :VALUE }
        let(:instructions) { { key: key, value: value } }

        it { should have_selector('dl.text-center.my-0') }
        it { should have_selector('dl > dt', text: key.call) }
        it { should have_selector('dl > dd', text: value) }

        context 'and props are passed' do
          let(:instructions) do
            { key: key, value: value,
              props: {
                key: { class: 'test', id: 'key' },
                value: { class: 'test', id: 'value' }
              } }
          end

          it { should have_selector('dl.text-center.my-0') }
          it { should have_selector('dl > dt.test#key', text: key.call) }
          it { should have_selector('dl > dd.test#value', text: value) }
        end

        context 'and meta are passed' do
          context 'where type is row' do
            let(:instructions) do
              {
                key: key,
                value: value,
                meta: {
                  entry: { type: 'row' }
                }
              }
            end

            it { should have_selector('dl.d-flex.my-0') }
            it { should have_selector('dl > dt.col-4.text-center.mb-0', text: key.call) }
            it { should have_selector('dl > dd.col.mb-0', text: value) }
          end
        end
      end
    end
  end
end
