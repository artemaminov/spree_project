$(document).on('turbolinks:load', function() {
    var email = new RegExp("[a-zA-Z0-9.!#$%&amp;’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+");


    $('#checkbox_entity_user, #checkbox_private_user').on('change', function() {
        var id = $(this).prop('id');
        var checked = $(this).prop('checked');

        if(id == 'checkbox_private_user' && checked ) {
            $(this).prop('checked', true);
            $('b#private_user').show();
            $('b#entity_user').hide();
            $('#checkbox_entity_user').prop('checked', false);
            $('#entity_user_form').hide();
            $('#private_user_form').fadeIn();
            return;
        } else {
            if(id == 'checkbox_entity_user' && checked){
                $(this).prop('checked', true);
                $('b#private_user').hide();
                $('b#entity_user').show();
                $('#checkbox_private_user').prop('checked', false);
                $('#private_user_form').hide();
                $('#entity_user_form').fadeIn();
                return;
            }
        }

        if(!checked && id == 'checkbox_private_user' && $('#checkbox_entity_user').prop('checked') == false){
            $('#checkbox_private_user').prop('checked', true);
        } else {
            if(!checked && id == 'checkbox_entity_user' && $('#checkbox_private_user').prop('checked') == false){
                $('#checkbox_entity_user').prop('checked', true);

            }
        }
    });


    toggleAttributes = function toggleAttributes(element, toggle){
        if(toggle){
            $(element)
                .removeClass("error")
                .addClass("success");
        } else {
            $(element)
                .removeClass("success")
                .addClass("error");
        }
    };


    function checkField(element, value, length, minLength, maxLength, required, type){
        if (required) {
            if (value != ''){

                if(type == 'email'){
                    if(!email.test(value)){
                        toggleAttributes($(element), false);
                        return true;
                    }
                }

                if(minLength != 0) {
                    if(value.length < minLength) {
                        toggleAttributes($(element), false);
                        return true;
                    }
                }

                if(maxLength != 0) {
                    if(value.length > maxLength) {
                        toggleAttributes($(element), false);
                        return true;
                    }
                }

                if (length > 0) {
                    if(value.length >= length) {
                        toggleAttributes($(element), true);
                    } else {
                        toggleAttributes($(element), false);
                    }
                } else {
                    toggleAttributes($(element), true);
                }

            } else {
                toggleAttributes($(element), false);
            }
        }

        return false;
    }

    $('#private_user_form .input, #entity_user_form .input').on('input', function() {
        $form = $(this).parents().closest('form');

        var length = parseInt($(this).data('length'), 10);
        var minLength = parseInt($(this).data('min-length'), 10);
        var maxLength = parseInt($(this).data('max-length'), 10);
        var required = $(this).hasClass('required');
        var numeric = $(this).hasClass('numeric');
        var type = $(this).prop('type');

        if(numeric) {
            this.value = this.value.replace(/\D/g, '');

            if (length > 0 && this.value.length > length) {
                this.value = this.value.slice(0, length);
            }

            if(maxLength > 0 && this.value.length > maxLength) {
                this.value = this.value.slice(0, maxLength);
            }
        }

        var value = $(this).val();
        var needReturn = checkField($(this), value, length, minLength, maxLength, required, type);
        if (needReturn){
            return;
        }

        if($form.find('input.input.required').length == $form.find('input.success').length) {
            var password = $form.find('.password input');
            var passwordConfirmation = $form.find('.password_confirmation input');

            if(password.val() != passwordConfirmation.val()){
                 toggleAttributes(password, false);
                 toggleAttributes(passwordConfirmation, false);
                $form.find('#passwords_error').fadeIn();
                return
            } else {
                $form.find('#passwords_error').fadeOut();
            }

            if($form.prop('id') =='entity_spree_user_form' && !$('#entity_user_form_terms').prop('checked')) {
                return;
            }
            $form.find('input.submit')
                .removeClass("disabled")
                .removeAttr("disabled");
        }
    });

    $('#entity_user_form_terms').on('change', function(){
        var checked = $(this).prop('checked');
        $form = $(this).parents().closest('form');
        if(checked){
            if($form.find('input.input.required').length == $form.find('input.success').length) {
                $form.find('input.submit')
                    .removeClass("disabled")
                    .removeAttr("disabled");
            }
        } else {
            $form.find('input.submit')
                .addClass("disabled")
                .attr("disabled");
        }

    });

    $('#checkbox_organization, #checkbox_individual').on('change', function() {
        var id = $(this).prop('id');
        var checked = $(this).prop('checked');

        if(id == 'checkbox_individual' && checked ) {
            $(this).prop('checked', true);
            $('#spree_user_user_organization_type').prop('value', 'individual');
            $('#checkbox_organization').prop('checked', false);
            return;
        } else {
            if(id == 'checkbox_organization' && checked){
                $(this).prop('checked', true);
                $('#spree_user_user_organization_type').prop('value', 'organization');
                $('#checkbox_individual').prop('checked', false);
                return;
            }
        }

        if(!checked && id == 'checkbox_individual' && $('#checkbox_organization').prop('checked') == false){
            $('#checkbox_individual').prop('checked', true);
        } else {
            if(!checked && id == 'checkbox_organization' && $('#checkbox_individual').prop('checked') == false){
                $('#checkbox_organization').prop('checked', true);

            }
        }
    });



    $('#private_user_form .password input, #private_user_form .password_confirmation input,' +
      ' #entity_user_form .password input, #entity_user_form .password_confirmation input').focusout(function(){
        $form = $(this).parents().closest('form');

        var password = $form.find('.password input');
        var passwordConfirmation = $form.find('.password_confirmation input');

        if(password.val() != passwordConfirmation.val()){
            toggleAttributes(password, false);
            toggleAttributes(passwordConfirmation, false);
            $form.find('#passwords_error').fadeIn();
            return
        } else {
            toggleAttributes(password, true);
            toggleAttributes(passwordConfirmation, true);
            $form.find('#passwords_error').fadeOut();
        }
    });
});