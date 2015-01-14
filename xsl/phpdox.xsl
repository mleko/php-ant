<?xml version="1.0" encoding="utf-8" ?>
<!--  This is a skeleton phpDox config file - Check http://phpDox.de for latest version and more info -->
<phpdox xmlns="http://xml.phpdox.net/config" silent="false" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--  @silent: true | false to enable or disable visual output of progress -->

	<!-- Additional bootstrap files to load for additional parsers and/or engines -->
	<!-- Place as many require nodes as you feel like in this container -->
	<!-- syntax: <require file="/path/to/file.php" /> -->
	<bootstrap/>

	<!-- A phpDox project to process, you can have multiple projects in one config file -->
	<project>
		<!--  @name    - The name of the project -->
		<xsl:attribute name="name">
			<xsl:value-of select="/properties/property[@name='config.quality.phpdox.project']/@value"/>
		</xsl:attribute>
		<!--  @source  - The source directory of the application to process -->
		<xsl:attribute name="source">
			<xsl:value-of select="/properties/property[@name='config.quality.src.dir']/@value"/>
		</xsl:attribute>
		<!--  @workdir - The directory to store the xml data files in -->
		<xsl:attribute name="workdir">
			<xsl:value-of select="/properties/property[@name='config.quality.phpdox.workdir']/@value"/>
		</xsl:attribute>

		<!--  A phpDox config file can define additional variables (properties) per project -->
		<!--  <property name="some.name" value="the.value" /> -->

		<!--  Values can make use of previously defined properties -->
		<!--  The following are defined by default:

				${basedir}                Directory the loaded config file is in

				${phpDox.home}            Directory of the phpDox installation
				${phpDox.file}            The current config file
				${phpDox.version}         phpDox' version number

				${phpDox.project.name}    The value of project/@name if set, otherwise 'unnamed'
				${phpDox.project.source}  The value of project/@source if set, otherwise '${basedir}/src'
				${phpDox.project.workdir} The value of project/@workdir if set, otherwise '${basedir}/build/phpdox/xml'

				${phpDox.php.version}     The PHP Version of the interpreter in use

		 -->

		<!--  Additional configuration for the collecting process (parse of php code, generation of xml data) -->
		<collector publiconly="false" backend="parser">
			<!--  @publiconly - Flag to disable/enable processing of non public methods and members -->
			<!--  @backend    - The collector backend to use, currently only shipping with 'parser' -->

			<!--  <include / exclude filter for filelist generator, mask must follow fnmatch() requirements  -->
			<include mask="*.php"/>
			<exclude mask=""/>

			<!--  How to handle inheritance -->
			<inheritance resolve="true">
				<!--  @resolve - Flag to enable/disable resolving of inheritance -->

				<!--  You can define multiple (external) dependencies to be included -->
				<!--  <dependency  path="" -->
				<!--    @path  - path to a directory containing an index.xml for a dependency project -->
			</inheritance>

		</collector>

		<!--  Configuration of generation process -->
		<generator>
			<!-- @output - (Base-)Directory to store output data in -->
			<xsl:attribute name="output">
				<xsl:value-of select="/properties/property[@name='config.quality.phpdox.outdir']/@value"/>
			</xsl:attribute>

			<!-- A generation process consists of one or more build tasks and of (optional) enrich sources -->

			<enrich>
				<!-- @base - (Base-)Directory of datafiles used for enrich process -->
				<xsl:attribute name="base">
					<xsl:value-of select="/properties/property[@name='config.quality.phpdox.outdir']/@value"/>
				</xsl:attribute>

				<!-- add build information - this should always be enabled -->
				<source type="build"/>

				<!-- add phploc output -->
				<xsl:if test="/properties/property[@name='quality.phploc.exists']">
					<source type="phploc">
						<file name="phploc/phploc.xml"/>
					</source>
				</xsl:if>
				<!-- <source type="phploc" /> -->

				<!-- add git vcs information -->

				<source type="git">
					<git binary="/usr/bin/git"/>
					<history enabled="true" limit="15">
						<xsl:attribute name="cache">
							<xsl:value-of select="concat(/properties/property[@name='config.quality.phpdox.workdir']/@value, '/gitlog.xml')"/>
						</xsl:attribute>
					</history>
				</source>

				<!-- add codeception(phpunit) output -->
				<!--<xsl:if test="/properties/property[@name='test.codeception.exists']">-->
					<!--<source type="clover">-->
						<!--<file>-->
							<!--<xsl:attribute name="path">-->
								<!--<xsl:value-of select="concat(/properties/property[@name='test.codeception.output.dir']/@value, '/coverage.xml')"/>-->
							<!--</xsl:attribute>-->
						<!--</file>-->
					<!--</source>-->
					<!--<source type="phpunit">-->
						<!--<file>-->
							<!--<xsl:attribute name="name">-->
								<!--<xsl:value-of select="concat(/properties/property[@name='test.codeception.output.dir']/@value, '/unit.xml')"/>-->
							<!--</xsl:attribute>-->
						<!--</file>-->
					<!--</source>-->
				<!--</xsl:if>-->


				<!-- enrichment source -->
				<!--<source type="checkstyle">-->
				<!-- @type - the handler for the enrichment -->
				<!--         known types by default are: checkstyle, pmd, clover, phpunit -->

				<!-- every enrichment source can have additional configuration nodes, most probably need a logfile -->
				<!-- <file name="logs/checkstyle.xml" /> -->
				<!--</source> -->

				<!-- enrichment source -->
				<!--<source type="phpcs">-->
				<!-- @type - the handler for the enrichment -->
				<!--         known types by default are: checkstyle, pmd, clover, phpunit, phpcs -->

				<!-- every enrichment source can have additional configuration nodes, most probably need a logfile -->
				<!-- <file name="logs/phpcs.xml" /> -->
				<!--</source> -->

				<!-- PHPMessDetector -->
				<xsl:if test="/properties/property[@name='quality.phpmd.exists']">
					<source type="pmd">
						<file name="phpmd/phpmd.xml"/>
					</source>
				</xsl:if>

				<!-- PHPCS -->
				<xsl:if test="/properties/property[@name='quality.phpcs.exists']">
					<source type="phpcs">
						<file name="phpcs/phpcs.xml"/>
					</source>
					<source type="checkstyle">
						<file name="phpcs/phpcs.checkstyle.xml"/>
					</source>
				</xsl:if>

			</enrich>

			<!-- <build engine="..." enabled="true" output="..." /> -->
			<!--   @engine  - The name of the engine this build task uses, use ./phpDox - -engines to get a list of available engines -->
			<!--   @enabled - Flag to enable/disable this engine, default: enabled=true -->
			<!--   @output  - (optional) Output directory; if relative (no / as first char) it is interpreted as relative to generator/@output -->

			<!-- An engine and thus build node can have additional configuration child nodes, please check the documentation for the engine to find out more -->

			<!--  default engine "html" -->
			<build engine="html" enabled="true" output="phpdox/output/html">
				<template dir="${{phpDox.home}}/templates/html"/>
				<file extension="xhtml"/>
			</build>

		</generator>
	</project>

</phpdox>
