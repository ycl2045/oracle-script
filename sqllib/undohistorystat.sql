/*



--
MAXTUNED_UNDORETENTION <150000 AND MINTUNED_UNDORETENTION >7200
大于150000,需要限制其最大大小;小于7200,需要增加UNDO
--
SSOLDERRCNT
大于0;需要评估究竟是应用问题，还是UNDO太小
*/
SET LINE 200
SET SERVEROUTPUT ON
SET echo OFF
SET feedback OFF
SET heading OFF
SET pagesize 0
SET termout OFF
SET trimout ON　　　
SET trimspool ON　　
SET verify OFF

DEFINE spfile=&1


spool &spfile
DECLARE
CURSOR maxquery IS
select max(UNXPSTEALCNT) UNXPSTEALCNT,max(UNXPBLKRELCNT) UNXPBLKRELCNT,
max(UNXPBLKREUCNT) UNXPBLKREUCNT,max(EXPSTEALCNT) EXPSTEALCNT,
max(EXPBLKRELCNT) EXPBLKRELCNT,max(EXPBLKREUCNT) EXPBLKREUCNT,max(MAXQUERYLEN) MAXQUERYLEN,
max(NOSPACEERRCNT) NOSPACEERRCNT,max(TUNED_UNDORETENTION) MAXTUNED_UNDORETENTION,
min(TUNED_UNDORETENTION) MINTUNED_UNDORETENTION,max(SSOLDERRCNT) SSOLDERRCNT

from dba_hist_undostat;

BEGIN
  FOR m IN maxquery loop
  dbms_output.put_line(
  'UNXPSTEALCNT="'||m.UNXPSTEALCNT||
  '" UNXPBLKRELCNT="'||m.UNXPBLKRELCNT||
  '" UNXPBLKREUCNT="'||m.UNXPBLKREUCNT||
  '" EXPSTEALCNT="'||m.EXPSTEALCNT||
  '" EXPBLKRELCNT="'||m.EXPBLKRELCNT||
  '" EXPBLKREUCNT="'||m.EXPBLKREUCNT||
  '" NOSPACEERRCNT="'||m.NOSPACEERRCNT||
  '" MAXTUNED_UNDORETENTION="'||m.MAXTUNED_UNDORETENTION||
  '" MINTUNED_UNDORETENTION="'||m.MINTUNED_UNDORETENTION||
  '" SSOLDERRCNT="'||m.SSOLDERRCNT||
  '" MAXQUERYLEN="'||m.MAXQUERYLEN||'"');
  END loop;
END;
/
spool off;
exit;