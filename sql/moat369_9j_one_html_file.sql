-- add seq to spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename
DEF one_spool_fullpath_filename = '&&moat369_sw_output_fdr./&&one_spool_filename..html'

-- Check mandatory variables
@@&&fc_def_empty_var. one_spool_html_file

@@moat369_0j_html_topic_intro.sql &&one_spool_filename..html html

HOS cat &&one_spool_html_file. >> &&one_spool_fullpath_filename.

DEF step_file = '&&moat369_sw_output_fdr./step_file.sql';
HOS echo "DEF row_num = '"$(($(cat &&one_spool_html_file. | grep '<tr>' | wc -l)-1))"'" > &&step_file.
@&&step_file.
HOS rm -f &&step_file.

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/

@@moat369_0k_html_topic_end.sql &&one_spool_filename..html html N N

@@&&fc_encrypt_html. &&one_spool_fullpath_filename.

-- zip
HOS zip -mj &&moat369_zip_filename. &&one_spool_fullpath_filename. >> &&moat369_log3.

HOS rm -f &&one_spool_html_file.

UNDEF one_spool_html_file

UNDEF one_spool_fullpath_filename