<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Supprime les espaces non voulues-->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI">
        <xsl:result-document href="../html/fr884-princip-edition.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        Corpus lyrique de Thibaut de Champagne|Principes d'édition
                    </xsl:element>
                    <!-- Bootstrap core CSS -->
                    <xsl:element name="link">
                        <xsl:attribute name="rel">stylesheet</xsl:attribute>
                        <xsl:attribute name="href">../static/bootstrap-5.1.3-dist/css/bootstrap.min.css</xsl:attribute>
                    </xsl:element>
                </head>
                <body>
                    
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>