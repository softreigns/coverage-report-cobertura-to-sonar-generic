# coverage-report-cobertura-to-sonar-generic
transform coverage.xml to sonar generic format xml


run fastlane unit test scan() with  cobertura_xml: true

run command
	xsltproc cobertura-sonar-generic.xslt cobertura.xml > sonar-code-coverage.xml

-- sonar.properties --

sonar.language=swift
sonar.cfamily.build-wrapper-output=sonar-reports
sonar.sourceEncoding=UTF-8
sonar.objc.file.suffixes=.m,.h
sonar.cfamily.threads=12
sonar.c.file.suffixes=-
sonar.cpp.file.suffixes=-
sonar.coverageReportPaths=sonar-reports/sonar-code-coverage.xml