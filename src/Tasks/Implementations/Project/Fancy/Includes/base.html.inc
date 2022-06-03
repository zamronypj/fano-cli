myStr : string = 
    '<!DOCTYPE html>' + LineEnding + 
    '<html>' + LineEnding + 
    '' + LineEnding + 
    '<head>' + LineEnding + 
    '    <meta charset="utf-8">' + LineEnding + 
    '    <meta http-equiv="X-UA-Compatible" content="IE=edge">' + LineEnding + 
    '    <meta name="viewport" content="width=device-width, initial-scale=1">' + LineEnding + 
    '    <title>Fano</title>' + LineEnding + 
    '    <link rel="shortcut icon" href="https://fanoframework.github.io/assets/images/favicon.png" type="image/x-icon">' + LineEnding + 
    '    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">' + LineEnding + 
    '    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">' + LineEnding + 
    '    <!-- Bulma Version 0.9.0-->' + LineEnding + 
    '    <link rel="stylesheet" href="https://unpkg.com/bulma@0.9.0/css/bulma.min.css" />' + LineEnding + 
    '' + LineEnding + 
    '    <style>' + LineEnding + 
    '        html,body {' + LineEnding + 
    '            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;' + LineEnding + 
    '        }' + LineEnding + 
    '        .hero.is-info {' + LineEnding + 
    '            background: linear-gradient(' + LineEnding + 
    '                rgba(0, 0, 0, 0.5),' + LineEnding + 
    '                rgba(0, 0, 0, 0.5)' + LineEnding + 
    '                ), url(''https://unsplash.it/1200/900?random'') no-repeat center center fixed;' + LineEnding + 
    '            -webkit-background-size: cover;' + LineEnding + 
    '            -moz-background-size: cover;' + LineEnding + 
    '            -o-background-size: cover;' + LineEnding + 
    '            background-size: cover;' + LineEnding + 
    '        }' + LineEnding + 
    '        .hero .nav, .hero.is-success .nav {' + LineEnding + 
    '            -webkit-box-shadow: none;' + LineEnding + 
    '            box-shadow: none;' + LineEnding + 
    '        }' + LineEnding + 
    '        .hero .subtitle {' + LineEnding + 
    '            padding: 3rem 0;' + LineEnding + 
    '            line-height: 1.5;' + LineEnding + 
    '        }' + LineEnding + 
    '    </style>' + LineEnding + 
    '</head>' + LineEnding + 
    '' + LineEnding + 
    '<body>' + LineEnding + 
    '    <section class="hero is-info is-fullheight">' + LineEnding + 
    '        <div class="hero-head">' + LineEnding + 
    '            <nav class="navbar">' + LineEnding + 
    '                <div class="container">' + LineEnding + 
    '                    <div class="navbar-brand">' + LineEnding + 
    '                        <a class="navbar-item" href="../">' + LineEnding + 
    '                            <h1 class="title">Fano</h1>' + LineEnding + 
    '                        </a>' + LineEnding + 
    '                        <span class="navbar-burger burger" data-target="navbarMenu">' + LineEnding + 
    '                            <span></span>' + LineEnding + 
    '                            <span></span>' + LineEnding + 
    '                            <span></span>' + LineEnding + 
    '                        </span>' + LineEnding + 
    '                    </div>' + LineEnding + 
    '                    <div id="navbarMenu" class="navbar-menu">' + LineEnding + 
    '                        <div class="navbar-end">' + LineEnding + 
    '                            <span class="navbar-item">' + LineEnding + 
    '                                <a class="button is-white is-outlined" href="/">' + LineEnding + 
    '                                    <span class="icon">' + LineEnding + 
    '                                        <i class="fa fa-home"></i>' + LineEnding + 
    '                                    </span>' + LineEnding + 
    '                                    <span>Home</span>' + LineEnding + 
    '                                </a>' + LineEnding + 
    '                            </span>' + LineEnding + 
    '                        </div>' + LineEnding + 
    '                    </div>' + LineEnding + 
    '                </div>' + LineEnding + 
    '            </nav>' + LineEnding + 
    '            </div>' + LineEnding + 
    '' + LineEnding + 
    '            {{ content }}' + LineEnding + 
    '' + LineEnding + 
    '    </section>' + LineEnding + 
    '    <script>(function() {' + LineEnding + 
    '        var burger = document.querySelector(''.burger'');' + LineEnding + 
    '        var menu = document.querySelector(''#''+burger.dataset.target);' + LineEnding + 
    '        burger.addEventListener(''click'', function() {' + LineEnding + 
    '            burger.classList.toggle(''is-active'');' + LineEnding + 
    '            menu.classList.toggle(''is-active'');' + LineEnding + 
    '        });' + LineEnding + 
    '    })();</script>' + LineEnding + 
    '</body>' + LineEnding + 
    '' + LineEnding + 
    '</html>';
