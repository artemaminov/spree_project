$( document ).ready(function() {
    $('#user_user_type').change(function(){
        var value =$(this).val();
        var entityFields = $('#entity_fields');

        if(value == 'entity_user'){
            entityFields.fadeIn();
        } else {
            entityFields.fadeOut();
        }
    });
});
