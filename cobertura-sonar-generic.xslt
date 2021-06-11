<?xml version="1.0"?>
<!--
    Author: Komal Singh
    Desc: Converts cobertura.xml to sonar generic report format.
	Note: Treats a hit to a line, or a greater than zero % as covered line
	Create issue for any help/question on the stylesheet : https://github.com/softreigns/coverage-report-cobertura-to-sonar-generic
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:param name="objccov" select="'false'"/>
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<coverage version="1">
			<xsl:for-each select="coverage/sources">
				<xsl:variable name="sourcePath" select="source"/>
			</xsl:for-each>
			<xsl:for-each select="coverage/packages/package">
				<xsl:for-each select="classes/class">
					<xsl:choose>
						<xsl:when test = "substring(@filename, (string-length(@filename) - string-length('.swift')) + 1) = '.swift' or $objccov = 'true'">
							<file>
								<xsl:attribute name="path">
									<xsl:value-of select="@filename"/>
								</xsl:attribute>
								<xsl:attribute name="param-cov">
									<xsl:value-of select="$objccov"/>
								</xsl:attribute>

								<xsl:attribute name="cond-path">
									<xsl:value-of select="@condition-coverage"/>
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
												<xsl:attribute name="covered">false</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>

										<xsl:if test = "@branch and @branch = 'true' and contains(@condition-coverage, '(')">
											<xsl:variable name="branchCoverageRatio" select="substring-before((substring-after(@condition-coverage , '(' )), ')')"/>
											<xsl:attribute name="branchCoverageRatio">
												<xsl:value-of select="$branchCoverageRatio"/>
											</xsl:attribute>
											<xsl:attribute name="coveredBranches">
												<xsl:value-of select="substring-before($branchCoverageRatio, '/')"/>
											</xsl:attribute>
											<xsl:attribute name="branchesToCover">
												<xsl:value-of select="substring-after($branchCoverageRatio, '/')"/>
											</xsl:attribute>
										</xsl:if>

									</lineToCover>
								</xsl:for-each>
							</file>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
		</coverage>
	</xsl:template>
</xsl:stylesheet>