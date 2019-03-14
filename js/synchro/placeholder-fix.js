//Assign to those input elements that have 'placeholder' attribute
$j(document).ready(function(){
    if(!$j.support.placeholder) {
        $j('input[type=text], textarea').each(function(){
            var input = $j(this);
            $j(input).val(input.attr('placeholder'));

            $j(input).focus(function(){
                if (input.val() == input.attr('placeholder')) {
                    input.val('');
                }
            });

            $j(input).blur(function(){
                if (input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.val(input.attr('placeholder'));
                }
            });
        });
    }
})