module RoutesHelper
  # rubocop:disable Lint/UnusedMethodArgument
  def rich_resources(*resources, &block)
    options = resources.dup.extract_options!

    resources(*resources) do
      yield if block_given?
      get :delete, on: :member if using_delete?(options)
    end
  end
  # rubocop:enable Lint/UnusedMethodArgument

  def scoped_resources(*resources, &block)
    module_name = resources[0]

    scope module: module_name do
      resources(*resources, &block)
    end
  end

  def scoped_rich_resources(*resources, &block)
    module_name = resources[0]

    scope module: module_name do
      rich_resources(*resources, &block)
    end
  end

  private

  def using_delete?(options)
    if options.key?(:only)
      options[:only].include?(:delete) ? true : false
    elsif options.key?(:except)
      options[:except].include?(:delete) ? false : true
    else
      true
    end
  end
end
