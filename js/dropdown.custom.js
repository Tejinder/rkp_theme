
var CustomDropDown = {
    init: function(submenu, target) {
        $j(target).click(function()
        {
            var X=$j(this).attr('id');
            if(X==1)
            {
                $j(submenu).hide();
                $j(this).attr('id', '0');
            }
            else
            {
                $j(submenu).show();
                $j(this).attr('id', '1');
            }

        });


        $j(target).mouseup(function()
        {
            $j(".submenu").each(function(idx) {
                if($j(submenu).attr('id') !== $j(this).attr('id')) {
                    $j(this).hide();
                }
            });
        });

//        //Mouse click on sub menu
//        $j(submenu).mouseup(function()
//        {
//            return false;
//        });
//
//        //Mouse click on my account link
//        $j(target).mouseup(function()
//        {
//            return false;
//        });


//        //Document Click
        $j(document).mouseup(function()
        {
            $j(submenu).hide();
            $j(target).attr('id', '');
        });
    }
};
