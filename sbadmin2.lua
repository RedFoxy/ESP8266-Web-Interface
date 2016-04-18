	</div>
  </div>
<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/metisMenu/2.5.0/metisMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/startbootstrap-sb-admin-2/1.0.8/js/sb-admin-2.min.js"></script>
<script>
$(document).ready(function()
{
	$(".gpio button").click(function(event) {
		event.preventDefault();
		var a=$(this).attr('act'), i=$(this).attr('id')
		console.log("Azione: "+a+" - ID: "+i)
		if (a!='' && i>0) {
			$.ajax({
				type: "get",
				url: "/"+a,
				dataType:"json",
				data: {id: i},
				success: function (r) {
					if(r.status === "success") {
						if (r.value==1) {
							$('.gpio #p'+i).css('background-color', 'green');
						} else {
							$('.gpio #p'+i).css('background-color', 'silver');
						}
					} else if(r.status === "error") {
						console.log('error')
						console.log('Messaggio: '+r.msg)
					}
				}
			})
		}
		return false;
	});
});
</script>
</body>
</html>
