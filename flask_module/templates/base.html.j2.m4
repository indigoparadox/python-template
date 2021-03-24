define(`roota', `$1_root')dnl
<!doctype HTML>
<html>
<head>
<title>{{ title }}</title>
changequote(`^', `$')dnl
ifelse(do_bootstrap, ^enabled$, ^<link rel="stylesheet" type="text/css" href="{{ url_for( 'static', filename='bootstrap.min.css' ) }}" />$, ^dnl$)
changequote(^`$, ^'$)dnl
<script type="text/javascript">var flaskRoot = "{{ url_for( 'main.roota(ghtmp_underscores)' ) }}";</script>
changequote(`^', `$')dnl
ifelse(do_jquery, ^enabled$, ^<script src="{{ url_for( 'static', filename='jquery.min.js' ) }}" crossorigin="anonymous"></script>$, ^dnl$)
ifelse(do_bootstrap, ^enabled$, ^<script src="{{ url_for( 'static', filename='popper.min.js' }}" crossorigin="anonymous"></script>$, ^dnl$)
ifelse(do_bootstrap, ^enabled$, ^<script src="{{ url_for( 'static', filename='bootstrap.min.js' ) }}" crossorigin="anonymous"></script>$, ^dnl$)
changequote(^`$, ^'$)dnl
<!-- <link rel="stylesheet" href="{{ url_for( 'static', filename='style.css' ) }}" /> -->
{% block scripts %}{% endblock %}
</head>
<body class="h-100 bg-dark">

<div class="container">

<div class="row">
<h1>{{ title }}</h1>
{% with flashes = get_flashed_messages() %}
{% if flashes %}
<ul class="flashes">
{% for flashed in flashes %}
<li class="flash">{{ flashed }}</li>
{% endfor %}
</ul>
{% endif %}
{% endwith %}

</div> <!-- /row -->

{% block content %}{% endblock %}

</div> <!-- /container -->

</body>
</html>
