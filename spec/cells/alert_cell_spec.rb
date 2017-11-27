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

      it { should have_selector('div.alert.border-silver[role="alert"]') }
      it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
      it { should_not have_selector('.alert > .alert-title') }
      it { should_not have_selector('.alert > .alert-body') }

      context 'and props are passed' do
        let(:instructions) do
          {
            props: {
              alert: { class: 'test', id: 'alert' },
              title: { class: 'test', id: 'title' },
              body: { class: 'test', id: 'body' }
            }
          }
        end

        it { should have_selector('div.alert.border-silver.test#alert[role="alert"]') }
        it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
        it { should_not have_selector('.alert > .alert-title') }
        it { should_not have_selector('.alert > .alert-body') }
      end

      context 'and meta are passed' do
        context 'where dismissable is true' do
          let(:instructions) do
            {
              meta: {
                alert: { dismissable: true }
              }
            }
          end

          it { should have_selector('div.alert.alert-dismissable.border-silver[role="alert"]') }
          it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
          it { should_not have_selector('.alert > .alert-title') }
          it { should_not have_selector('.alert > .alert-body') }
        end

        context 'where type is specified' do
          let(:type) { 'warning' }
          let(:instructions) do
            {
              meta: {
                alert: { type: type }
              }
            }
          end

          it { should have_selector("div.alert.alert-#{type}[role='alert']") }
          it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
          it { should_not have_selector('.alert > .alert-title') }
          it { should_not have_selector('.alert > .alert-body') }
        end

        context 'where dismissable is true and type is specified' do
          let(:type) { 'warning' }
          let(:instructions) do
            {
              meta: {
                alert: {
                  dismissable: true,
                  type: type
                }
              }
            }
          end

          it { should have_selector("div.alert.alert-#{type}[role='alert']") }
          it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
          it { should_not have_selector('.alert > .alert-title') }
          it { should_not have_selector('.alert > .alert-body') }
        end
      end
    end

    context 'when `title` only is defined' do
      context 'as String' do
        let(:title) { 'TITLE' }
        let(:instructions) { { title: title } }

        it { should have_selector('div.alert.border-silver[role="alert"]') }
        it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
        it { should have_selector('.alert > h4.alert-title', text: title) }
        it { should_not have_selector('.alert > .alert-body') }

        context 'and props are passed' do
          let(:instructions) { { title: title, props: { title: { class: 'test', id: 'title' } } } }

          it { should have_selector('div.alert.border-silver[role="alert"]') }
          it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
          it { should have_selector('.alert > h4.alert-title.test#title', text: title) }
          it { should_not have_selector('.alert > .alert-body') }
        end

        context 'and meta are passed' do
          context 'where dismissable is true' do
            let(:instructions) do
              {
                title: title,
                meta: {
                  alert: { dismissable: true }
                }
              }
            end

            it { should have_selector('div.alert.alert-dismissable.border-silver[role="alert"]') }
            it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should have_selector('.alert > h4.alert-title', text: title) }
            it { should_not have_selector('.alert > .alert-body') }
          end

          context 'where type is specified' do
            let(:type) { 'warning' }
            let(:instructions) do
              {
                title: title,
                meta: {
                  alert: { type: type }
                }
              }
            end

            it { should have_selector("div.alert.alert-#{type}[role='alert']") }
            it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should have_selector('.alert > h4.alert-title', text: title) }
            it { should_not have_selector('.alert > .alert-body') }
          end

          context 'where dismissable is true and type is specified' do
            let(:type) { 'warning' }
            let(:instructions) do
              {
                title: title,
                meta: {
                  alert: {
                    dismissable: true,
                    type: type
                  }
                }
              }
            end

            it { should have_selector("div.alert.alert-#{type}[role='alert']") }
            it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should have_selector('.alert > h4.alert-title', text: title) }
            it { should_not have_selector('.alert > .alert-body') }
          end
        end
      end
    end

    context 'when `body` only is defined' do
      context 'as String' do
        let(:body) { 'BODY' }
        let(:instructions) { { body: body } }

        it { should have_selector('div.alert.border-silver[role="alert"]') }
        it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
        it { should_not have_selector('.alert > .alert-title') }
        it { should have_selector('.alert > div.alert-body', text: body) }

        context 'and props are passed' do
          let(:instructions) { { body: body, props: { body: { class: 'test', id: 'body' } } } }

          it { should have_selector('div.alert.border-silver[role="alert"]') }
          it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
          it { should_not have_selector('.alert > .alert-title') }
          it { should have_selector('.alert > div.alert-body.test#body', text: body) }
        end

        context 'and meta are passed' do
          context 'where dismissable is true' do
            let(:instructions) do
              {
                body: body,
                meta: {
                  alert: { dismissable: true }
                }
              }
            end

            it { should have_selector('div.alert.alert-dismissable.border-silver[role="alert"]') }
            it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should_not have_selector('.alert > .alert-title') }
            it { should have_selector('.alert > div.alert-body', text: body) }
          end

          context 'where type is specified' do
            let(:type) { 'warning' }
            let(:instructions) do
              {
                body: body,
                meta: {
                  alert: { type: type }
                }
              }
            end

            it { should have_selector("div.alert.alert-#{type}[role='alert']") }
            it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should_not have_selector('.alert > .alert-title') }
            it { should have_selector('.alert > div.alert-body', text: body) }
          end

          context 'where dismissable is true and type is specified' do
            let(:type) { 'warning' }
            let(:instructions) do
              {
                body: body,
                meta: {
                  alert: {
                    dismissable: true,
                    type: type
                  }
                }
              }
            end

            it { should have_selector("div.alert.alert-#{type}[role='alert']") }
            it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should_not have_selector('.alert > .alert-title') }
            it { should have_selector('.alert > div.alert-body', text: body) }
          end
        end
      end
    end

    context 'when `title` and `body` are both defined' do
      context 'as Strings' do
        let(:title) { 'TITLE' }
        let(:body) { 'BODY' }
        let(:instructions) { { title: title, body: body } }

        it { should have_selector('div.alert.border-silver[role="alert"]') }
        it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
        it { should have_selector('.alert > h4.alert-title', text: title) }
        it { should have_selector('.alert > div.alert-body', text: body) }

        context 'and props are passed' do
          let(:instructions) do
            {
              title: title, body: body,
              props: {
                title: { class: 'test', id: 'title' },
                body: { class: 'test', id: 'body' }
              }
            }
          end

          it { should have_selector('div.alert.border-silver[role="alert"]') }
          it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
          it { should have_selector('.alert > h4.alert-title.test#title', text: title) }
          it { should have_selector('.alert > div.alert-body.test#body', text: body) }
        end

        context 'and meta are passed' do
          context 'where dismissable is true' do
            let(:instructions) do
              {
                title: title,
                body: body,
                meta: {
                  alert: { dismissable: true }
                }
              }
            end

            it { should have_selector('div.alert.alert-dismissable.border-silver[role="alert"]') }
            it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should have_selector('.alert > h4.alert-title', text: title) }
            it { should have_selector('.alert > div.alert-body', text: body) }
          end

          context 'where type is specified' do
            let(:type) { 'warning' }
            let(:instructions) do
              {
                title: title,
                body: body,
                meta: {
                  alert: { type: type }
                }
              }
            end

            it { should have_selector("div.alert.alert-#{type}[role='alert']") }
            it { should_not have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should have_selector('.alert > h4.alert-title', text: title) }
            it { should have_selector('.alert > div.alert-body', text: body) }
          end

          context 'where dismissable is true and type is specified' do
            let(:type) { 'warning' }
            let(:instructions) do
              {
                title: title,
                body: body,
                meta: {
                  alert: {
                    dismissable: true,
                    type: type
                  }
                }
              }
            end

            it { should have_selector("div.alert.alert-#{type}[role='alert']") }
            it { should have_selector('.alert > button.close[data-dismiss="alert"]') }
            it { should have_selector('.alert > h4.alert-title', text: title) }
            it { should have_selector('.alert > div.alert-body', text: body) }
          end
        end
      end
    end
  end
end
