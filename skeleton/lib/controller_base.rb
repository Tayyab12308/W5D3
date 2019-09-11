require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'
require 'byebug'

class ControllerBase
  attr_reader :req, :res, :params
  attr_writer :already_built_response

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response ||= false
  end

  # Set the response status code and header
  def redirect_to(url)
    raise if already_built_response?
    unless already_built_response?
      res.location = url
      res.status = 302
      self.already_built_response = true
    end
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise if already_built_response? 
    unless already_built_response?
      res['Content-Type'] = content_type
      res.body = [content]
      self.already_built_response = true
    end
  end
  

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    raise if already_built_response?
    unless already_built_response?
      path = File.dirname("views/#{"#{self.class}".underscore}/#{template_name.to_s}.html.erb")
      content = File.read("#{path}/#{template_name}.html.erb")
      template = ERB.new(content)
      body = template.result(binding)
      render_content( body, 'text/html' )
    end
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)

  end
end

