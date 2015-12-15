# core settings

# show the id of the repository that generated a log event
$c->{show_ids_in_log} = 0;

# file and directory permissions to use when creating files and directories
<<<<<<< HEAD
$c->{file_perms} = '0664';
$c->{dir_perms} = '02775';
=======
$c->{file_perms} = '0660';
$c->{dir_perms} = '02770';
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

# mod_perl version to use
$c->{apache} = 2;

# string to use in VirtualHost apache directives
$c->{virtualhost} = '';
