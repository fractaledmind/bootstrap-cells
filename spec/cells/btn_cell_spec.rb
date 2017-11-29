# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BtnCell do
  let(:cell) { described_class.call(instructions) }
  let(:rendered) { cell.call }
  subject { Capybara.string(rendered) }

  describe 'HTML structure' do
    context 'when empty instructions' do
      let(:instructions) { {} }

      it { expect { subject }.to raise_error('`text` is a required field') }
    end

    context 'when `text` only is defined' do
      context 'as String' do
        let(:text) { 'TEXT' }
        let(:instructions) { { text: text } }

        it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
        it { should have_selector('.btn > span', text: text) }
        it { should_not have_selector('.btn > i') }

        context 'and props are passed' do
          let(:instructions) { { text: text, props: { text: { class: 'test', id: 'text' } } } }

          it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
          it { should have_selector('.btn > span.test#text', text: text) }
          it { should_not have_selector('.btn > i') }
        end

        context 'and meta are passed' do
          context 'where btn tag is button' do
            let(:instructions) do
              {
                text: text,
                meta: {
                  btn: { tag: 'button' }
                }
              }
            end

            it { should have_selector('button.btn.btn-secondary[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should_not have_selector('.btn > i') }
          end

          context 'where icon position is specified' do
            context 'as left' do
              let(:instructions) do
                {
                  text: text,
                  meta: {
                    icon: { position: 'left' }
                  }
                }
              end

              it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
              it { should have_selector('.btn > span', text: text) }
              it { should_not have_selector('.btn > i') }
            end

            context 'as right' do
              let(:instructions) do
                {
                  text: text,
                  meta: {
                    icon: { position: 'right' }
                  }
                }
              end

              it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
              it { should have_selector('.btn > span', text: text) }
              it { should_not have_selector('.btn > i') }
            end
          end

          context 'where btn tag is button and icon position is specified' do
            let(:instructions) do
              {
                text: text,
                meta: {
                  btn: {
                    tag: 'button'
                  },
                  icon: {
                    position: 'left'
                  }
                }
              }
            end

            it { should have_selector('button.btn.btn-secondary[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should_not have_selector('.btn > i') }
          end
        end
      end

      context 'as Stringable' do
        let(:text) { :TEXT }
        let(:instructions) { { text: text } }

        it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
        it { should have_selector('.btn > span', text: text) }
        it { should_not have_selector('.btn > i') }

        context 'and props are passed' do
          let(:instructions) { { text: text, props: { text: { class: 'test', id: 'text' } } } }

          it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
          it { should have_selector('.btn > span.test#text', text: text) }
          it { should_not have_selector('.btn > i') }
        end

        context 'and meta are passed' do
          context 'where btn tag is button' do
            let(:instructions) do
              {
                text: text,
                meta: {
                  btn: { tag: 'button' }
                }
              }
            end

            it { should have_selector('button.btn.btn-secondary[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should_not have_selector('.btn > i') }
          end

          context 'where icon position is specified' do
            context 'as left' do
              let(:instructions) do
                {
                  text: text,
                  meta: {
                    icon: { position: 'left' }
                  }
                }
              end

              it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
              it { should have_selector('.btn > span', text: text) }
              it { should_not have_selector('.btn > i') }
            end

            context 'as right' do
              let(:instructions) do
                {
                  text: text,
                  meta: {
                    icon: { position: 'right' }
                  }
                }
              end

              it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
              it { should have_selector('.btn > span', text: text) }
              it { should_not have_selector('.btn > i') }
            end
          end

          context 'where btn tag is button and icon position is specified' do
            let(:instructions) do
              {
                text: text,
                meta: {
                  btn: {
                    tag: 'button'
                  },
                  icon: {
                    position: 'left'
                  }
                }
              }
            end

            it { should have_selector('button.btn.btn-secondary[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should_not have_selector('.btn > i') }
          end
        end
      end

      context 'as Callable' do
        let(:text) { ->() { 'TEXT' } }
        let(:instructions) { { text: text } }

        it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
        it { should have_selector('.btn > span', text: text.call) }
        it { should_not have_selector('.btn > i') }

        context 'and props are passed' do
          let(:instructions) { { text: text, props: { text: { class: 'test', id: 'text' } } } }

          it { should have_selector('a.btn.btn-secondary[role="button"][href=""]') }
          it { should have_selector('.btn > span.test#text', text: text.call) }
          it { should_not have_selector('.btn > i') }
        end
      end
    end

    context 'when `icon` only is defined' do
      let(:icon) { 'icon' }
      let(:instructions) { { icon: icon } }

      it { expect { subject }.to raise_error('`text` is a required field') }
    end

    context 'when `text` and `icon` are both defined' do
      context 'as Strings' do
        let(:text) { 'TEXT' }
        let(:icon) { 'icon' }
        let(:instructions) { { text: text, icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('.btn > span', text: text) }
        it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1") }

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
          it { should have_selector('.btn > span.test#text', text: text) }
          it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1.test#icon") }
        end

        context 'and meta are passed' do
          context 'where btn tag is button' do
            let(:instructions) do
              {
                text: text, icon: icon,
                meta: {
                  btn: { tag: 'button' }
                }
              }
            end

            it { should have_selector('button.btn.d-flex.justify-content-between.align-items-center[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1") }
          end

          context 'where icon position is specified' do
            context 'as left' do
              let(:instructions) do
                {
                  text: text, icon: icon,
                  meta: {
                    icon: { position: 'left' }
                  }
                }
              end

              it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
              it { should have_selector('.btn > span', text: text) }
              it { should have_selector(".btn > i.fa.fa-#{icon}.mr-1.order-1") }
            end

            context 'as right' do
              let(:instructions) do
                {
                  text: text, icon: icon,
                  meta: {
                    icon: { position: 'right' }
                  }
                }
              end

              it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
              it { should have_selector('.btn > span', text: text) }
              it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1") }
            end
          end

          context 'where btn tag is button and icon position is left' do
            let(:instructions) do
              {
                text: text, icon: icon,
                meta: {
                  btn: {
                    tag: 'button'
                  },
                  icon: {
                    position: 'left'
                  }
                }
              }
            end

            it { should have_selector('button.btn.d-flex.justify-content-between.align-items-center[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should have_selector(".btn > i.fa.fa-#{icon}.mr-1.order-1") }
          end
        end
      end

      context 'as Stringables' do
        let(:text) { 555 }
        let(:icon) { :icon }
        let(:instructions) { { text: text, icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('.btn > span', text: text) }
        it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1") }

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
          it { should have_selector('.btn > span.test#text', text: text) }
          it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1.test#icon") }
        end

        context 'and meta are passed' do
          context 'where btn tag is button' do
            let(:instructions) do
              {
                text: text, icon: icon,
                meta: {
                  btn: { tag: 'button' }
                }
              }
            end

            it { should have_selector('button.btn.d-flex.justify-content-between.align-items-center[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1") }
          end

          context 'where icon position is specified' do
            context 'as left' do
              let(:instructions) do
                {
                  text: text, icon: icon,
                  meta: {
                    icon: { position: 'left' }
                  }
                }
              end

              it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
              it { should have_selector('.btn > span', text: text) }
              it { should have_selector(".btn > i.fa.fa-#{icon}.mr-1.order-1") }
            end

            context 'as right' do
              let(:instructions) do
                {
                  text: text, icon: icon,
                  meta: {
                    icon: { position: 'right' }
                  }
                }
              end

              it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
              it { should have_selector('.btn > span', text: text) }
              it { should have_selector(".btn > i.fa.fa-#{icon}.ml-1") }
            end
          end

          context 'where btn tag is button and icon position is left' do
            let(:instructions) do
              {
                text: text, icon: icon,
                meta: {
                  btn: {
                    tag: 'button'
                  },
                  icon: {
                    position: 'left'
                  }
                }
              }
            end

            it { should have_selector('button.btn.d-flex.justify-content-between.align-items-center[type="button"]') }
            it { should have_selector('.btn > span', text: text) }
            it { should have_selector(".btn > i.fa.fa-#{icon}.mr-1.order-1") }
          end
        end
      end

      context 'as Callables' do
        let(:text) { ->() { 'TEXT' } }
        let(:icon) { ->() { 'icon' } }
        let(:instructions) { { text: text, icon: icon } }

        it { should have_selector('a.btn.d-flex.justify-content-between.align-items-center[role="button"]') }
        it { should have_selector('.btn > span', text: text.call) }
        it { should have_selector(".btn > i.fa.fa-#{icon.call}.ml-1") }

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
          it { should have_selector('.btn > span.test#text', text: text.call) }
          it { should have_selector(".btn > i.fa.fa-#{icon.call}.ml-1.test#icon") }
        end
      end
    end
  end
end
