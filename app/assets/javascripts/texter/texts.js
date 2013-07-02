$(function(){
    $('body').on('click', '.js-edit', function(){
        EditText($(this));
    });

    function EditText(elem){

        function removePopup(){
            popup.fadeOut('fast', function(){
                popup.remove();
            });
            $(window).off('keyup');
        }

        $('body').append('<div id="popup"><span class="close"></span><div id="form"></div></div>');
        var popup = $('#popup');
        $(window).on('keyup', function(e){
            if(e.keyCode == 27){
                removePopup();
            }
        });

        popup.on('click', '.close', function(){
            removePopup();
        });

        $.get(elem.data('url'), function(){
            popup.fadeIn('fast', function(){
                popup.find('textarea:first').focus();
            });
        });
    }
});
