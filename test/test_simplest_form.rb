# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestSimplestForm < Minitest::Test
  def setup
    @single_tags = %w[br hr input img]
    @tags = %w[p div label]
    @src = { src: "path/to/image" }
    @type = { type: "submit", value: "Save" }
    @label = { for: "email" }
  end

  def test_single_tag_without_parms
    assert SimplestForm::Tag.build "br" == "<br>"
    assert SimplestForm::Tag.build "hr" == "<hr>"
    assert SimplestForm::Tag.build "input" == "<input>"
    assert SimplestForm::Tag.build "img" == "<img>"
  end

  def test_single_tag_with_parms
    input_tag_expected = %(<input type="#{@type[:type]}" value="#{@type[:value]}">)
    input_tag = SimplestForm::Tag.build("input", @type)
    assert input_tag == input_tag_expected

    img_tag_expected = %(<img src="#{@src[:src]}">)
    img_tag = SimplestForm::Tag.build("img", @src)
    assert img_tag == img_tag_expected
  end

  def test_tags_without_params
    assert SimplestForm::Tag.build "div" == "<div></div>"
    assert SimplestForm::Tag.build "p" == "<p></p>"
    assert SimplestForm::Tag.build "label" == "<label></label>"
  end

  def test_tags_with_params_with_body
    label_tag_expected = '<label for="email">Email</label>'
    label_tag = SimplestForm::Tag.build("label", @label) { "Email" }
    assert label_tag == label_tag_expected
  end

  def test_empty_form
    user = User.new name: "rob"
    form = SimplestForm.form_for user
    assert form == '<form action="#" method="post"></form>'
  end

  def test_form_with_url
    user = User.new name: "rob"
    url = { url: "/users" }
    form = SimplestForm.form_for user, url
    assert form == '<form action="/users" method="post"></form>'
  end

  def test_form_with_options1
    user = User.new name: "rob", job: "hexlet", gender: "m"
    form = SimplestForm.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end
    form_expected = [
      '<form action="#" method="post">',
      '<input name="name" type="text" value="rob">',
      '<textarea name="job" cols="20" rows="40">hexlet</textarea>',
      "</form>"
    ].join("")
    assert form == form_expected
  end

  def test_form_with_options2
    user = User.new name: "rob", job: "hexlet", gender: "m"
    form = SimplestForm.form_for user do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end
    puts form
    form_expected = [
      '<form action="#" method="post">',
      '<input name="name" type="text" value="rob" class="user-input">',
      '<input name="job" type="text" value="hexlet">',
      '</form>'
    ].join("")
    puts form_expected
    assert form == form_expected
  end
end
