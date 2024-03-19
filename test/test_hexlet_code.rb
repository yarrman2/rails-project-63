# frozen_string_literal: true

require 'test_helper'
require_relative './mocks/form_mock'

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestHexletCode < Minitest::Test
  include FormMock
  def setup
    @single_tags = %w[br hr input img]
    @tags = %w[p div label]
    @src = { src: 'path/to/image' }
    @type = { type: 'submit', value: 'Save' }
    @label = { for: 'email' }

    prepare_forms
  end

  def test_single_tag_without_parms
    assert HexletCode::Tag.build 'br' == '<br>'
    assert HexletCode::Tag.build 'hr' == '<hr>'
    assert HexletCode::Tag.build 'input' == '<input>'
    assert HexletCode::Tag.build 'img' == '<img>'
  end

  def test_single_tag_with_parms
    input_tag_expected = %(<input type="#{@type[:type]}" value="#{@type[:value]}">)
    input_tag = HexletCode::Tag.build('input', @type)
    assert input_tag == input_tag_expected

    img_tag_expected = %(<img src="#{@src[:src]}">)
    img_tag = HexletCode::Tag.build('img', @src)
    assert img_tag == img_tag_expected
  end

  def test_tags_without_params
    assert HexletCode::Tag.build 'div' == '<div></div>'
    assert HexletCode::Tag.build 'p' == '<p></p>'
    assert HexletCode::Tag.build 'label' == '<label></label>'
  end

  def test_submit
    assert HexletCode::Tag.build 'submit' == '<input type="submit">'
    inp = HexletCode::Tag.build 'submit', 'Value'
    exp =  '<input type="submit" value="Value">'

    assert inp == exp
  end

  def test_tags_with_params_with_body
    label_tag_expected = '<label for="email">Email</label>'
    label_tag = HexletCode::Tag.build('label', @label) { 'Email' }
    assert label_tag == label_tag_expected
  end

  def test_empty_form
    user = User.new name: 'rob'
    form = HexletCode.form_for user
    assert form == '<form action="#" method="post"></form>'
  end

  def test_form_with_url
    user = User.new name: 'rob'
    url = { url: '/users' }
    form = HexletCode.form_for user, url
    assert form == '<form action="/users" method="post"></form>'
  end

  def test_form_with_options1
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end
    assert form == @form_expected1
  end

  def test_form_with_options2
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    form = HexletCode.form_for user, method: 'get' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end
    assert form == @form_expected2
  end

  def test_input_with_label
    user = User.new name: 'rob', job: 'hexlet'
    form = HexletCode.form_for user do |f|
      f.input :name
    end
    assert form == @form_expected5
  end

  def test_form_with_options3
    user = User.new job: 'hexlet'
    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    assert form == @form_expected3
  end

  def test_form_with_options4
    user = User.new job: 'hexlet'
    form = HexletCode.form_for user, url: '#' do |f|
      f.input :name
      f.input :job
      f.submit 'wow'
    end
    assert form == @form_expected4
  end
end
