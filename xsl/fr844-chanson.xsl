<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Supprime les espaces non voulues-->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="div[@type='lyrical_text']">
        <xsl:result-document href="../html/fr844-chanson-{./@xml:id}.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        <xsl:text>Corpus lyrique de Thibaut de Champagne|</xsl:text>
                        <xsl:choose>
                            <xsl:when test="./note/bibl/title/text()">
                                <xsl:value-of select="./note/bibl/title/text()"/>
                            </xsl:when>
                            <!-- Si la chanson est sans titre, on inscrit son @xml:id dans l'élément title -->
                            <xsl:otherwise>
                                <xsl:value-of select="./@xml:id"/>
                            </xsl:otherwise>
                        </xsl:choose>    
                    </xsl:element>
                    <xsl:call-template name="bootstrapCore"/>
                    <xsl:call-template name="stylePageChanson"/>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="containerChanson">
                        <h1 class="display-4 fst-italic">
                            <xsl:choose>
                                <xsl:when test="./note/bibl/title/text()">
                                    <xsl:value-of select="./note/bibl/title/text()"/>
                                </xsl:when>
                                <!-- Si la chanson est sans titre -->
                                <xsl:otherwise>
                                    <xsl:text>[Sans titre]</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </h1>
                        <div class="corpsChanson">
                            <!-- TODO ajouter image <div class="img">mon image</div>  -->
                            <div class="txt">
                                <xsl:apply-templates select="descendant::lg[@type='stanza']" mode="graphem"/>
                            </div>
                            <div class="txt">
                                <xsl:apply-templates select="descendant::lg[@type='stanza']" mode="interp"/>
                            </div>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="lg[@type='stanza']" mode="#all">
        <div>
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates select="l"  mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="l" mode="#all">
        <p>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    
    <xsl:template match="w" mode="graphem">
        <xsl:choose>  
            <xsl:when test=".[@rend='elision']">
                <xsl:apply-templates mode="graphem"/>
            </xsl:when>    
            <xsl:otherwise>
                <xsl:apply-templates mode="graphem"/>
                <xsl:text> </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="w" mode="interp">
        <xsl:choose>  
            <xsl:when test=".[@rend='elision']">
                <xsl:apply-templates mode="interp"/>
                <xsl:text>'</xsl:text>
            </xsl:when>    
            <xsl:otherwise>
                <xsl:choose>    
                    <xsl:when test="./following-sibling::pc[descendant::reg/text()]">
                        <xsl:apply-templates mode="interp"/>
                    </xsl:when>    
                    <xsl:otherwise>    
                        <xsl:apply-templates mode="interp"/>
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="app" mode="graphem">
        <xsl:apply-templates select="lem" mode="graphem"/>
    </xsl:template>
    
    <xsl:template match="app" mode="interp">
        <xsl:apply-templates select="lem" mode="interp"/>
        <!-- Les leçons rejetées en apparat -->
        <xsl:if test="./rdg[@resp='#Wallenskold']">
            <span style="color : rgb(015, 005, 230, 0.8)">
                <xsl:text> </xsl:text>
                <xsl:value-of select="./rdg[@resp='#Wallenskold']"/>
            </span>
        </xsl:if>
        <xsl:if test="./rdg[@wit='#Mt']">
            <span style="color : rgb(000, 200, 100, 0.7)">
                <xsl:text> </xsl:text>
                <xsl:value-of select="./rdg[@wit='#Mt']"/>
                <xsl:if test="./following-sibling::w">
                    <xsl:text> </xsl:text>
                </xsl:if>
            </span>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="lem" mode="#all">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="choice" mode="graphem">
        <xsl:value-of select="sic"/>
        <xsl:if test="sic[not(text())]">
            <xsl:choose>
                <xsl:when test="sic/following-sibling::corr//reg">
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select="sic/following-sibling::corr//orig"/>
                    <xsl:text>]</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>[…]</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:value-of select="orig"/>
        <xsl:value-of select="abbr"/>
    </xsl:template>
    
    <xsl:template match="choice" mode="interp">
        <xsl:value-of select=".//reg"/>
        <xsl:value-of select="expan"/>
    </xsl:template>
    
    <xsl:template match="pc" mode="#all">
        <xsl:apply-templates mode="#current"/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <!-- Style -->
    <xsl:template name="bootstrapCore">
        <xsl:element name="link">
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="href">../static/bootstrap-5.1.3-dist/css/bootstrap.min.css</xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="navbar">
        <header>
            <!-- Barre de navigation -->
            <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
                <div class="container-fluid">
                    <span class="navbar-brand">Corpus lyrique de Thibaut de Champagne</span>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <ul class="navbar-nav me-auto mb-2 mb-md-0">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="./fr844-accueil.html">Accueil</a><!-- MAJ lien vers page d'accueil -->
                            </li>
                            <!-- Ajouter des liens
                                <li class="nav-item">
                                <a class="nav-link" href="#">Link</a>
                                </li>
                            -->
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
    </xsl:template>
    
    <xsl:template name="stylePageChanson">
        <style>
            body {
            margin-top: 150px;
            }
            .containerChanson {
            background-color:  rgb(253, 245, 245);
            margin-left: 3%;
            margin-right: 3%;
            font
            }
            h1 {
            margin-bottom: 80px;
            }
            .corpsChanson {
            display: flex;
            justify-content: space-between;
            justify-content: space-around;
            }
            .img {
            }
            .txt {
            font-size: 16pt;
            font-family: "Junicode";
            }
            .stanza {
            margin-bottom: 20px;
            }
            p {
            margin-bottom: 0px;
            }
        </style>
    </xsl:template>
    
</xsl:stylesheet>