CREATE or REPLACE TRIGGER PLMPRD3ADMIN.LXBO_4F70A3B1_EBP_DEL_TRG
AFTER DELETE OR UPDATE
ON PLMPRD3ADMIN.LXBO_4F70A3B1
FOR EACH ROW
declare
  v_count number :=0;
  v_type varchar2(128 byte);
  v_state varchar2(128 byte);
begin
if (:old.lxflags <> -1)
then
    select count(1) into v_count
    from PLMPRD3ADMIN.MXBUSTYPE M1, PLMPRD3ADMIN.MXSTATEREQ M2
    where m1.mxname in ('pgIPMEBPSummary')
    and m2.mxname in ('Pending','Accepted','Rejected')
    and m2.mxoid=:old.LXSTATE
    and m1.MXOID=:old.LXTYPE ;
    if v_count <> 0
    then
      select MXNAME into v_type from PLMPRD3ADMIN.MXBUSTYPE where MXOID=:old.LXTYPE;
      select MXNAME into v_state from PLMPRD3ADMIN.MXSTATEREQ where MXOID=:old.LXSTATE;
      insert into PLMPRD3ADMIN.DELETE_SREBPSUMMARY
        values (v_type,:old.lxname,:old.lxrev,v_state,sysdate);
    end if;
    end if;
 
end;
/