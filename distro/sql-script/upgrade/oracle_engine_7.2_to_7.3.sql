-- case management --

ALTER TABLE ACT_RU_CASE_EXECUTION
  ADD SUPER_EXEC_ NVARCHAR2(64);

ALTER TABLE ACT_RU_CASE_EXECUTION
  ADD REQUIRED_ NUMBER(1,0) CHECK (REQUIRED_ IN (1,0));

-- history --

ALTER TABLE ACT_HI_ACTINST
  ADD CALL_CASE_INST_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_PROCINST
  ADD SUPER_CASE_INSTANCE_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_CASEINST
  ADD SUPER_PROCESS_INSTANCE_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_CASEACTINST
  ADD REQUIRED_ NUMBER(1,0) CHECK (REQUIRED_ IN (1,0));

ALTER TABLE ACT_HI_OP_LOG
  ADD JOB_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_OP_LOG
  ADD JOB_DEF_ID_ NVARCHAR2(64);


create table ACT_HI_JOB_LOG (
    ID_ NVARCHAR2(64) not null,
    TIMESTAMP_ TIMESTAMP(6) not null,
    JOB_ID_ NVARCHAR2(64) not null,
    JOB_DUEDATE_ TIMESTAMP(6),
    JOB_RETRIES_ INTEGER,
    JOB_EXCEPTION_MSG_ NVARCHAR2(2000),
    JOB_EXCEPTION_STACK_ID_ NVARCHAR2(64),
    JOB_STATE_ INTEGER,
    JOB_DEF_ID_ NVARCHAR2(64),
    JOB_DEF_TYPE_ NVARCHAR2(255),
    JOB_DEF_CONFIGURATION_ NVARCHAR2(255),
    ACT_ID_ NVARCHAR2(64),
    EXECUTION_ID_ NVARCHAR2(64),
    PROCESS_INSTANCE_ID_ NVARCHAR2(64),
    PROCESS_DEF_ID_ NVARCHAR2(64),
    PROCESS_DEF_KEY_ NVARCHAR2(255),
    DEPLOYMENT_ID_ NVARCHAR2(64),
    SEQUENCE_COUNTER_ NUMBER(19,0),
    primary key (ID_)
);

create index ACT_IDX_HI_JOB_LOG_PROCINST on ACT_HI_JOB_LOG(PROCESS_INSTANCE_ID_);
create index ACT_IDX_HI_JOB_LOG_PROCDEF on ACT_HI_JOB_LOG(PROCESS_DEF_ID_);

-- history: add columns PROC_DEF_KEY_, PROC_DEF_ID_, CASE_DEF_KEY_, CASE_DEF_ID_ --

ALTER TABLE ACT_HI_PROCINST
  ADD PROC_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_ACTINST
  ADD PROC_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_TASKINST
  ADD PROC_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_TASKINST
  ADD CASE_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_VARINST
  ADD PROC_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_VARINST
  ADD PROC_DEF_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_VARINST
  ADD CASE_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_VARINST
  ADD CASE_DEF_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_DETAIL
  ADD PROC_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_DETAIL
  ADD PROC_DEF_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_DETAIL
  ADD CASE_DEF_KEY_ NVARCHAR2(255);

ALTER TABLE ACT_HI_DETAIL
  ADD CASE_DEF_ID_ NVARCHAR2(64);

ALTER TABLE ACT_HI_INCIDENT
  ADD PROC_DEF_KEY_ NVARCHAR2(255);

-- sequence counter

ALTER TABLE ACT_RU_EXECUTION
  ADD SEQUENCE_COUNTER_ NUMBER(19,0);

ALTER TABLE ACT_HI_ACTINST
  ADD SEQUENCE_COUNTER_ NUMBER(19,0);

ALTER TABLE ACT_RU_VARIABLE
  ADD SEQUENCE_COUNTER_ NUMBER(19,0);

ALTER TABLE ACT_HI_DETAIL
  ADD SEQUENCE_COUNTER_ NUMBER(19,0);

ALTER TABLE ACT_RU_JOB
  ADD SEQUENCE_COUNTER_ NUMBER(19,0);

-- unused columns

ALTER TABLE ACT_RU_VARIABLE 
  DROP COLUMN DATA_FORMAT_ID_;

ALTER TABLE ACT_HI_VARINST
  DROP COLUMN DATA_FORMAT_ID_;

ALTER TABLE ACT_HI_DETAIL
  DROP COLUMN DATA_FORMAT_ID_;

-- add global grant authorizations for new authorization resources:
-- DEPLOYMENT
-- PROCESS_DEFINITION
-- PROCESS_INSTANCE
-- TASK
-- with ALL permissions

INSERT ALL
  INTO ACT_RU_AUTHORIZATION (ID_, TYPE_, USER_ID_, RESOURCE_TYPE_, RESOURCE_ID_, PERMS_, REV_) VALUES ('global-grant-process-definition', 0, '*', 6, '*', 2147483647, 1)
  INTO ACT_RU_AUTHORIZATION (ID_, TYPE_, USER_ID_, RESOURCE_TYPE_, RESOURCE_ID_, PERMS_, REV_) VALUES ('global-grant-task', 0, '*', 7, '*', 2147483647, 1)
  INTO ACT_RU_AUTHORIZATION (ID_, TYPE_, USER_ID_, RESOURCE_TYPE_, RESOURCE_ID_, PERMS_, REV_) VALUES ('global-grant-process-instance', 0, '*', 8, '*', 2147483647, 1)
  INTO ACT_RU_AUTHORIZATION (ID_, TYPE_, USER_ID_, RESOURCE_TYPE_, RESOURCE_ID_, PERMS_, REV_) VALUES ('global-grant-deployment', 0, '*', 9, '*', 2147483647, 1)
SELECT * FROM dual;
