<head>
    <script type="text/javascript" src="<@s.url value='/dwr/engine.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/DocumentCartService.js'/>" ></script>
	
		<!-- DWR token code written for Synchro jive 8 calls-->
	<#assign jive_token = jiveContext.getSpringBean("jiveXHRTokenValidator").generateXHRtoken(user) />		

	<script>
		
		dwr.engine.setHeaders({
		  "Content-Type":"text/plain",
		  "X-J-Token":"${jive_token}"
		});    
	</script>
    <script language="javascript">
        function addToCart() {
            DocumentCartService.addToCart("1014","attachment","Hello Blue World","1287");
        }

        function removeFromCart(cartID) {
            DocumentCartService.removeFromCart(cartID,function(response){ cartRemoveDWRResponse(response,cartID); });
            /*$j('#cart-remove-'+cartID).hide();
            $j('#cart-undo-'+cartID).show();*/
        }

        function undoFromCart(cartID) {
            DocumentCartService.undoFromCart(cartID,function(response){ cartUndoDWRResponse(response,cartID); } );
        }

        function clearCart() {
            DocumentCartService.clearCart( function(response) { window.location.reload();} );
        }

        function hasDownloadCompleted(){
            $j('#download-cart').hide();
            $j('#download-inProgress').show();
            $j('#loaderDiv').show();
            var i = setInterval(function(){
                DocumentCartService.hasDownloadCompleted(function(response) {
                    var success = response.indexOf("Successfully");
                    if( success == 0 ) {
                        $j('#download-inProgress').hide();
                        $j('#loaderDiv').hide();
                        $j('#download-cart').show();
                        clearInterval(i);
                    }
                });
            },2000)
        }

        function unCheckAttachment() {
            DocumentCartService.uncheckFromCart("1014","attachment","1287");
        }

        function unCheckPDF() {
            DocumentCartService.uncheckFromCart("1015","pdf");
        }



        function cartRemoveDWRResponse(response,cartID) {
            updateCartItemsCount();
            var success = response.indexOf("Successfully");

            if( success == 0 ) {
                $j('#grail-info-box').css("background-color", "#e5fac0");
                $j('#grail-info-box').css("border","1px solid #abda5a");
            }
            $j('#grail-info-box').show();
            $j('#cart-dwr-msg').show();
            $j('#cart-dwr-msg').html(response);


            if(  success == 0 ) {
                $j('#grail-info-box').fadeOut(1500,'linear');
                $j('#cart-remove-'+cartID).hide();
                $j('#cart-undo-'+cartID).show();
            }else {
                $j('#grail-info-box').fadeOut(8000,'linear');
            }

        }

        function cartUndoDWRResponse(response,cartID) {
            updateCartItemsCount();
            var success = response.indexOf("Successfully");
            var limit = response.indexOf("limit");

            if( success == 0 ) {
                $j('#grail-info-box').css("background-color", "#e5fac0");
                $j('#grail-info-box').css("border","1px solid #abda5a");
            }

            if( limit > 0 ) {
                $j('#grail-info-box').css("background-color", "#f4c2c2");
                $j('#grail-info-box').css("border","1px solid #df6363");
            }

            $j('#grail-info-box').show();
            $j('#cart-dwr-msg').show();
            $j('#cart-dwr-msg').html(response);
            if( success == 0 ) {
                $j('#cart-undo-'+cartID).hide();
                $j('#cart-remove-'+cartID).show();
                $j('#grail-info-box').fadeOut(1500,'linear');

            } else {
                //$j('#grail-info-box').fadeOut(8000,'linear');
            }


        }

        function cartDWRResponse(response,meta) {
            console.log('Reponse : ',response)
            updateCartItemsCount();
            var success = response.indexOf("Successfully");
            var completely = response.indexOf("Completely");
            var limit = response.indexOf("limit");

            if( success == 0 || completely == 0) {
                $j('#grail-info-box').css("background-color", "#e5fac0");
                $j('#grail-info-box').css("border","1px solid #abda5a");
            }



            if( limit > 0 ) {
                console.log('Limit exceeded.....');
                $j('#grail-info-box').css("background-color", "#f4c2c2");
                $j('#grail-info-box').css("border","1px solid #df6363");
            }
                $j('#grail-info-box').show();
                $j('#cart-dwr-msg').show();
                $j('#cart-dwr-msg').html(response);
                if( success == 0 || completely == 0) {
                    $j('#grail-info-box').fadeOut(1500,'linear');
                } else if( limit < 0) {
                    $j('#grail-info-box').fadeOut(4000,'linear');
                }


            if(  limit > 0 ) {
                meta.checked=false;
            }
        }

        function addGrailAttachCheck(jiveDoc){
            alert('   '+jiveDoc);

        }

        function addAttachCheck(docID,type,title,attachmentID,meta){
            if(meta.checked)
            {
                //alert("  attachment selection     "+docID + " "+ type + title +attachmentID);
                //   DocumentCartService.addToCart(docID,type,title,attachmentID, cartDWRResponse );
                DocumentCartService.addToCart(docID,type,title,attachmentID, function(response){ cartDWRResponse(response,meta); } );
            } else {
                //alert(" Removing the attachment from the cart. ");
                DocumentCartService.uncheckFromCart(docID, type, attachmentID, function(response){ cartDWRResponse(response,meta); });
            }
        }

        function addContentPDF(docID,type,title,meta) {
           console.log("addContentPDF added --");
		   if(meta.checked)
            {
                //alert("  content selection     "+docID + "   "+ type + title );
                DocumentCartService.addToCart(docID,type,title,'',function(response){ cartDWRResponse(response,meta); });
            } else {
                //alert(" Removing the content from the cart. ");
                DocumentCartService.uncheckFromCart(docID, type,'',function(response){ cartDWRResponse(response,meta); });
            }
        }

        function addContentAndAttachments(docID,title,meta) {
            if(meta.checked)
            {
                // alert("  content selection     "+docID + "   "+ type + title );
                DocumentCartService.addContentAndAttachmentsToCart(docID,title,'',function(response){ cartDWRResponse(response,meta); });
            } else {
                //alert(" Removing the content from the cart. ");
                DocumentCartService.uncheckContentAndAttachmentsFromCart(docID, '',function(response){ cartDWRResponse(response,meta); });
            }
        }

        function updateCartItemsCount(){
		 console.log(" calling updateCartItemsCount--");
            DocumentCartService.getCartItemsCount(function(response){
                document.getElementById('view-grail-cart').innerHTML  = '<a id="view-grail-cart" href="<@s.url action="view-cart"/>"><span class="icon icon_view_cart"></span>View Cart ('+response+')</a>';
            } );
        }
		
    </script>
</head>