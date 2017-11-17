require 'rails_helper'

RSpec.describe 'performance of views rendering', type: :view do
  before do
    users = build_list(:user, 1_000)
    User.import(users, validate: false)
    posts = User.all.map { |u| build(:post, user: u) }
    Post.import(posts, validate: false)
  end

  it 'shows performance reports' do
    assign(:users, User.includes(:post))
    Benchmark.ips do |x|
      # x.report('with N+1') do
      #   assign(:users, User.all)
      #   render template: 'erb_partials/show_inline.html.erb'
      # end
      #
      # x.report('without N+1') do
      #   assign(:users, User.includes(:post))
      #   render template: 'erb_partials/show_inline.html.erb'
      # end

      x.report('inline') do
        render template: 'erb_partials/show_inline.html.erb'
      end

      x.report('partial') do
        render template: 'erb_partials/show_partial.html.erb'
      end

      x.report('collection') do
        render template: 'erb_partials/show_collection.html.erb'
      end

      x.compare!
    end
  end

  it 'different template engines' do
    assign(:users, User.includes(:post))
    Benchmark.ips do |x|

      x.report('erb inline') do
        render template: 'erb_partials/show_inline.html.erb'
      end
      x.report('erb partial') do
        render template: 'erb_partials/show_partial.html.erb'
      end
      x.report('erb collection') do
        render template: 'erb_partials/show_collection.html.erb'
      end

      x.report('slim inline') do
        render template: 'slim_partials/show_inline.html.slim'
      end
      x.report('slim partial') do
        render template: 'slim_partials/show_partial.html.slim'
      end
      x.report('slim collection') do
        render template: 'slim_partials/show_collection.html.slim'
      end

      x.report('haml inline') do
        render template: 'haml_partials/show_inline.html.haml'
      end
      x.report('haml partial') do
        render template: 'haml_partials/show_partial.html.haml'
      end
      x.report('haml collection') do
        render template: 'haml_partials/show_collection.html.haml'
      end
      x.compare!
    end
  end
end
