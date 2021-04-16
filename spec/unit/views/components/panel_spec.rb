require "rails_helper"

RSpec.describe ActiveAdmin::Views::Panel do
  # around(:each) do |example|
  #   initial_formated_output_length = RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length
  #   RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = 10_000
  #   example.run
  #   RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = initial_formated_output_length
  # end

  context 'with classic arbre_panel' do
    let(:arbre_panel) do
      render_arbre_component do
        panel 'My Title' do
          header_action link_to("My Link", "https://www.github.com/activeadmin/activeadmin")
          span("Hello World")
        end
      end
    end

    it "has a title h3" do
      expect(arbre_panel.to_s).to eq <<~HTML.chomp
        <div class="panel">
          <h3>
        My Title    <div class="header_action"><a href="https://www.github.com/activeadmin/activeadmin">My Link</a></div>
          </h3>
          <div class="panel_contents">
            <span>Hello World</span>
          </div>
        </div>

      HTML
    end
  end

  context 'with arbre_panel with arbre component' do
    let(:arbre_panel) do
      render_arbre_component do
        panel i(title: 'e') do
          header_action link_to("My Link", "https://www.github.com/activeadmin/activeadmin")
          span("Hello World")
        end
      end
    end

    it "should have a title h3" do
      expect(arbre_panel.to_s).to eq <<~HTML.chomp
        <div class="panel">
          <h3>
          <i title="e"></i>
          </h3>
          <div class="panel_contents">
            <span>Hello World</span>
          </div>
        </div>

      HTML
    end
  end

  context 'with arbre_panel with arbre component' do
    let(:arbre_panel) do
      render_arbre_component do
        panel_link_with_tooltip = safe_join([
          'Panel Title',
          i(
            title: 'This is the tooltip text',
            class: 'ui-icon ui-icon-help panel-tooltip',
            'data-placement': 'bottom',
            'data-controller': 'tooltip',
          )
        ])
        panel panel_link_with_tooltip do
          header_action link_to("My Link", "https://www.github.com/activeadmin/activeadmin")
          span("Hello World")
        end
      end
    end

    it "should have a title h3" do
      expect(arbre_panel.to_s).to eq <<~HTML.chomp
        <div class="panel">
          <h3>
          Panel Title <i title="This is the tooltip text" class="ui-icon ui-icon-help panel-tooltip" data-placement="bottom" data-controller="tooltip" ></i>
          </h3>
          <div class="panel_contents">
            <span>Hello World</span>
          </div>
        </div>

      HTML
    end
  end
end
