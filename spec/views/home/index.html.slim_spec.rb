# frozen_string_literal: true

RSpec.describe 'home/index.html.slim', type: :view do
  it 'renders default' do
    render
    expect(rendered).to have_selector 'section.hero.is-primary .hero-body .container', count: 1
  end
end
