# frozen_string_literal: true

# form mocks
module FormMock
  def prepare_forms
    prepare_form1
    prepare_form2
    prepare_form3
    prepare_form4
    prepare_form5
  end

  def prepare_form3
    @form_expected3 = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input type="text" name="name" value="">',
      '<label for="job">Job</label>',
      '<input type="text" name="job" value="hexlet">',
      '<input type="submit" value="Save">',
      '</form>'
    ].join
  end

  def prepare_form4
    @form_expected4 = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input type="text" name="name" value="">',
      '<label for="job">Job</label>',
      '<input type="text" name="job" value="hexlet">',
      '<input type="submit" value="Wow">',
      '</form>'
    ].join
  end

  def prepare_form5
    @form_expected5 = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input type="text" name="name" value="rob">',
      '</form>'
    ].join
  end

  def prepare_form1
    @form_expected1 = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input type="text" name="name" value="rob">',
      '<label for="job">Job</label>',
      '<textarea name="job" cols="20" rows="40">hexlet</textarea>',
      '</form>'
    ].join
  end

  def prepare_form2
    @form_expected2 = [
      '<form action="#" method="get">',
      '<label for="name">Name</label>',
      '<input type="text" name="name" class="user-input" value="rob">',
      '<label for="job">Job</label>',
      '<input type="text" name="job" value="hexlet">',
      '</form>'
    ].join
  end
end
