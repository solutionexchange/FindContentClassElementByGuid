<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="expires" content="-1"/>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<meta name="copyright" content="2016, Web Site Management" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
	<title>Find Content Class Element By Guid</title>
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<style type="text/css">
		body
		{
			padding: 10px;
		}
	</style>
	<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="rqlconnector/Rqlconnector.js"></script>
	<script type="text/javascript">
		var LoginGuid = '<%= session("loginguid") %>';
		var SessionKey = '<%= session("sessionkey") %>';
		var RqlConnectorObj = new RqlConnector(LoginGuid, SessionKey);
	
		$( document ).ready(function() {
			$('#find-elt').on('click', function(){
				var ElementGuid = $('#elt-guid').val();
				FindElement(ElementGuid.replace(/-/g,'').toUpperCase());
			});
		});
	
		function GotoTreeSegment(sGuid, sType, sParentGuid)
		{
			if(top.opener.parent.frames.ioTreeData){
				// MS 10 or less
				top.opener.parent.frames.ioTreeData.document.location = '../../ioRDLevel1.asp?Action=GotoTreeSegment&Guid=' + sGuid + '&Type=' + sType + "&ParentGuid=" + sParentGuid + '&CalledFromRedDot=0';
			} else {
				// MS 11
				top.opener.parent.parent.parent.ioTreeIFrame.frames.ioTreeFrames.frames.ioTree.GotoTreeSegment(sGuid, sType, sParentGuid);
			}
		}
		
		function FindElement(ElementGuid)
		{
			ElementGuid = $.trim(ElementGuid);
			if(ElementGuid == '')
			{
				return;
			}
		
			//load simple page info
			var strRQLXML = '<TEMPLATE><ELEMENT action="load" guid="' + ElementGuid + '"/></TEMPLATE>';
			RqlConnectorObj.SendRql(strRQLXML, false, function(data){
				objElement = TranslateElementType($(data).find('ELEMENT').attr('elttype'));
				GotoTreeSegment(ElementGuid, objElement.type, objElement.parentGuid);
			});
		}
		
		function TranslateElementType(ElementType)
		{
			var elttype = [];
			// Content Elements		6D31DBA0C088423C810C378CD2688CD4
				elttype[1] 		= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - Text
				elttype[5] 		= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - Date
				elttype[39]		= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - Time
				elttype[62]		= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - Date and Time
				elttype[48]		= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - Numeric
				elttype[999] 	= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - User defined
				elttype[50] 	= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - e-mail
				elttype[51]		= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field - URL
				elttype[1000]	= { type:"project.4156", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Standard Field
				elttype[31]		= { type:"project.4157", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Text ASCI
				elttype[32]		= { type:"project.4157", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Text HTML
				elttype[60]		= { type:"project.4160", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Transfer
				elttype[1005] 	= { type:"project.CommonContentElement", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Common Content Element
				elttype[1007]	= { type:"project.GenericElement", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Generic Element
				elttype[10] 	= { type:"", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Content of Project 
				elttype[8] 		= { type:"project.4155", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Option list
				elttype[38]		= { type:"project.4154", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Media 
				elttype[25]		= { type:"project.4152", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // List entry
				elttype[2] 		= { type:"project.4148", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Image
				elttype[12] 	= { type:"project.4159", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Headline 
				elttype[52] 	= { type:"project.4154", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // eDocs DM Media Element 
				elttype[1004]	= { type:"project.TE24", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Delivery Server constraint 
				elttype[1006]	= { type:"", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Delivery Server
				elttype[14]		= { type:"project.4146", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Database Content 
				elttype[19] 	= { type:"project.4143", parentGuid:"6D31DBA0C088423C810C378CD2688CD4" }; // Background
			// Structure Elements	3D98D6DDE2D04A93A02F35444A09F023
				elttype[26]		= { type:"project.4141", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Anchor as text
				elttype[27]		= { type:"project.4141", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Anchor as image
				elttype[2627]	= { type:"project.4141", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Anchor
				elttype[15]		= { type:"project.4142", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Area
				elttype[23]		= { type:"project.4144", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Browse
				elttype[28]		= { type:"project.4145", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Container
				elttype[3] 		= { type:"project.4147", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Frame
				elttype[13]		= { type:"project.4151", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // List
				elttype[99]		= { type:"project.4168", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Site map
				elttype[24]		= { type:"project.4158", parentGuid:"3D98D6DDE2D04A93A02F35444A09F023" }; // Hit list
			// Meta Elements		3C7D0075221E49D489D8C85F0087822C
				elttype[1003]	= { type:"project.4165", parentGuid:"3C7D0075221E49D489D8C85F0087822C" }; // Attribute
				elttype[1002]	= { type:"project.4149", parentGuid:"3C7D0075221E49D489D8C85F0087822C" }; // Info
			return elttype[ElementType];
		}
	</script>
</head>
<body>
	<div id="processing" class="modal hide fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<h3 id="myModalLabel">Processing</h3>
		</div>
		<div class="modal-body">
			<p>Please wait...</p>
		</div>
	</div>
	<div class="container">
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<span class="brand">Find Content Class Element By Guid</span>
			</div>
		</div>
		<div class="well">
			<div class="form-horizontal">
				<div class="control-group">
					<label class="control-label" for="inputEmail">Content Class Element Guid</label>
					<div class="controls">
						<input class="input-block-level" id="elt-guid" type="text" placeholder="Content Class Element Guid" autofocus>
					</div>
				</div>
				<div class="controls">
					<button class="btn btn-success" id="find-elt" type="button">Goto</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>