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
        <!-- Page d'accueil -->
        <xsl:result-document href="../html/fr884-accueil.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        Corpus lyrique de Thibaut de Champagne|Accueil
                    </xsl:element>
                    <xsl:element name="link">
                        <xsl:attribute name="rel">canonical</xsl:attribute>
                        <xsl:attribute name="href">https://getbootstrap.com/docs/5.1/examples/carousel/</xsl:attribute>
                    </xsl:element>
                    
                    <!-- Bootstrap core CSS -->
                    <xsl:element name="link">
                        <xsl:attribute name="rel">stylesheet</xsl:attribute>
                        <xsl:attribute name="href">../static/bootstrap-5.1.3-dist/css/bootstrap.min.css</xsl:attribute>
                    </xsl:element>
                    <style>
                        .bd-placeholder-img {
                        font-size: 1.125rem;
                        text-anchor: middle;
                        -webkit-user-select: none;
                        -moz-user-select: none;
                        user-select: none;
                        }
                        
                        @media (min-width: 768px) {
                        .bd-placeholder-img-lg {
                        font-size: 3.5rem;
                        }
                        }
                    </style>
                    
                    <!-- Feuille de style propre au carrousel -->
                    <xsl:element name="link">
                        <xsl:attribute name="rel">stylesheet</xsl:attribute>
                        <xsl:attribute name="href">../static/bootstrap-5.1.3-dist/css/carousel.css</xsl:attribute>
                    </xsl:element>
                </head>
                <body>
                    
                    <header>
                        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="#">Corpus lyrique de Thibaut de Champagne</a>
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="navbarCollapse">
                                    <ul class="navbar-nav me-auto mb-2 mb-md-0">
                                        <li class="nav-item">
                                            <a class="nav-link active" aria-current="page" href="#">Accueil</a><!-- MAJ lien vers page d'accueil -->
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
                    
                    <main>
                        <!-- Carrousel -->
                        <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-indicators">
                                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                            </div>
                            <div class="carousel-inner">
                                <!-- Contenu du carrousel -->
                                <xsl:apply-templates select="descendant::body/div"/>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                        <!-- Marketing messaging and featurettes
                            ================================================== -->
                        <!-- Wrap the rest of the page in another container to center all the content. -->
                        <div class="container marketing">
                            <!-- Three columns of text below the carousel -->
                            <div class="row">
                                <div class="col-lg-4">
                                    <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>
                                    
                                    <h2>Heading</h2>
                                    <p>Some representative placeholder content for the three columns of text below the carousel. This is the first column.</p>
                                    <p><a class="btn btn-secondary" href="#">View details </a></p>
                                </div><!-- /.col-lg-4 -->
                                <div class="col-lg-4">
                                    <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>
                                    
                                    <h2>Heading</h2>
                                    <p>Another exciting bit of representative placeholder content. This time, we've moved on to the second column.</p>
                                    <p><a class="btn btn-secondary" href="#">View details </a></p>
                                </div><!-- /.col-lg-4 -->
                                <div class="col-lg-4">
                                    <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>
                                    
                                    <h2>Heading</h2>
                                    <p>And lastly this, the third column of representative placeholder content.</p>
                                    <p><a class="btn btn-secondary" href="#">View details </a></p>
                                </div><!-- /.col-lg-4 -->
                            </div><!-- /.row -->
                            <!-- START THE FEATURETTES
                                <div class="row featurette">
                                    <div class="col-md-7">
                                        <h2 class="featurette-heading">First featurette heading. <span class="text-muted">It’ll blow your mind.</span></h2>
                                        <p class="lead">Some great placeholder content for the first featurette here. Imagine some exciting prose here.</p>
                                    </div>
                                    <div class="col-md-5">
                                        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#eee"/><text x="50%" y="50%" fill="#aaa" dy=".3em">500x500</text></svg>
                                        
                                    </div>
                                </div>
                                 -->
                        </div><!-- fin du container -->
                        <!-- FOOTER 
                        <footer class="container">
                            <p class="float-end"><a href="#">Back to top</a></p>
                            <p> 2017–2021 Company, Inc.  <a href="#">Privacy</a>  <a href="#">Terms</a></p>
                        </footer>
                        -->
                    </main>
                    <script src="../static/bootstrap-5.1.3-dist/js/bootstrap.bundle.min.js"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="body/div">
        <xsl:choose>
            <!-- Pour le premier chansonnier, la classe du carrousel est active -->
            <xsl:when test=".[@n='1']">
                <div class="carousel-item active">
                    <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>
                    <div class="container">
                        <div class="carousel-caption text-start">
                            <h1>
                                <xsl:value-of select="./head"/>
                            </h1>
                            <p>Du texte pour présenter le chansonnier</p>
                            <p><a class="btn btn-lg btn-primary" href="#">Voir</a></p>
                        </div>
                    </div>
                </div>
            </xsl:when>
            <!-- Pour les autres chansonniers, il n'y a pas la classe active -->
            <xsl:otherwise>
                <div class="carousel-item">
                    <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>
                    <div class="container">
                        <div class="carousel-caption">
                            <h1>
                                <xsl:value-of select="./head"/>
                            </h1>
                            <p>Du texte pour présenter le chansonnier</p>
                            <p><a class="btn btn-lg btn-primary" href="#">Voir</a></p>
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>        
        
        
    </xsl:template>
    
</xsl:stylesheet>