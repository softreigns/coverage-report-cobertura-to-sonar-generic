<?xml version="1.0"?>
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
											<xsl:when test = "contains(@condition-coverage, '0% (0/')">
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