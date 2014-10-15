$(function(){
    $('body').on('click', '.texter-edit', function(){
        EditText($(this));
    });

    function EditText(elem){

        function removePopup(){
            popup.fadeOut('fast', function(){
                popup.remove();
            });
            $(window).off('keyup');
        }

        $('body').append('<div id="texter-popup"><span class="close"><svg viewBox="0 0 22 22"><path fill="#ccc" d="M12,2C6.5,2,2,6.5,2,12s4.5,10,10,10c5.5,0,10-4.5,10-10S17.5,2,12,2z M17,15.6L15.6,17L12,13.4L8.4,17L7,15.6l3.6-3.6L7,8.4L8.4,7l3.6,3.6L15.6,7L17,8.4L13.4,12L17,15.6z"></path></svg></span><div id="texter-form"></div></div>');
        var popup = $('#texter-popup');
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
