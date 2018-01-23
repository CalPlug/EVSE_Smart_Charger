<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:template match="/">
    <html>
    <head>
     <style>
      body { font-family:arial; font-size:10pt; text-align:left; }
      h1, h2 {
          padding-top: 30px;
      }
      h3 {
          padding-top: 20px;
      }
      h4, h5, h6 {
          padding-top: 10px;
          font-size:12pt;
      }
      table {
          font-family:arial; font-size:10pt; text-align:left;
          border-color:#B0B0B0;
          border-style:solid;
          border-width:1px;
          border-collapse:collapse;
      }
      table th, table td {
          font-family:arial; font-size:10pt; text-align:left;
          border-color:#B0B0B0;
          border-style:solid;
          border-width:1px;
          padding: 4px;
      }
	  div.report
            {
            width: 1000px;
            margin: auto;
            text-align: left

            color:#003399;
            background-color: white;

            padding-top: 30px;
            padding-bottom: 30px;
            padding-left:30px;
            padding-right:30px;
            }
	  div.header{
            padding-top: 7px;
            padding-bottom: 7px;
            color:#003399;
            background-color: #D0D0D0;
            width=100%;
            font-family:arial;
            font-size:14pt;
            font-weight: bold;
            text-align: center;
	 }
      div.title{
            padding-top: 30px;
            margin: auto;
            color:#D0D0D0;
            background-color:#003399 ;

            text-align: center;
            width: 1000px;
            padding-left:30px;
            padding-right:30px;
	  }
	  div.content{
            padding-top: 10px;
            padding-left:10px;
            padding-right:10px;

            text-align: left;
            font-size: 13pt;
            font-weight: normal;
      }
	  div.copyright{
            text-align:right;
            font-size:9pt;
            font-style:italic;
            font-weight:normal;
 	  }
	  div.links{
            text-align:left;
      }
	  table.sect1{
            border-color: #B0B0B0;
            border-style:solid;
            border-width:1px;
            border-spacing:0px;
            border-collapse:collapse;
            width=75%;
            font-family:couriernew;
            font-size: 11pt;
            }
	  table.sect1 th
            {
            border-color: #B0B0B0;
            border-width:1px;
            color: darkslategray;
            font-weight:bold;
			text-align:center;
            }


	  table.sect1 td
            {
            text-align:center;
            }
	  div.label
			{ 
			padding-top: 10px;
            padding-left:10px;
            padding-right:10px;

            text-align: left;
            font-size: 13pt;
            font-weight: bold;
            }
	 div.sublabel
			{ 
			padding-top: 10px;
            padding-left:10px;
            padding-right:10px;

            text-align: left;
            font-size: 11pt;
            font-weight: normal;
            }
	  table.sect2{
            border-color: #B0B0B0;
            border-style:solid;
            border-width:1px;
            border-spacing:0px;
            border-collapse:collapse;
            width=75%;
            font-family:couriernew;
            font-size: 11pt;
            }
	  table.sect2 th
            {
            border-color: #B0B0B0;
            border-width:1px;
            color: darkslategray;
            font-weight:bold;
			text-align:center;
            }


	  table.sect2 td
            {
            text-align:center;
            }
     </style>
    </head>
    <body>
		<a name="top"/>
        <div>
            <xsl:apply-templates select="/doc/title"/>
        </div>
		<div class="report">
			<div>
				<div class="header">Table of Contents</div>
				<div class="content" >
                    <a href="#sect1">Device Selection</a>
					<br/>
					<a href="#sect2">User Configuration</a>
					<br/>
					<a href="#sect3">Rules</a>
					<br/>
					<a href="#sect4">To Do</a>
					<br/>
					<a href="#sect5">Top Level Ports</a>
					<br/>
				</div>
			</div>
			<div>
				<p>
					<a name="sect1"/>
					<div class="header">Device Selection</div>
				</p>
				<xsl:call-template name="sect1"/>
			</div>
			<div>
				<p>
					<a name="sect2"/>
					<div class="header">User Configuration</div>
				</p>
				<xsl:call-template name="sect2"/>
			</div>
			<div>
				<p>
					<a name="sect3"/>
					<div class="header">Rules</div>
				</p>
				<xsl:call-template name="sect3"/>
			</div>
			<div>
				<p>
					<a name="sect4"/>
					<div class="header">To Do</div>
				</p>
				<xsl:call-template name="sect4"/>
			</div>
			<div>
				<p>
					<a name="sect5"/>
					<div class="header">Top Level Ports</div>
				</p>
				<xsl:call-template name="sect5"/>
			</div>
		</div>
	</body>
	</html>
