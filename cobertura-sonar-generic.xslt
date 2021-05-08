<?xml version="1.0"?>
<!--
    Author: Komal Singh
    Desc: Converts cobertura.xml to sonar generic report format.
	Note: Treats a hit to a line, or a greater than zero % as covered line
	Create issue for any help/question on the stylesheet : https://github.com/softreigns/coverage-report-cobertura-to-sonar-generic
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<coverage version="1">
			<xsl:for-each select="coverage/sources">
				<xsl:variable name="sourcePath" select="source"/>
			</xsl:for-each>
			<xsl:for-each select="coverage/packages/package">
				<xsl:for-each select="classes/class">
					<file>
						<xsl:attribute name="path">
							<xsl:value-of select="@filename"/>
						</xsl:attribute>
						<xsl:for-each select="lines/line">
							<lineToCover>
								<xsl:attribute name="lineNumber">
									<xsl:value-of select="@number"/>
								</xsl:attribute>
								<xsl:choose>
									<xsl:when test = "@hits > 0">
										<xsl:attribute name="covered">true</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test = "starts-with(@condition-coverage, '0%')">
												<xsl:attribute name="covered">false</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="covered">true</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</lineToCover>
						</xsl:for-each>
					</file>
				</xsl:for-each>
			</xsl:for-each>
		</coverage>
	</xsl:template>
</xsl:stylesheet>