</xsl:template>

<xsl:template name="top-link">
        <a href="#top">top of page</a>
</xsl:template>

<xsl:template name="parsetable">
	<xsl:for-each select="header">
		<tr>
			<xsl:for-each select="cell">
				<th> <xsl:value-of select="."/></th>
			</xsl:for-each>
		</tr>
	</xsl:for-each>
	<xsl:for-each select="row">
		<tr>
			<xsl:for-each select="cell">
				<td> <xsl:value-of select="."/></td>
			</xsl:for-each>
		</tr>
	</xsl:for-each>
</xsl:template>

<xsl:template name="sect1">
	<xsl:for-each select="doc/ds">
		<xsl:for-each select="table">
		<table class="sect1"  align="center"  border="1" width="75%" cellspacing="0" cellpadding="4">
			<xsl:call-template name="parsetable"/>
		</table>
		</xsl:for-each>
	</xsl:for-each>
	<xsl:call-template name="top-link"/>
</xsl:template>


<xsl:template name="sect2">
	<xsl:for-each select="doc/uc">
		<xsl:for-each select="data">
			<div class= "label"><xsl:value-of select="name"/></div>
			<xsl:for-each select="table">
				<table class="sect2" >
					<xsl:call-template name="parsetable"/>
				</table>
			</xsl:for-each>
			<xsl:for-each select="cdata">
				<div class= "sublabel"><xsl:value-of select="name"/></div>
				<xsl:for-each select="table">
					<table class="sect2"  >
						<xsl:call-template name="parsetable"/>
					</table>
				</xsl:for-each>
			</xsl:for-each>
			<br/>
		</xsl:for-each>
	</xsl:for-each>
	<xsl:call-template name="top-link"/>
</xsl:template>

<xsl:template name="sect3">
	<xsl:for-each select="doc/Rules">
		<xsl:for-each select="data">
			<xsl:for-each select = "text">
				<xsl:value-of select="."/>
				<br/>
			</xsl:for-each >
			<br/>
			<xsl:for-each select="table">
			<table class="sect4"  align="center"  border="1" width="75%" cellspacing="0" cellpadding="4">
				<xsl:call-template name="parsetable"/>
			</table>
			</xsl:for-each>					
		</xsl:for-each>
		<br/>
	</xsl:for-each >
	<xsl:call-template name="top-link"/>
</xsl:template>

<xsl:template name="sect4">
	<xsl:for-each select="doc/Next">
		<xsl:for-each select="data">
			<xsl:for-each select = "text">
				<xsl:value-of select="."/>
				<br/>
			</xsl:for-each >
			<br/>			
			<xsl:for-each select="table">
			<table class="sect4"  align="center"  border="1" width="75%" cellspacing="0" cellpadding="4">
				<xsl:call-template name="parsetable"/>
			</table>
			</xsl:for-each>				
		</xsl:for-each>	
		<br/>
	</xsl:for-each >
	<xsl:call-template name="top-link"/>
</xsl:template>

<xsl:template name="sect5">
	<xsl:for-each select="doc/toplevelport">
		<xsl:for-each select="data">
			<xsl:for-each select="table">
				<table class="sect2" align ="center" >
					<xsl:call-template name="parsetable"/>
				</table>
			</xsl:for-each>
			<br/>
		</xsl:for-each>
		<br/>
	</xsl:for-each >
	<xsl:call-template name="top-link"/>
</xsl:template>

<xsl:template match="/doc/title">
    <h1 align="center"> <xsl:apply-templates/> </h1> 
</xsl:template>

</xsl:stylesheet>
